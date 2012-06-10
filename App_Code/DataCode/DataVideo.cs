using Microsoft.VisualBasic;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.Profile;
using System;
using System.Collections;
using Google.GData.YouTube;
using System.Collections.Generic;
using System.Linq;
using Google.YouTube;
using Google.GData.Client;

[System.ComponentModel.DataObject()]
public class DataVideo
{

#region "Categorie video"

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.Categorie_VideoDataTable GetCategorie()
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");

        dsBattaglia.Categorie_VideoDataTable mydt = new dsBattaglia.Categorie_VideoDataTable();
        mydt.Merge(pfAdmin.DatiVideo.Categorie, false, MissingSchemaAction.Ignore);

        return mydt;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
    public IEnumerable<YouTubeCategory> GetCategoriev2()
    {
        var categorie = ListVideosStudio.GetCategorieReali().OrderBy(d=>d.Label);
        return categorie;
        
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
    public void UpdateCategorie(int IDcategoria, string NomeCategoria)
    {
        ProfileCommon pfAdmin  = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.Categorie_VideoDataTable mydt = new dsBattaglia.Categorie_VideoDataTable();

        mydt.Merge(pfAdmin.DatiVideo.Categorie, false, MissingSchemaAction.Ignore);
        mydt.FindByIDCategoria(IDcategoria).NomeCategoria = NomeCategoria;
        pfAdmin.DatiVideo.Categorie.AcceptChanges();
        pfAdmin.DatiVideo.Categorie = mydt.Copy();
        pfAdmin.Save();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
    public void InsertCategorie(string NomeCategoria)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.Categorie_VideoDataTable mydt = new dsBattaglia.Categorie_VideoDataTable();

        mydt.Merge(pfAdmin.DatiVideo.Categorie, false, MissingSchemaAction.Ignore);
        mydt.AddCategorie_VideoRow(NomeCategoria);

        pfAdmin.DatiVideo.Categorie.AcceptChanges();
        pfAdmin.DatiVideo.Categorie = mydt.Copy();
        pfAdmin.Save();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
    public void DeleteCategorie(int IDCategoria)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.Categorie_FotogalleryDataTable mydt = new dsBattaglia.Categorie_FotogalleryDataTable();

        mydt.Merge(pfAdmin.DatiVideo.Categorie, false, MissingSchemaAction.Ignore);
        mydt.FindByIDCategoria(IDCategoria).Delete();

        pfAdmin.DatiVideo.Categorie.AcceptChanges();
        pfAdmin.DatiVideo.Categorie = mydt.Copy();
        pfAdmin.Save();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.Categorie_VideoRow GetCategoria_ByVideo(int idvideo)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia dsGlobale = new dsBattaglia();
        dsBattaglia.VideoDataTable dt = new dsBattaglia.VideoDataTable();
        dsGlobale.Merge(pfAdmin.DatiVideo.Categorie);
        dt.Merge(pfAdmin.DatiVideo.Video);

        dsGlobale.Video.ImportRow(dt.FindByIDVideo(idvideo));

        return dsGlobale.Video[0].Categorie_VideoRow;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
    public IEnumerable<YouTubeCategory> GetCategoria_ByVideov2(string idvideo)
    {

            var videoCat = ListVideosStudio.YourVideos().Where(d => d.VideoId == idvideo)
                .Select(d => d.Media.Categories[0].Value);

            return GetCategoria_ByIDv2(videoCat.ToList()[0]);

    }

#endregion

#region "Video Gallery"
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public PagedDataSource GetVideoPaging(int pageIndex,int pageSize, DataTable dtVideo)
    {
        if( dtVideo!= null && dtVideo.Rows.Count > 0)
        {
            DataView myv = dtVideo.DefaultView;
            myv.Sort = "IDCategoria";
            DataTable sortTb = myv.ToTable();

            dsBattaglia.VideoDataTable mydt = new dsBattaglia.VideoDataTable();
            mydt.Merge(sortTb, false, MissingSchemaAction.Ignore);


            // Limit the results through a PagedDataSource
            PagedDataSource pagedData = new PagedDataSource();
            pagedData.DataSource = mydt.Rows;
            pagedData.AllowPaging = true;
            pagedData.CurrentPageIndex = pageIndex;
            pagedData.PageSize = pageSize;

            return pagedData;
        }
        else
            return null;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public PagedDataSource GetVideoPagingv2(int pageIndex, int pageSize, IEnumerable<Video> dtVideo)
    {
        if (dtVideo != null && dtVideo.Count() > 0)
        {

            // Limit the results through a PagedDataSource
            PagedDataSource pagedData = new PagedDataSource();
            pagedData.DataSource = dtVideo.ToList();
            pagedData.AllowPaging = true;
            pagedData.CurrentPageIndex = pageIndex;
            pagedData.PageSize = pageSize;

            return pagedData;
        }
        else
            return null;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
    public void DeleteVideo(int IDVideo)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.VideoDataTable mydt = new dsBattaglia.VideoDataTable();

        mydt.Merge(pfAdmin.DatiVideo.Video, false, MissingSchemaAction.Ignore);
        dsBattaglia.VideoRow myr = mydt.FindByIDVideo(IDVideo);
        myr.Delete();
        pfAdmin.DatiVideo.Video.AcceptChanges();
        pfAdmin.DatiVideo.Video = mydt.Copy();
        pfAdmin.Save();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.VideoDataTable GetVideo()
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.VideoDataTable mydt = new dsBattaglia.VideoDataTable();
        mydt.Merge(pfAdmin.DatiVideo.Video, false, MissingSchemaAction.Ignore);
        return mydt;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.VideoRow GetVideo_ByIDVideo(int idvideo)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.VideoDataTable dt = new dsBattaglia.VideoDataTable();
        dt.Merge(pfAdmin.DatiVideo.Video);

        return dt.FindByIDVideo(idvideo);
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public IEnumerable<Video> GetVideo_ByIDVideov2(string idvideo)
    {
        var vMod = ListVideosStudio.YourVideos().Where(v => v.VideoId == idvideo);
        return vMod;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
    public void UpdateVideo(int IDVideo, int IDCategoria, string UrlVideo, string Didascalia, 
        string UrlMedia)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.VideoDataTable mydt = new dsBattaglia.VideoDataTable();

        mydt.Merge(pfAdmin.DatiVideo.Video, false, MissingSchemaAction.Ignore);
        dsBattaglia.VideoRow  myr = mydt.FindByIDVideo(IDVideo);
        myr.IDCategoria = IDCategoria;
        myr.UrlVideo = UrlVideo;
        myr.Didascalia = Didascalia;
        myr.DataCreazione = DateTime.Now;
        myr.UrlMedia = Strings.Replace(UrlMedia, "~", "",1,-1,CompareMethod.Text);

        pfAdmin.DatiVideo.Video.AcceptChanges();
        pfAdmin.DatiVideo.Video = mydt.Copy();
        pfAdmin.Save();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
    public void InsertVideo(int IDCategoria, string UrlVideo, string Didascalia
        , string UrlMedia)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.VideoDataTable mydt = new dsBattaglia.VideoDataTable();
        mydt.Merge(pfAdmin.DatiVideo.Video, false, MissingSchemaAction.Ignore);
        dsBattaglia.VideoRow myr = mydt.NewVideoRow();
        myr.IDCategoria = IDCategoria;
        myr.UrlVideo = UrlVideo;
        myr.Didascalia = Didascalia;
        myr.DataCreazione = DateTime.Now;
        myr.UrlMedia = Strings.Replace(UrlMedia, "~", "",1,-1,CompareMethod.Text);
        mydt.AddVideoRow(myr);

        pfAdmin.DatiVideo.Video.AcceptChanges();
        pfAdmin.DatiVideo.Video = mydt.Copy();
        pfAdmin.Save();
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public PagedDataSource GetVideoPaging_ByIDCat(int pageIndex,int pageSize, int idcat)
    {

        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        DataView myv = pfAdmin.DatiVideo.Video.DefaultView;
        myv.RowFilter = "IDCategoria=" + idcat;

        DataTable filterTb = myv.ToTable();

        dsBattaglia.VideoDataTable mydt = new dsBattaglia.VideoDataTable();
        mydt.Merge(filterTb, false,MissingSchemaAction.Ignore);

        PagedDataSource pagedData = new PagedDataSource();
        pagedData.DataSource = mydt.Rows;
        pagedData.AllowPaging = true;
        pagedData.CurrentPageIndex = pageIndex;
        pagedData.PageSize = pageSize;

        return pagedData;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public PagedDataSource GetVideoPaging_ByIDCatv2(int pageIndex, int pageSize, string idcat)
    {
        var videoYT = ListVideosStudio.GetVideoByCategory(idcat);
       

        PagedDataSource pagedData = new PagedDataSource();
        pagedData.DataSource = videoYT.ToList();
        pagedData.AllowPaging = true;
        pagedData.CurrentPageIndex = pageIndex;
        pagedData.PageSize = pageSize;

        return pagedData;
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public dsBattaglia.Categorie_VideoRow GetCategoria_ByID(int idcat)
    {
        ProfileCommon pfAdmin = (ProfileCommon)ProfileBase.Create("admin");
        dsBattaglia.Categorie_VideoDataTable dt = new dsBattaglia.Categorie_VideoDataTable();
        dt.Merge(pfAdmin.DatiVideo.Categorie);
        return dt.FindByIDCategoria(idcat);
    }

    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public IEnumerable<YouTubeCategory> GetCategoria_ByIDv2(string idcat)
    {
        var cat = ListVideosStudio.GetCategorieReali().Where(d => d.Term == idcat);
        return cat;
       
    }
#endregion


}
