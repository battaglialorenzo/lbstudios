using Microsoft.VisualBasic;
using System.Data;
using System.Web;

public class DataBattaglia
{

    public dsBattaglia.Categorie_FotogalleryDataTable GetCategorie(DataTable dtCategorie)
    {
        dsBattaglia.Categorie_FotogalleryDataTable mydt = new dsBattaglia.Categorie_FotogalleryDataTable();
        mydt.Merge(dtCategorie, false, MissingSchemaAction.Ignore);
        return mydt;
    }

    public void UpdateCategorie(int IDcategoria, string NomeCategoria,
        DataTable dtCategorie)
    {
        dsBattaglia.Categorie_FotogalleryDataTable mydt = new dsBattaglia.Categorie_FotogalleryDataTable();
        mydt.Merge(dtCategorie, false, MissingSchemaAction.Ignore);
        mydt.FindByIDCategoria(IDcategoria).NomeCategoria = NomeCategoria;
        ProfileCommon profile = (ProfileCommon)HttpContext.Current.Profile;
        profile.DatiFotogallery.Categorie = mydt.Copy();
    }

    public void InsertCategorie(string NomeCategoria, DataTable dtCategorie)
    {
        dsBattaglia.Categorie_FotogalleryDataTable mydt = new dsBattaglia.Categorie_FotogalleryDataTable();
        mydt.Merge(dtCategorie, false, MissingSchemaAction.Ignore);
        mydt.AddCategorie_FotogalleryRow(NomeCategoria);
        ProfileCommon profile = (ProfileCommon)HttpContext.Current.Profile;
        profile.DatiFotogallery.Categorie = mydt.Copy();
    }

    public void DeleteCategorie(int IDCategoria, DataTable dtCategorie)
    {
        dsBattaglia.Categorie_FotogalleryDataTable mydt = new dsBattaglia.Categorie_FotogalleryDataTable();
        mydt.Merge(dtCategorie, false, MissingSchemaAction.Ignore);
        mydt.FindByIDCategoria(IDCategoria).Delete();
        ProfileCommon profile = (ProfileCommon)HttpContext.Current.Profile;
        profile.DatiFotogallery.Categorie = mydt.Copy();
    }
}
