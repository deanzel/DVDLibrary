using System;
using System.Collections.Generic;
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
            //Search("Star Wars");

            Console.ReadLine();
        }

        public static void Execute()
        {
            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            //var result = client.SearchMovie("Star Wars");

            //Console.WriteLine(result);

            Movie movie = client.GetMovie(11, MovieMethods.AlternativeTitles | MovieMethods.Credits | MovieMethods.Images);

            Console.WriteLine("Movie title: {0}", movie.Title);

            Console.WriteLine();

            Console.WriteLine(movie.ReleaseDate);

            Console.WriteLine(movie.ProductionCompanies);

            Console.WriteLine(movie.Overview);

            Console.WriteLine();

           

            Console.WriteLine();

            var images = movie.Images.Posters;

            Console.WriteLine();

            Console.WriteLine("https://image.tmdb.org/t/p/original/" + images[0].FilePath);

            foreach (var c in movie.ProductionCompanies)
            {
                Console.WriteLine("{0} - {1} ", c.Name, c.Id);
            }

            //foreach (var i in images)
            //{
            //    Console.WriteLine("https://image.tmdb.org/t/p/original/" + i.FilePath);
            //}

            var director = movie.Credits.Crew.Where(d => d.Job == "Director").Select(d => d);

            foreach (var d in director)
            {
                Console.WriteLine("The {0} is {1}", d.Job, d.Name);
            }
            


            //foreach (var crew in movie.Credits.Crew)
            //{
            //    Console.WriteLine("{0} - {1} - {2}", crew.Job, crew.Name, crew.Id);
            //}

            //foreach (var crew in movie.Credits.Cast)
            //{
            //    Console.WriteLine("{0} - {1} - {2}", crew.Name, crew.Character, crew.Id);
            //}

            //Console.WriteLine(movie.Credits.Crew);

            //foreach (var title in movie.AlternativeTitles.Titles)
            //{
            //    Console.WriteLine("Alternate title: {0}", title.Title);
            //}
        }

        public static void Search(string movieName)
        {
            TMDbClient client = new TMDbClient("1fee8f2397ff73412985de2bb825f020");

            SearchContainer<SearchMovie> results = client.SearchMovie(movieName);

            Console.WriteLine("Got {0} of {1} results", results.Results.Count, results.TotalResults);
            foreach (SearchMovie result in results.Results)
            {
                Console.WriteLine(result.Title);
                Console.WriteLine(result.Id);
                Console.WriteLine(result.ReleaseDate);
                Console.WriteLine(result.Overview);
                Console.WriteLine();
            }
        }

    }
}
