using Microsoft.VisualBasic;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.Profile;
using System;
using System.Web;

[System.ComponentModel.DataObject()]
public class DataFotografie
{
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.Categorie_FotogalleryRow GetCategoria_ByID(int idcat)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.Categorie_FotogalleryDataTable dt = new dsBattaglia.Categorie_FotogalleryDataTable();
        dt.Merge(pfAdmin.DatiFotogallery.Categorie);
        return dt.FindByIDCategoria(idcat);
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.Categorie_FotogalleryRow GetCategoria_ByFoto(int idfoto)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia dsGlobale = new dsBattaglia();
        dsBattaglia.FotografieDataTable dt = new dsBattaglia.FotografieDataTable();
        dsGlobale.Merge(pfAdmin.DatiFotogallery.Categorie);
        dt.Merge(pfAdmin.DatiFotogallery.Fotografie);

        dsGlobale.Fotografie.ImportRow(dt.FindByIDFotografia(idfoto));

        return dsGlobale.Fotografie[0].Categorie_FotogalleryRow;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.FotografieRow GetFoto(int idfoto)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.FotografieDataTable dt = new dsBattaglia.FotografieDataTable();
        dt.Merge(pfAdmin.DatiFotogallery.Fotografie);

        return dt.FindByIDFotografia(idfoto);
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.FotografieDataTable GetFotografie(DataTable dtFotografie)
    {
        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();
        mydt.Merge(dtFotografie, false, MissingSchemaAction.Ignore);
        return mydt;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public PagedDataSource GetFotografiePaging(int pageIndex,int pageSize, DataTable dtFotografie)
    {
        // Get ALL of the photos

        DataView myv = dtFotografie.DefaultView;
        myv.Sort = "IDCategoria";
        DataTable sortTb = myv.ToTable();

        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();
        mydt.Merge(sortTb, false, MissingSchemaAction.Ignore);


        // Limit the results through a PagedDataSource
        PagedDataSource pagedData = new PagedDataSource();
        pagedData.DataSource = mydt.Rows;
        pagedData.AllowPaging = true;
        pagedData.CurrentPageIndex = pageIndex;
        pagedData.PageSize = pageSize;

        return pagedData;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public PagedDataSource GetFotografiePaging_ByIDCat(int pageIndex,int pageSize, int idcat)
    {
        // Get ALL of the photos
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        DataView myv = pfAdmin.DatiFotogallery.Fotografie.DefaultView;
        myv.RowFilter = "IDCategoria=" + idcat;

        DataTable filterTb = myv.ToTable();

        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();
        mydt.Merge(filterTb, false, MissingSchemaAction.Ignore);


        // Limit the results through a PagedDataSource
        PagedDataSource pagedData = new PagedDataSource();
        pagedData.DataSource = mydt.Rows;
        pagedData.AllowPaging = true;
        pagedData.CurrentPageIndex = pageIndex;
        pagedData.PageSize = pageSize;

        return pagedData;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
    public void InsertFotografie(int IDCategoria, string UrlFoto, string Didascalia
                                , bool PrimoPiano, bool SecondoPiano,
                                DataTable dtCategorie)
    {
        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();
        mydt.Merge(dtCategorie, false, MissingSchemaAction.Ignore);
        dsBattaglia.FotografieRow myr = mydt.NewFotografieRow();
        myr.IDCategoria = IDCategoria;
        myr.UrlFoto = UrlFoto;
        myr.Didascalia = Didascalia;
        myr.DataCreazione = DateTime.Now;
        myr.PrimoPiano = PrimoPiano;
        myr.SecondoPiano = SecondoPiano;

        mydt.AddFotografieRow(myr);
        ProfileCommon profile = (ProfileCommon)HttpContext.Current.Profile;
        profile.DatiFotogallery.Fotografie.AcceptChanges();
        profile.DatiFotogallery.Fotografie = mydt.Copy();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
    public void UpdateFotografie(int IDFotografia, int IDCategoria,
                                string UrlFoto, string Didascalia,
                                bool PrimoPiano, bool SecondoPiano)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();

        mydt.Merge(pfAdmin.DatiFotogallery.Fotografie, false, MissingSchemaAction.Ignore);
        dsBattaglia.FotografieRow  myr = mydt.FindByIDFotografia(IDFotografia);
        myr.IDCategoria = IDCategoria;
        myr.UrlFoto = UrlFoto;
        myr.Didascalia = Didascalia;
        myr.DataCreazione = DateTime.Now;
        myr.PrimoPiano = PrimoPiano;
        myr.SecondoPiano = SecondoPiano;

        pfAdmin.DatiFotogallery.Fotografie.AcceptChanges();
        pfAdmin.DatiFotogallery.Fotografie = mydt.Copy();
        pfAdmin.Save();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
    public void DeleteFotografie(int IDFotografia)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();

        mydt.Merge(pfAdmin.DatiFotogallery.Fotografie, false, MissingSchemaAction.Ignore);
        dsBattaglia.FotografieRow myr = mydt.FindByIDFotografia(IDFotografia);
        myr.Delete();
        pfAdmin.DatiFotogallery.Fotografie.AcceptChanges();
        pfAdmin.DatiFotogallery.Fotografie = mydt.Copy();
        pfAdmin.Save();
    }


    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.FotografieDataTable GetFotografie_SecondoPiano()
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        DataView myv = pfAdmin.DatiFotogallery.Fotografie.DefaultView;
        myv.RowFilter = "SecondoPiano=" + bool.TrueString;
        
        DataTable filterTb = myv.ToTable();

        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();

        if( filterTb.Rows.Count > 2)
        {
            mydt.ImportRow(filterTb.Rows[0]);
            mydt.ImportRow(filterTb.Rows[1]);
        }

        else
            mydt.Merge(filterTb, false, MissingSchemaAction.Ignore);

        return mydt;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.FotografieDataTable GetFotografie_PrimoPiano()
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        DataView myv = pfAdmin.DatiFotogallery.Fotografie.DefaultView;
        myv.RowFilter = "PrimoPiano=" + bool.TrueString;

        DataTable filterTb = myv.ToTable();

        dsBattaglia.FotografieDataTable mydt = new dsBattaglia.FotografieDataTable();

        if( filterTb.Rows.Count > 1)
            mydt.ImportRow(filterTb.Rows[0]);
        else
            mydt.Merge(filterTb, false, MissingSchemaAction.Ignore);

        return mydt;
    }
}
