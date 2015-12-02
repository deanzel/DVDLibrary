using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibrary.Tests
{
    [TestFixture]
    public class RepositoryTests
    {
        [TestFixtureSetUp]
        public void Init()
        {
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
        }

        [Test]
        public void Test()
        {

        }
    }
}