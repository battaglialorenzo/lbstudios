Imports System.Data

Partial Class ucBoxSecondoPiano
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dvFoto As DataView = Me.objSecondoPiano.Select
        Dim dt1 As New dsBattaglia.FotografieDataTable
        Dim dt2 As New dsBattaglia.FotografieDataTable

        dt1.ImportRow(dvFoto(0).Row)
        dt2.ImportRow(dvFoto(1).Row)

        Me.rpSec1.DataSource = dt1
        Me.rpSec2.DataSource = dt2

        Me.rpSec1.DataBind()
        Me.rpSec2.DataBind()

    End Sub

    Protected Sub rpSec2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rpSec2.ItemDataBound, rpSec1.ItemDataBound
        If (e.Item.ItemType = ListItemType.Item) Or _
                    (e.Item.ItemType = ListItemType.AlternatingItem) Then

            Dim dsGlobale As New dsBattaglia
            dsGlobale.Merge(Profile.GetProfile("admin").DatiFotogallery.Categorie)
            Dim dt As New dsBattaglia.FotografieDataTable
            Dim myr As dsBattaglia.FotografieRow = CType(e.Item.DataItem, Data.DataRowView).Row
            dt.ImportRow(myr)
            dsGlobale.Merge(dt)

            Dim ltCat As Literal = CType(e.Item.FindControl("ltCategoria"), Literal)
            ltCat.Text = dsGlobale.Fotografie(0).Categorie_FotogalleryRow.NomeCategoria


        End If


    End Sub
End Class
