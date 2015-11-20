using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibrary.Data;
using DVDLibrary.Models;

namespace DVDLibrary.Tests
{
    class MockDVDRepo : IDVDLibraryRepo
    {
        public List<Movie> RetrieveMoviesListFromDB()
        {
            throw new NotImplementedException();
        }

        public List<DVD> RetrieveFullDVDInfoFromDB(int movieId)
        {
            throw new NotImplementedException();
        }

        public List<DVD> RetrievePartialDVDsInfo(int movieId)
        {
            throw new NotImplementedException();
        }

        public DVD AddNewDVDToDBViaTMDB(DVD newDVD)
        {
            throw new NotImplementedException();
        }

        public Movie ReturnMovieInfoFromTMDB(int tmdbNum)
        {
            throw new NotImplementedException();
        }

        public Borrower AddNewBorrowerToDB(Borrower newBorrower)
        {
            throw new NotImplementedException();
        }

        public List<Borrower> RetrieveSmallListOfBorrowers()
        {
            throw new NotImplementedException();
        }

        public List<Borrower> RetrieveFullBorrowersList()
        {
            throw new NotImplementedException();
        }

        public Response CheckIfOwnerAlreadyExistsInDb()
        {
            throw new NotImplementedException();
        }

        public CollectionStats RetrieveCollectionStats()
        {
            throw new NotImplementedException();
        }

        public List<SearchTMDBResult> RetrieveTMDBSearchResults(string movieName)
        {
            throw new NotImplementedException();
        }

        public RentalTicket RentDVDSendToDb(RentalTicket rentalTicket)
        {
            throw new NotImplementedException();
        }

        public Response ReturnDVDToDb(int statusId)
        {
            throw new NotImplementedException();
        }

        public Response RemoveDVDFromDb(int dvdId)
        {
            throw new NotImplementedException();
        }

        public Response AddUserRatingToDb(UserRating newRating)
        {
            throw new NotImplementedException();
        }
    }
}
