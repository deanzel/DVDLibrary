using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibrary.Data;
using DVDLibrary.Models;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;

namespace DVDLibrary.Tests
{
    [TestFixture]
    public class RepositoryTests
    {
        public string TestSetupConnectionString;
        public string TestConnectionString = @"Server=MS-STDN-010\SQL2014;User=sa;Password=sqlserver;Database=TestDVDLibrary;";
        public DVDLibraryRepo repo = new DVDLibraryRepo();

        [TestFixtureSetUp]
        public void Init()
        {
            //TestConnectionString = @"Server=MS-STDN-010\SQL2014;User=sa;Password=sqlserver;Database=TestDVDLibrary;";

            TestSetupConnectionString = ConfigurationManager.ConnectionStrings["Setup"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(TestSetupConnectionString))
            {
                string scriptLoc = @"C:\_repos\DVDLibrary\DVDLibrary.Tests\sql\dbsetup.sql";
                //string scriptLoc = @"DVDLibrary.Tests\sql\dbsetup.sql";

                string script = File.ReadAllText(scriptLoc);

                Server server = new Server(new ServerConnection(cn));

                server.ConnectionContext.ExecuteNonQuery(script);

            };

            //No using statement (keep SQL connection open)
            //cn.open (no using statement so the SQL connection only opens up once)
        }

        [TestFixtureTearDown]
        public void Dispose()
        {
            //cn.close
            //cn.dispose
            //looks like I don't need it
        }


        //Test RetrieveMoviesListFromDB()
        [Test]
        public void TestRetrieveMoviesListFromDB()
        {
            int moviesCount = repo.RetrieveMoviesListFromDB().Count;

            Assert.AreEqual(28, moviesCount);

            //**Note the test database only has 27 movies initially but #28 is added in the Unit Testing procedure;
            //If all the tests are run together all at once, as the tests are run in alphabetic order, 28 is the number of movies returned
            //If this test is run individually, the count of 27 returned
        }


        //Test RetrieveFullDVDInfoFromDB()
        [TestCase(1, "Star Wars: Episode IV - A New Hope")]
        [TestCase(2, "Star Wars: Episode V - The Empire Strikes Back")]
        [TestCase(26, "Taken")]
        public void TestRetrieveFullDVDInfoFromDB(int movieId, string expected)
        {
            var result = repo.RetrieveFullDVDInfoFromDB(movieId)[0].Movie.MovieTitle;

            Assert.AreEqual(result, expected);
        }


        //Test RetrievePartialDVDsInfo()
        [TestCase(1, "Star Wars: Episode IV - A New Hope")]
        [TestCase(2, "Star Wars: Episode V - The Empire Strikes Back")]
        [TestCase(26, "Taken")]
        public void TestRetrievePartialDVDsInfo(int movieId, string expected)
        {
            var result = repo.RetrievePartialDVDsInfo(movieId)[0].Movie.MovieTitle;

            Assert.AreEqual(result, expected);
        }


        //Test RetrieveMovieIdFromDVDId
        [TestCase(1, 1)]
        [TestCase(25, 6)]
        [TestCase(50, 16)]
        public void TestRetrieveMovieIdFromDVDId(int dvdId, int expected)
        {
            var result = repo.RetrieveMovieIdFromDVDId(dvdId);

            Assert.AreEqual(result, expected);
        }


        //Test ReturnMovieInfoFromTMDB()
        [TestCase(24428, "The Avengers")]
        [TestCase(12, "Finding Nemo")]
        public void TestReturnMovieInfoFromTMDB(int tmdbNum, string expected)
        {
            var result = repo.ReturnMovieInfoFromTMDB(tmdbNum).MovieTitle;

            Assert.AreEqual(result, expected);
        }


        //Test AddNewDVDToDBViaTMDB()
        [Test]
        public void TestAddNewDVDToDBViaTMDB()
        {
            //Adding The Avengers (2012) - TMDB# 24428
            var newDVD = new DVD();
            newDVD.Movie = repo.ReturnMovieInfoFromTMDB(24428);
            newDVD.DVDType = "Blu-Ray";

            var newDVDId = repo.AddNewDVDToDBViaTMDB(newDVD).DVDId;

            Assert.AreEqual(newDVDId, 75);
        }


        //Test AddNewBorrowerToDB()
        [Test]
        public void TestAddNewBorrowerToDB()
        {
            Borrower newBorrower = new Borrower()
            {
                IsOwner = false,
                FirstName = "Pizza",
                LastName = "King",
                Email = "pizzaking@pizza.com",
                Address = "1234 Pizza Blvd",
                City = "New York City",
                State = "NY",
                Zipcode = "10001",
                Phone = "855-911-1337"
            };

            var result = repo.AddNewBorrowerToDB(newBorrower).BorrowerId;

            Assert.AreEqual(result, 10);
        }


        //Test RetrieveSmallListOfBorrowers()
        [Test]
        public void TestRetrieveSmallListOfBorrowers()
        {
            var result = repo.RetrieveSmallListOfBorrowers();

            Assert.AreEqual(result.Count, 10);
            Assert.AreEqual(result[0].FirstName, "Dean");

            //**Note: If this test is run all together with other tests, count is 10 (due to AddBorrower test)
            //If this test is run individually, count is 9
        }

        //Test RetrieveFullBorrowersList()
        [Test]
        public void TestRetrieveFullBorrowersList()
        {
            var result = repo.RetrieveFullBorrowersList();

            Assert.AreEqual(result.Count, 10);
            Assert.AreEqual(result[0].FirstName, "Dean");
            //**Note: If this test is run all together with other tests, count is 10 (due to AddBorrower test)
            //If this test is run individually, count is 9
        }


        //Test CheckIfOwnerAlreadysExistsInDVb()
        [Test]
        public void TestCheckIfOwnerAlreadyExistsInDb()
        {
            var result = repo.CheckIfOwnerAlreadyExistsInDb();

            Assert.AreEqual(result, 1);
        }


        //Test RetrieveCollectionStats()
        [Test]
        public void TestRetrieveCollectionStats()
        {
            var result = repo.RetrieveCollectionStats();

            Assert.AreEqual(result.MoviesCount, 28);
            //**Note: If this test is run all together with other tests, movies count is 28 (due to AddMovie test)
            //If this test is run individually, count is 27.
        }


        //Test RetrieveTMDBSearchResults()
        [Test]
        public void TestRetrieveTMDBSearchResults()
        {
            var result = repo.RetrieveTMDBSearchResults("Spirited Away");

            Assert.AreEqual(result.Count, 1);
            Assert.AreEqual(result[0].TMDBNum, 129);
        }

        //Test RentDVDSendToDb()
        [Test]
        public void TestRentDVDSendToDb()
        {
            RentalTicket newRental = new RentalTicket()
            {
                DVDId = 2,
                BorrowerId = 1,
                DateBorrowed = DateTime.Now.Date
            };

            var result = repo.RentDVDSendToDb(newRental).BorrowerStatusId;

            Assert.AreEqual(result, 30);
        }


        //Test ReturnDVDToDb()
        [Test]
        public void TestReturnDVDToDb()
        {
            var result = repo.ReturnDVDToDb(30);

            Assert.AreEqual(result, 1);
            //**Note this will only pass with all the tests together as it returns the DVD just rented out above
        }


        //Test RemoveDVDFromDb()
        [Test]
        public void TestRemoveDVDFromDb()
        {
            //Removes DVDID 12 which is Copy 6 of Star Wars: Episode IV - A New Hope (DVD)
            repo.RemoveDVDFromDb(12);

            int dvdsCount = 0;
            using (SqlConnection cn = new SqlConnection(TestConnectionString))
            {
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "select count(DVDs.MovieID) from DVDs where MovieID=1";
                cmd.Connection = cn;
                cn.Open();

                dvdsCount = int.Parse(cmd.ExecuteScalar().ToString());

            }
            Assert.AreEqual(dvdsCount, 5);
        }


        //Test AddUserRatingToDb()
        [Test]
        public void TestAddUserRatingToDb()
        {
            UserRating newRating = new UserRating()
            {
                BorrowerId = 9,
                MovieId = 1,
                Rating = 5,
                Owner = false,
            };

            repo.AddUserRatingToDb(newRating);

            int ratingsCount = 0;
            using (SqlConnection cn = new SqlConnection(TestConnectionString))
            {
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "select count(UserRatings.MovieID) from UserRatings where MovieID=1";
                cmd.Connection = cn;
                cn.Open();

                ratingsCount = int.Parse(cmd.ExecuteScalar().ToString());

            }
            Assert.AreEqual(ratingsCount, 2);
        }

    }
}