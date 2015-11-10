using System.Configuration;

namespace DVDLibrary.Data.Config
{
    public static class Settings
    {
        private static string _connectionString;

        public static string ConnectionString
        {
            get
            {
                if (string.IsNullOrEmpty(_connectionString))
                {
                    _connectionString = ConfigurationManager.ConnectionStrings["DVDLibrary"].ConnectionString;
                }

                return _connectionString;
            }
        }
    }
}
