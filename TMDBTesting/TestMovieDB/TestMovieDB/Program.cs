using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TMDbLib.Client;
using TMDbLib.Objects.General;
using TMDbLib.Objects.Movies;
using TMDbLib.Objects.Search;

namespace TestMovieDB
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            Execute();
            //Search();

            Console.ReadLine();
        }


        public static void Execute()
        {
            Console.Write("Please enter the movie ID (TMDB) that you want to look up (11 is Star Wars): ");
            string input = Console.ReadLine();

            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            Movie movie = client.GetMovie(input, MovieMethods.AlternativeTitles | MovieMethods.Credits | MovieMethods.Images | MovieMethods.Releases | MovieMethods.Videos);

            Console.Clear();


            Console.WriteLine("Movie Name: {0}", movie.Title);

            Console.WriteLine("Movie TMDBNum: {0}", movie.Id);

            Console.WriteLine("MPAA Rating: {0}", movie.Releases.Countries.FirstOrDefault(m => m.Iso_3166_1 == "US").Certification);

            Console.WriteLine("Release Date: {0}", movie.ReleaseDate.Value.ToString("yyyy-MM-dd"));

            Console.WriteLine("Synopsis: {0}", movie.Overview);

            Console.WriteLine("Duration: {0} mins", movie.Runtime);

            Console.WriteLine("PosterUrl: {0}", "https://image.tmdb.org/t/p/original" + movie.PosterPath);

            Console.WriteLine("Movie Studio: {0} (ID {1})", movie.ProductionCompanies[0].Name, movie.ProductionCompanies[0].Id);

            Console.WriteLine("Director: {0} (ID {1})", movie.Credits.Crew.FirstOrDefault(d => d.Job == "Director").Name, movie.Credits.Crew.FirstOrDefault(d => d.Job == "Director").Id);

            Console.WriteLine("List of Genres:");
            foreach (var g in movie.Genres)
            {
                Console.WriteLine("{0} - {1}", g.Name, g.Id);
            }

            Console.WriteLine("Youtube trailer");
            Console.WriteLine(movie.Video);
            foreach (var t in movie.Videos.Results)
            {
                Console.WriteLine("Site: {0}", t.Site);
                Console.WriteLine("ID: {0}", t.Id);
                Console.WriteLine("Iso_639_1: {0}", t.Iso_639_1);
                Console.WriteLine("Key: {0}", t.Key);
                Console.WriteLine("Name: {0}", t.Name);
                Console.WriteLine("Size: {0}", t.Size);
                Console.WriteLine("Type: {0}", t.Type);
                Console.WriteLine();
            }

            Console.WriteLine();

            Console.WriteLine("List of First 15 Actors!!");

            for (int i = 0; i < 15; i++)
            {
                Console.WriteLine("{0} - plays {1} - (ID {2})", movie.Credits.Cast[i].Name, movie.Credits.Cast[i].Character, movie.Credits.Cast[i].Id);
            }

            Console.WriteLine();

            Console.WriteLine("List of Alternate US Titles");
            foreach (var t in movie.AlternativeTitles.Titles)
            {
                if (t.Iso_3166_1 == "US")
                {
                    Console.WriteLine("{0} - {1}", t.Title, t.Iso_3166_1);
                }
            }
            
        }

        public static void Search()
        {
            Console.Write("Please enter the name of the movie that you want to add: ");
            string input = Console.ReadLine();

            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            SearchContainer<SearchMovie> results = client.SearchMovie("\"" + input + "\"");

            Console.WriteLine("Page: {0}", results.Page);
            Console.WriteLine("Total Pages: {0}", results.TotalPages);

            Console.WriteLine();

            Console.WriteLine("Got {0} of {1} results", results.Results.Count, results.TotalResults);
            foreach (SearchMovie result in results.Results)
            {
                Console.WriteLine(result.Title);
                Console.WriteLine(result.Id);
                Console.WriteLine(result.ReleaseDate);
                Console.WriteLine(result.Overview);
                Console.WriteLine(result.PosterPath);
                Console.WriteLine(result.GenreIds[0]);
                Console.WriteLine();
            }

            Console.WriteLine(results.TotalPages);

        }

    }
}
