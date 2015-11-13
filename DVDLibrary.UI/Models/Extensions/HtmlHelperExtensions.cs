using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DVDLibrary.UI.Models.Extensions
{
    public static class HtmlHelperExtensions
    {
        public static MvcHtmlString PlaceHolderTextBox(this HtmlHelper htmlHelper, string name, string placeHolderText)
        {
            var builder = new TagBuilder("input");
            builder.MergeAttribute("type", "text");
            builder.MergeAttribute("name", name);
            builder.MergeAttribute("id", name);
            builder.MergeAttribute("placeholder", placeHolderText);

            return MvcHtmlString.Create(builder.ToString(TagRenderMode.SelfClosing));
        }

        public static MvcHtmlString PlaceHolderTextBox(this HtmlHelper htmlHelper, string name, string placeHolderText, string className)
        {
            var builder = new TagBuilder("input");
            builder.MergeAttribute("type", "text");
            builder.MergeAttribute("name", name);
            builder.MergeAttribute("id", name);
            builder.MergeAttribute("class", className);
            builder.MergeAttribute("placeholder", placeHolderText);

            return MvcHtmlString.Create(builder.ToString(TagRenderMode.SelfClosing));
        }
    }
}