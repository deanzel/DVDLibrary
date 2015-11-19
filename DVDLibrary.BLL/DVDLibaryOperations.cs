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
        private DVDLibraryRepo _repo;

        public DVDLibaryOperations()
        {
            _repo = new DVDLibraryRepo();    
        }

        public List<DVD> ReturnDVDsList()
        {
            return _repo.RetrieveDVDsList();
        }

        public List<Models.Movie> ReturnMoviesList()
        {
            return _repo.RetrieveMoviesList();
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

        //Return list of Borrowers from DB
        public List<Borrower> ReturnBorrowersList()
        {
            return _repo.RetrieveListOfBorrowers();
        } 


        //Rent DVD (send to DB)
        public RentalTicket RentDVD(RentalTicket rentalTicket)
        {
            return _repo.RentDVDSendToDb(rentalTicket);
        }

        //Return DVD based on StatusId (send to DB)
        public int ReturnDVD(int statusId)
        {
            return _repo.ReturnDVDToDb(statusId);
        }
    }
}
