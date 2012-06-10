using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Google.GData.YouTube;
using Google.GData.Client;
using Google.YouTube;

public partial class test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        YouTubeQuery query = new YouTubeQuery(YouTubeQuery.DefaultUploads);

        AtomCategory category1 = new AtomCategory("People");

        query.Categories.Add(new QueryCategory(category1));


        Feed<Video> videoFeed = ListVideosStudio.GetRequest().Get<Video>(query);
        Repeater1.DataSource = videoFeed.Entries;
        Repeater1.DataBind();

    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item ||
            e.Item.ItemType == ListItemType.AlternatingItem)
        { 
            
        }
    }
}