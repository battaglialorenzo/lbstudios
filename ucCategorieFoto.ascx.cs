using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ucCategorieFoto : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!Context.User.IsInRole("Amministratori"))
            {
                BindData();
            }
        }
    }

    void BindData()
    {
        rpCategorie.DataSource = Profile.GetProfile("admin").DatiFotogallery.Categorie;
        rpCategorie.DataBind();
    }

    protected void gvCat_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "New")
        {
            this.lg1.FindControl("dvCat").Visible = true;
        }
    }
    protected void dvCat_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit)
        {
            this.lg1.FindControl("dvCat").Visible = false;
        }
    }
    protected void dvCat_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        this.lg1.FindControl("dvCat").Visible = false;
        this.lg1.FindControl("gvCat").DataBind();
    }
}
