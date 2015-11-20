using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibrary.Data;
using DVDLibrary.Models;
using RestSharp.Extensions;
using TMDbLib.Client;
using Movie = TMDbLib.Objects.Movies.Movie;

namespace DVDLibrary.BLL
{
    public class DVDLibaryOperations
    {
        private IDVDLibraryRepo _repo;


        public DVDLibaryOperations()
        {
            _repo = new DVDLibraryRepo();
        }

        //Real one from SQL DB
        public List<Models.Movie> ReturnMoviesListFromDB()
        {
            return _repo.RetrieveMoviesListFromDB();
        }

        //Real Full DVDs and Movie Info from SQL DB
        public List<DVD> ReturnDvdsFromDbForMovieId(int movieId)
        {
            return _repo.RetrieveFullDVDInfoFromDB(movieId);
        }

        //Partial DVDs List info from SQL DB
        public List<DVD> ReturnPartialDVDsInfo(int movieId)
        {
            return _repo.RetrievePartialDVDsInfo(movieId);
        } 

        //Add a New Borrower To DB
        public Borrower AddNewBorrower(Borrower newBorrower)
        {
            return _repo.AddNewBorrowerToDB(newBorrower);
        }

        //Check if Owner is already in the DB
        public Response CheckIfOwnerAlreadyExists()
        {
            return _repo.CheckIfOwnerAlreadyExistsInDb();
        }

        //Need
        public Models.Movie ReturnMovie(int id)
        {
            return _repo.ReturnMovieInfoFromTMDB(id);
        }

        //Add movie To SQL Database
        public DVD AddMovieToDB(DVD addDVDInfo)
        {
            return _repo.AddNewDVDToDBViaTMDB(addDVDInfo);
        }

        
        //Getting TMDB Search results depending on Movie name string
        public List<SearchTMDBResult> ReturnTMDBSearchResults(string movieName)
        {
            return _repo.RetrieveTMDBSearchResults(movieName);
        }


        //Get Collection Stats from DB
        public CollectionStats ReturnCollectionStats()
        {
            return _repo.RetrieveCollectionStats();
        }

        //Return compact list of Borrowers from DB
        public List<Borrower> ReturnSmallBorrowersList()
        {
            return _repo.RetrieveSmallListOfBorrowers();
        } 

        //Return full list of Borrowers and their Rental Statuses from DB
        public List<Borrower> ReturnFullBorrowersList()
        {
            return _repo.RetrieveFullBorrowersList();
        } 


        //Rent DVD (send to DB)
        public RentalTicket RentDVD(RentalTicket rentalTicket)
        {
            return _repo.RentDVDSendToDb(rentalTicket);
        }

        //Return DVD based on StatusId (send to DB)
        public Response ReturnDVD(int statusId)
        {
            return _repo.ReturnDVDToDb(statusId);
        }


        //Remove DVD from Database via DVDID (get back MovieID for redirect)
        public Response RemoveDVD(int dvdId)
        {
            return _repo.RemoveDVDFromDb(dvdId);
        }

        //Add or Update UserRating to DB
        public Response AddUserRating(UserRating newRating)
        {
            return _repo.AddUserRatingToDb(newRating);
        }

    }
}
