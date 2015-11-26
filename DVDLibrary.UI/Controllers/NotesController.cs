using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DVDLibrary.BLL;
using DVDLibrary.Models;

namespace DVDLibrary.UI.Controllers
{
    public class NotesController : ApiController
    {

        //Grab a dynamic list of User Notes based on the MovieID
        public List<UserNote> Get(int id)
        {
            var oops = new DVDLibaryOperations();

            return oops.ReturnUserNotes(id);
        }


        //Post a new User Note
        public HttpResponseMessage Post(UserNote newNote)
        {
            var oops = new DVDLibaryOperations();

            return new HttpResponseMessage(HttpStatusCode.Created);
        }

        //Create a RenderAction for a partial view
    }
}
