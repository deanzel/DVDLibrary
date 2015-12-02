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
        public string TestConnectionString;
        public DVDLibraryRepo repo = new DVDLibraryRepo();

        [TestFixtureSetUp]
        public void Init()
        {
            //TestConnectionString = @"Server=MS-STDN-010\SQL2014;User=sa;Password=sqlserver;Database=TestDVDLibrary;";

            TestConnectionString = ConfigurationManager.ConnectionStrings["Setup"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(TestConnectionString))
            {
                string scriptLoc = @"C:\_repos\DVDLibrary\DVDLibrary.Tests\sql\dbsetup.sql";
                //string scriptLoc = @"DVDLibrary.Tests\sql\dbsetup.sql";

                string script = File.ReadAllText(scriptLoc);

                Server server = new Server(new ServerConnection(cn));

                server.ConnectionContext.ExecuteNonQuery(script);

            };

            //var oops = new DVDLibaryOperations();
            //Include SQL script (dbsetup.sql) and run via ADO
            //Script drops TestDVDLibrary database and then creates it, the tables, stored procedures
            //and then fills the data (everything except for comments so far)

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

            Assert.AreEqual(27, moviesCount);

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



    }
}