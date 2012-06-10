using System;
using System.Configuration;
using System.Web;
using System.Collections.Generic;
using Google.GData.Client;
using Google.GData.YouTube;
using Google.YouTube;
using System.Net;
using System.Linq;
using System.Xml;
using Google.GData.Extensions.MediaRss;

internal class YouTubeCategoryCollection : AtomBase
{
    public YouTubeCategoryCollection()
    {
        this.ProtocolMajor = VersionDefaults.VersionTwo;
    }


    public override AtomBase CreateAtomSubElement(XmlReader reader, AtomFeedParser parser)
    {
        if (reader == null)
        {
            throw new ArgumentNullException("reader");
        }
        if (parser == null)
        {
            throw new ArgumentNullException("parser");
        }

        Object localname = reader.LocalName;
        if (localname.Equals(parser.Nametable.Category))
        {
            return new YouTubeCategory();
        }
        return base.CreateAtomSubElement(reader, parser);
    }

    /// <summary>Returns the constant representing this XML element.</summary>
    public override string XmlName
    {
        get { return null; }
    }
}

public static class ListVideosStudio
{
    public static string YTNomeAppicazione = "Studio Battaglia";
    public static string YTDevKey = "AI39si5Q9rnKe_bIu8AKTOd5vaw-Bz3jd3nRSR2cx6sBUBBhiphlw0ZUOf8r-jmfhcteRIl5rog4BMyv1srevQCnPx_quQKuXg";
    //public static string YTClientID = ConfigurationManager.AppSettings["youtube_clientid"];
    public static string YTUserName = "BattagliaRiccardo";
    public static string YTPassword = "capricorno8";


    public static string GetImmagine(object val)
    {
        var retVal = string.Empty;

        var img =
            val as Google.GData.Extensions.ExtensionCollection<MediaThumbnail>;

        if (img != null)
            if (img.Count > 0)
                retVal = img[0].Url;

        return retVal;
    }


    public static IEnumerable<Video> MostPopular()
    {
        return GetVideos(YouTubeQuery.MostViewedVideo);
    }

    public static IEnumerable<Video> YourVideos()
    {
        return GetVideos(YouTubeQuery.DefaultUploads);
    }

    public static IEnumerable<Video> GetVideoByCategory(string term)
    {
        YouTubeQuery query = new YouTubeQuery(YouTubeQuery.DefaultUploads);
        AtomCategory catTerm = new AtomCategory(term);

        query.Categories.Add(new QueryCategory(catTerm));
        return GetVideos(query);

    }

    public static IEnumerable<Video> MostCommented()
    {
        return GetVideos(YouTubeQuery.MostDiscussedVideo);
    }

    public static void Update(Video v)
    {
        GetRequest().Update(v);
    }



    public static IEnumerable<Playlist> PlayLists()
    {
        Feed<Playlist> feed = null;
        var request = GetRequest();


        try
        {
            feed = request.GetPlaylistsFeed(null);
        }
        catch (GDataRequestException gdre)
        {
            var response = (HttpWebResponse)gdre.Response;
        }
        return feed != null ? feed.Entries : null;
    }


    public static YouTubeRequest GetRequest()
    {
        var request = HttpContext.Current.Session["YTRequest"] as YouTubeRequest;
        if (request == null)
        {
            var settings = new YouTubeRequestSettings(YTNomeAppicazione, YTDevKey,
                                                      YTUserName, YTPassword) { AutoPaging = true };

            request = new YouTubeRequest(settings);


            HttpContext.Current.Session["YTRequest"] = request;
            HttpContext.Current.Session["token"] = request.Service.QueryClientLoginToken();
        }
        return request;
    }

    public static IEnumerable<Video> Search(string videoQuery, string author, string orderby, bool racy, string time, string category)
    {
        var query = new YouTubeQuery(YouTubeQuery.TopRatedVideo);
        if (String.IsNullOrEmpty(videoQuery) != true)
        {
            query.Query = videoQuery;
        }
        if (String.IsNullOrEmpty(author) != true)
        {
            query.Author = author;
        }
        if (String.IsNullOrEmpty(orderby) != true)
        {
            query.OrderBy = orderby;
        }
        if (racy)
        {
            query.SafeSearch = YouTubeQuery.SafeSearchValues.None;
        }
        if (String.IsNullOrEmpty(time) != true)
        {
            switch (time)
            {
                case "All Time":
                    query.Time = YouTubeQuery.UploadTime.AllTime;
                    break;
                case "Today":
                    query.Time = YouTubeQuery.UploadTime.Today;
                    break;
                case "This Week":
                    query.Time = YouTubeQuery.UploadTime.ThisWeek;
                    break;
                case "This Month":
                    query.Time = YouTubeQuery.UploadTime.ThisMonth;
                    break;
            }
        }
        if (String.IsNullOrEmpty(category) != true)
        {
            var q = new QueryCategory(new AtomCategory(category));
            query.Categories.Add(q);
        }
        return GetVideos(query);
    }



    private static IEnumerable<Video> GetVideos(string videofeed)
    {
        var query = new YouTubeQuery(videofeed);
        return GetVideos(query);
    }

    private static IEnumerable<Video> GetVideos(YouTubeQuery q)
    {
        var request = GetRequest();
        Feed<Video> feed = null;

        try
        {
            feed = request.Get<Video>(q);
        }
        catch (GDataRequestException gdre)
        {
            var response = (HttpWebResponse)gdre.Response;
        }
        return feed != null ? feed.Entries : null;
    }

    public static IEnumerable<YouTubeCategory> GetCategorie()
    {
        IEnumerable<YouTubeCategory> categorie = null;

        try
        {
            var atomURI = new Uri("http://gdata.youtube.com/schemas/2007/categories.cat?hl=it");
            var atURI = new AtomUri(atomURI);

            var atomCat = YouTubeQuery.GetCategories(atomURI, new YouTubeCategoryCollection());

            categorie = atomCat.Cast<YouTubeCategory>();
        }
        catch (GDataRequestException gdre)
        {
            var response = (HttpWebResponse)gdre.Response;
        }

        return categorie != null ? categorie : null;
    }

    public static IEnumerable<YouTubeCategory> GetCategorieReali()
    {
        IEnumerable<YouTubeCategory> categorie = null;

        try
        {
            var atomURI = new Uri("http://gdata.youtube.com/schemas/2007/categories.cat?hl=it");
            var atURI = new AtomUri(atomURI);

            var atomCat = YouTubeQuery.GetCategories(atomURI, new YouTubeCategoryCollection());

            categorie = atomCat.Cast<YouTubeCategory>();


            var videoCat = ListVideosStudio.YourVideos().Select(d=>d.Media.Categories[0].Value).Distinct().ToArray();
            var reale = from dati in categorie
                        where videoCat.Contains(dati.Term)
                        select dati;

            return reale;

        }
        catch (GDataRequestException gdre)
        {
            var response = (HttpWebResponse)gdre.Response;
        }

        return categorie != null ? categorie : null;
    }

    public static void ModificaVideo(string Title, string Description, string Uploader, string Author, string Content, string Summary, string VideoId)
    {

        var videoEntryUrl = "http://gdata.youtube.com/feeds/api/videos/" + VideoId;

        var q = from v in YourVideos()
                where v.VideoId == VideoId
                select v;

        if (q.Any())
        {
            var v = q.Take(1).Single();

            v.Media.Description.Value = Description;
            Update(v);
        }


    }

    public static void ModificaVideoLinq(string Title, string Description, string VideoId)
    {

        var ric = GetRequest();
        var vMod = ric.GetVideoFeed(YTUserName).Entries.Single(v => v.VideoId == VideoId);
        if (vMod != null)
        {
            vMod.Title = Title;
            vMod.Description = Description;

            ric.Update(vMod);
        }


    }

    public static void EliminaVideoLinq(string VideoId)
    {

        var ric = GetRequest();
        var vDel = ric.GetVideoFeed(YTUserName).Entries.Single(v => v.VideoId == VideoId);
        if (vDel != null)
        {
            ric.Delete(vDel);
        }


    }



}
