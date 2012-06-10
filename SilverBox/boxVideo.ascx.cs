using System;
using System.Linq;
using System.Web.UI;
using System.Text;

public partial class SilverBox_boxVideo : System.Web.UI.UserControl
{
    public string UrlVideo
    {
        get { return ViewState["UrlVideo"].ToString(); }
        set { ViewState["UrlVideo"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        //var sb = new StringBuilder();
        //sb.AppendLine("var cnt = document.getElementById(\"mediaspace\");");
        //sb.AppendLine("var src = 'SilverBox/wmvplayer.xaml';");
        //sb.AppendLine("var cfg = {file:'" + this.UrlVideo + "',height:'340',width:'440',autostart:'true'};");
        //sb.AppendLine("var ply = new jeroenwijering.Player(cnt,src,cfg);");

        //Page.ClientScript.RegisterStartupScript(typeof(Page), "boxVideo", sb.ToString()
        //    , true);

    }


}
