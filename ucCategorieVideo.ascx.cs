using System.Web.UI;
using System;
using System.Web.UI.WebControls;

public partial class ucCategorieVideo : UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            if (!Context.User.IsInRole("Amministratori"))
                BindData();
    }

    void BindData()
    {
        rpCategorie.DataSource = Profile.GetProfile("admin").DatiVideo.Categorie;
        rpCategorie.DataBind();
    }

    protected void gvCat_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "New")
            lg1.FindControl("dvCat").Visible = true;

    }

    protected void dvCat_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit)
            lg1.FindControl("dvCat").Visible = false;

    }

    protected void dvCat_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        lg1.FindControl("dvCat").Visible = false;
        lg1.FindControl("gvCat").DataBind();

    }


}
