using System.Web.UI;
using System;
using System.Web.UI.WebControls;
using System.Data;

public partial class Login : Page
{

    protected void Button1_Click(object sender, EventArgs e){
        string valcat = (this.LoginView1.FindControl("txtCat") as TextBox).Text;
        dsBattaglia.Categorie_FotogalleryDataTable mydt = new dsBattaglia.Categorie_FotogalleryDataTable();

        mydt.Merge(Profile.DatiFotogallery.Categorie, true, MissingSchemaAction.Ignore);

        mydt.AddCategorie_FotogalleryRow(valcat);
        DataTable mycopy = mydt.Copy();

        Profile.DatiFotogallery.Categorie = mycopy;
        this.BindData();
    }

    void BindData(){
        DropDownList rpList = this.LoginView1.FindControl("listCat") as DropDownList;
        rpList.DataSource = Profile.DatiFotogallery.Categorie;
        rpList.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if( User.IsInRole("Amministratori"))
            if(! Page.IsPostBack)
                this.BindData();

    }
}
