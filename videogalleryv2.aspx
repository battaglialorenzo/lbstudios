<%@ Page MasterPageFile="MasterSito.master" Language="VB" Title="Riccardo Battaglia - Photography: Videogallery" %>

<%@ Register Src="ucCategorieVideov2.ascx" TagName="ucCategorieVideo" TagPrefix="uc1" %>

<script runat="server">

    Protected Sub objVideo_An_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs)
        Dim videoYT = ListVideosStudio.YourVideos

        e.InputParameters("dtVideo") = videoYT 'Profile.GetProfile("admin").DatiVideo.Video
    End Sub

    Protected Sub objVideo_An_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs)
        Dim mypg As PagedDataSource = CType(e.ReturnValue, PagedDataSource)
        If Not IsNothing(mypg) Then
            
            If mypg.PageCount > 1 Then
                tbPager.Visible = True
                ltPgTotali.Text = mypg.PageCount
                ltPgCorrente.Text = mypg.CurrentPageIndex + 1
                btIndietro.Enabled = Not mypg.IsFirstPage
                btAvanti.Enabled = Not mypg.IsLastPage
        
            Else
                tbPager.Visible = False
            End If
        Else
            tbPager.Visible = False
        End If
        
    End Sub


    Protected Sub listVideo_An_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or _
           e.Item.ItemType = ListItemType.AlternatingItem Then

            'Dim dsGlobale As New dsBattaglia
            'dsGlobale.Merge(Profile.GetProfile("admin").DatiVideo.Categorie)
            'Dim dt As New dsBattaglia.VideoDataTable
            'Dim myr As dsBattaglia.VideoRow = CType(e.Item.DataItem, dsBattaglia.VideoRow)
            'dt.ImportRow(myr)
            'dsGlobale.Merge(dt)
        
            'Dim ltCat As Literal = CType(e.Item.FindControl("ltCategoria"), Literal)
            'ltCat.Text = dsGlobale.Video(0).Categorie_VideoRow.NomeCategoria
        
        End If
    End Sub

    Protected Sub btIndietro_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        objVideo_An.SelectParameters("pageIndex").DefaultValue -= 1
        listVideo_An.DataBind()
    End Sub

    Protected Sub btAvanti_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        objVideo_An.SelectParameters("pageIndex").DefaultValue += 1
        listVideo_An.DataBind()
    End Sub
</script>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucCategorieVideo ID="UcCategorieVideo1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <th align="left" valign="top" style="background-color: #EBEBEB" scope="row">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th style="height: 61px; background-color: #149b99" align="left" valign="bottom"
                            class="titolo" scope="row">
                            <table width="100%" border="0" cellspacing="15">
                                <tr>
                                    <th align="left" valign="bottom" class="titolo" scope="row">
                                        Videogallery</th>
                                </tr>
                            </table>
                        </th>
                    </tr>
                    <tr>
                        <th align="left" valign="top" scope="row">
                            <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                <tr>
                                    <th align="left" valign="top" scope="row">
                                                <asp:DataList ID="listVideo_An" runat="server" CellPadding="5" RepeatColumns="3"
                                                    RepeatDirection="Horizontal" DataSourceID="objVideo_An" OnItemDataBound="listVideo_An_ItemDataBound"
                                                    Style="height: 280px">
                                                    <ItemStyle Width="180px" Height="137px" HorizontalAlign="Center" VerticalAlign="Top" />
                                                    <ItemTemplate>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 180px; height: 125px; background-color: #cccccc" align="center"
                                                                    valign="middle">
                                                                    <a href="javascript:void(0);" onclick="MM_openBrWindow('popupVideov2.aspx?codvideo=<%# Eval("VideoId") %>','','scrollbars=yes,width=550,height=550');">
                                                                        <img alt="" src="<%# ListVideosStudio.GetImmagine(Eval("Thumbnails"))%>" width="161" style="border-style: none" /></a></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle" style="background-color: #FFFFFF" class="titoloboxhome">
                                                                    <%#Eval("Title","{0}")%></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList><asp:ObjectDataSource ID="objVideo_An" runat="server" OnSelecting="objVideo_An_Selecting"
                                                    SelectMethod="GetVideoPagingv2" TypeName="DataVideo" OnSelected="objVideo_An_Selected">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="0" Name="pageIndex" Type="Int32" />
                                                        <asp:Parameter DefaultValue="6" Name="pageSize" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%" id="tbPager"
                                                    runat="server">
                                                    <tr>
                                                        <td align="center" class="testoboxhome" valign="bottom">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="370">
                                                                <tr>
                                                                    <td align="left" valign="middle" style="width: 15px">
                                                                        <img alt="Indietro" height="9" src="img/freccia_indietro.jpg" width="5" /></td>
                                                                    <td align="left" valign="middle" style="width: 70px">
                                                                        <asp:LinkButton ID="btIndietro" runat="server" CssClass="titoloboxhome" CausesValidation="false"
                                                                            Text="Indietro" OnClick="btIndietro_Click" />
                                                                    </td>
                                                                    <td align="center" class="testoboxhome" valign="middle" style="width: 200px">
                                                                        | pagina
                                                                        <asp:Literal ID="ltPgCorrente" runat="server"></asp:Literal>
                                                                        di
                                                                        <asp:Literal ID="ltPgTotali" runat="server"></asp:Literal>
                                                                        |
                                                                    </td>
                                                                    <td align="right" valign="middle" style="width: 70px">
                                                                        <asp:LinkButton ID="btAvanti" runat="server" CssClass="titoloboxhome" Text="Avanti"
                                                                            CausesValidation="false" OnClick="btAvanti_Click" /></td>
                                                                    <td align="right" valign="middle" style="width: 15px">
                                                                        <img alt="Avanti" height="9" src="img/freccia_avanti.jpg" width="5" /></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                    </th>
                                </tr>
                            </table>
                        </th>
                    </tr>
                </table>
            </th>
            <td style="width: 11px" align="right" valign="top">
                <img alt="" src="img/destraflash.jpg" width="11" height="402" /></td>
        </tr>
    </table>
</asp:Content>
