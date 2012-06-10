<%@ Page MasterPageFile="MasterSito.master" Language="VB" Title="Riccardo Battaglia - Photography: Videogallery" %>

<%@ Register Src="ucCategorieVideo.ascx" TagName="ucCategorieVideo" TagPrefix="uc1" %>

<script runat="server">

    Protected Sub objVideo_An_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs)
        e.InputParameters("dtVideo") = Profile.GetProfile("admin").DatiVideo.Video
    End Sub

    Protected Sub objVideo_An_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs)
        Dim mypg As PagedDataSource = CType(e.ReturnValue, PagedDataSource)
        If Not IsNothing(mypg) Then
            
            If mypg.PageCount > 1 Then
                CType(Me.LoginView1.FindControl("tbPager"), HtmlTable).Visible = True
                CType(Me.LoginView1.FindControl("ltPgTotali"), Literal).Text = mypg.PageCount
                CType(Me.LoginView1.FindControl("ltPgCorrente"), Literal).Text = mypg.CurrentPageIndex + 1
                CType(Me.LoginView1.FindControl("btIndietro"), LinkButton).Enabled = Not mypg.IsFirstPage
                CType(Me.LoginView1.FindControl("btAvanti"), LinkButton).Enabled = Not mypg.IsLastPage
        
            Else
                CType(Me.LoginView1.FindControl("tbPager"), HtmlTable).Visible = False
            End If
        Else
            CType(Me.LoginView1.FindControl("tbPager"), HtmlTable).Visible = False
        End If
        
    End Sub

    Protected Sub fvVideo_ModeChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewModeEventArgs)
        If e.CancelingEdit Then
            Me.LoginView1.FindControl("fvVideo").Visible = False
        End If
    End Sub

    Protected Sub fvVideo_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs)
        Me.LoginView1.FindControl("listVideo").DataBind()
        Me.LoginView1.FindControl("fvVideo").Visible = False
    End Sub

    Protected Sub listVideo_CancelCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim listvideo As DataList = CType(source, DataList)
        listvideo.EditItemIndex = -1
        listvideo.DataBind()
    End Sub

    Protected Sub listVideo_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim objvideo As ObjectDataSource = CType(Me.LoginView1.FindControl("objVideo"), ObjectDataSource)
        Dim listvideo As DataList = CType(source, DataList)

        objvideo.DeleteParameters("IDVideo").DefaultValue = listvideo.DataKeys(e.Item.ItemIndex).ToString
        objvideo.Delete()
    End Sub

    Protected Sub listVideo_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim listvideo As DataList = CType(source, DataList)
        listvideo.EditItemIndex = e.Item.ItemIndex
        listvideo.DataBind()
    End Sub

    Protected Sub listVideo_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        If e.CommandName = "New" Then
            Me.LoginView1.FindControl("fvVideo").Visible = True
        End If
    End Sub

    Protected Sub listVideo_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim listvideo As DataList = CType(source, DataList)
        Dim objvideo As ObjectDataSource = CType(Me.LoginView1.FindControl("objVideo"), ObjectDataSource)
         
        Dim url As HiddenField = CType(e.Item.FindControl("hfImgPath"), HiddenField)
        Dim urlmedia As HiddenField = CType(e.Item.FindControl("hfVideoPath"), HiddenField)

        Dim cat As DropDownList = CType(e.Item.FindControl("listCat"), DropDownList)
        Dim testo As TextBox = CType(e.Item.FindControl("txtTesto"), TextBox)
        
        objvideo.UpdateParameters("IDVideo").DefaultValue = listvideo.DataKeys(e.Item.ItemIndex).ToString
        objvideo.UpdateParameters("IDCategoria").DefaultValue = cat.SelectedValue
        objvideo.UpdateParameters("Didascalia").DefaultValue = testo.Text
        objvideo.UpdateParameters("UrlVideo").DefaultValue = url.Value
        objvideo.UpdateParameters("UrlMedia").DefaultValue = urlmedia.Value

        objvideo.Update()
        listvideo.EditItemIndex = -1
    End Sub

    Protected Sub listVideo_An_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or _
           e.Item.ItemType = ListItemType.AlternatingItem Then

            Dim dsGlobale As New dsBattaglia
            dsGlobale.Merge(Profile.GetProfile("admin").DatiVideo.Categorie)
            Dim dt As New dsBattaglia.VideoDataTable
            Dim myr As dsBattaglia.VideoRow = CType(e.Item.DataItem, dsBattaglia.VideoRow)
            dt.ImportRow(myr)
            dsGlobale.Merge(dt)
        
            Dim ltCat As Literal = CType(e.Item.FindControl("ltCategoria"), Literal)
            ltCat.Text = dsGlobale.Video(0).Categorie_VideoRow.NomeCategoria
        
        End If
    End Sub

    Protected Sub btIndietro_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("objVideo_An"), ObjectDataSource).SelectParameters("pageIndex").DefaultValue -= 1
        CType(Me.LoginView1.FindControl("listVideo_An"), DataList).DataBind()
    End Sub

    Protected Sub btAvanti_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("objVideo_An"), ObjectDataSource).SelectParameters("pageIndex").DefaultValue += 1
        CType(Me.LoginView1.FindControl("listVideo_An"), DataList).DataBind()
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
                                        <asp:LoginView ID="LoginView1" runat="server">
                                            <AnonymousTemplate>
                                                <asp:DataList ID="listVideo_An" runat="server" CellPadding="5" RepeatColumns="3"
                                                    RepeatDirection="Horizontal" DataSourceID="objVideo_An" OnItemDataBound="listVideo_An_ItemDataBound"
                                                    Style="height: 280px">
                                                    <ItemStyle Width="180px" Height="137px" HorizontalAlign="Center" VerticalAlign="Top" />
                                                    <ItemTemplate>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 180px; height: 125px; background-color: #cccccc" align="center"
                                                                    valign="middle">
                                                                    <a href="javascript:void(0);" onclick="MM_openBrWindow('popupVideo.aspx?codvideo=<%# Eval("IDVideo") %>','','scrollbars=yes,width=500,height=500');">
                                                                        <img alt="" src="<%# Eval("UrlVideo", "imghandler.ashx?w=161&amp;img={0}") %>" style="border-style: none" /></a></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle" style="background-color: #FFFFFF" class="titoloboxhome">
                                                                    <asp:Literal ID="ltCategoria" runat="server" /></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList><asp:ObjectDataSource ID="objVideo_An" runat="server" OnSelecting="objVideo_An_Selecting"
                                                    SelectMethod="GetVideoPaging" TypeName="DataVideo" OnSelected="objVideo_An_Selected">
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
                                            </AnonymousTemplate>
                                            <LoggedInTemplate>
                                                <asp:DataList ID="listVideo" runat="server" CellPadding="5" RepeatColumns="3" RepeatDirection="Horizontal"
                                                    Width="100%" DataKeyField="IDVideo" DataSourceID="objVideo" OnItemCommand="listVideo_ItemCommand"
                                                    OnEditCommand="listVideo_EditCommand" OnCancelCommand="listVideo_CancelCommand"
                                                    OnUpdateCommand="listVideo_UpdateCommand" OnDeleteCommand="listVideo_DeleteCommand">
                                                    <ItemStyle Width="160px" Height="137px" HorizontalAlign="Center" VerticalAlign="Bottom" />
                                                    <ItemTemplate>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td align="right" style="background-color: #cccccc" valign="middle">
                                                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete"
                                                                        Text="x" ToolTip="Cancella" BackColor="#C00000" BorderStyle="None" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="12px" ForeColor="White" OnClientClick="return confirm('Stai per cancellare un video. Confermare?')"
                                                                        Width="20px" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="background-color: #cccccc; width: 125px; height: 125px; padding-right: 5px;
                                                                    padding-left: 5px; padding-bottom: 5px; padding-top: 5px;" align="center" valign="middle">
                                                                    <asp:ImageButton ID="btImg" runat="server" ImageUrl='<%# Eval("UrlVideo", "~/imghandler.ashx?w=150&img={0}") %>'
                                                                        CommandName="Edit" CausesValidation="False" ToolTip="Modifica" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle" style="background-color: #ffffff" class="titoloboxhome">
                                                                    <asp:Literal ID="ltdidascalia" runat="server" Text='<%# Eval("Didascalia") %>'></asp:Literal></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:Button ID="Button1" runat="server" CommandName="New" Text="Aggiungi" Font-Names="Verdana"
                                                            Font-Size="10px" BackColor="#149B99" BorderStyle="None" Font-Bold="True" ForeColor="White" />
                                                    </HeaderTemplate>
                                                    <SeparatorTemplate>
                                                        &nbsp;
                                                    </SeparatorTemplate>
                                                    <HeaderStyle Height="50px" />
                                                    <EditItemTemplate>

                                                        <script language="javascript" type="text/javascript">
                                                            var gallery1;
                                                            var receiver1 = {id:"0",imageGalleryPath:"img/news",imageGalleryUrl:"GalleriaImmagini.aspx?tipo=CartellaFoto"};
                                                            receiver1.InsertHtml = GetImageUrl1;
                                                            var FTB_API = new Array();

                                                            function ShowGallery1(obj)
                                                            { 
                                                                FTB_API[ 0] = receiver1;
                                                                var url = obj.imageGalleryUrl.replace(/\\{{0\\}}/g,obj.imageGalleryPath);
                                                                url += "&ftb=" + obj.id;
                                                                gallery1 = window.open(url,'gallery','width=700,height=600,toolbars=0,resizable=1');
                                                                gallery1.focus();
                                                            }
                                                            
                                                            function GetImageUrl1(content)
                                                            {
                                                                FTB_API[ 0] = receiver1;
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').src = '../imghandler.aspx?w=80&img=' + gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                                gallery1.window.close()
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("noimg").ClientID %>').style.display = 'inline';
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("hfImgPath").ClientID %>').value = gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                            }
                                                            
                                                            function DelImg1()
                                                            {
                                                                FTB_API[ 0] = receiver1;
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("noimg").ClientID %>').style.display = 'none';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').src = '../aspnet_client/FreeTextBox/utility/spacer.gif';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').style.width = '';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').style.height = '';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("hfImgPath").ClientID %>').value = '';
                                                            }
                                                        </script>

                                                        <script language="javascript" type="text/javascript">
                                                            var galleryVideo1;
                                                            var receiverVideo1 = {id:"0",videoGalleryPath:"img/video",videoGalleryUrl:"GalleriaVideo.aspx?tipo=CartellaVideo"};
                                                            receiverVideo1.InsertHtml = GetVideoUrl1;
                                                            var FTB_APIVideo = new Array();
                                                            FTB_APIVideo[ 0] = receiverVideo1;

                                                            function ShowGalleryVideo1(obj)
                                                            { 
                                                                var url = obj.videoGalleryUrl.replace(/\\{{0\\}}/g,obj.videoGalleryPath);
                                                                url += "&ftb=" + obj.id;
                                                                galleryVideo1 = window.open(url,'gallery','width=700,height=600,toolbars=0,resizable=1');
                                                                galleryVideo1.focus();
                                                            }
                                                            
                                                            function GetVideoUrl1(content)
                                                            {
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("myvideo").ClientID %>').innerHTML = galleryVideo1.document.getElementById('div_video').innerHTML
                                                                galleryVideo1.window.close()
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("novideo").ClientID %>').style.display = 'inline';
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("hfVideoPath").ClientID %>').value = galleryVideo1.document.getElementById('img_cartella').value.replace("..","") + '/' + galleryVideo1.document.getElementById('video_nome').value;
                                                            }
                                                            
                                                            function DelVideo1()
                                                            {
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("novideo").ClientID %>').style.display = 'none';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("myvideo").ClientID %>').innerHTML = '';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listVideo"),datalist).Items(ctype(me.loginview1.findcontrol("listVideo"),datalist).EditItemIndex).FindControl("hfVideoPath").ClientID %>').value = '';
                                                            }
                                                        </script>

                                                        <table style="border-right: #149b99 1px solid; border-top: #149b99 1px solid; border-left: #149b99 1px solid;
                                                            border-bottom: #149b99 1px solid" border="0" cellpadding="5" cellspacing="0"
                                                            width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="listCat" CssClass="titoloboxhome"
                                                                        Text="Categoria:"></asp:Label></td>
                                                                <td>
                                                                    <asp:DropDownList ID="listCat" runat="server" DataSourceID="objCat" DataTextField="NomeCategoria"
                                                                        DataValueField="IDCategoria" SelectedValue='<%# Bind("IDCategoria") %>' Font-Names="Verdana"
                                                                        Font-Size="10px">
                                                                    </asp:DropDownList></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="txtTesto" CssClass="titoloboxhome"
                                                                        Text="Didascalia:"></asp:Label></td>
                                                                <td style="width: 100px">
                                                                    <asp:TextBox ID="txtTesto" runat="server" Text='<%# Bind("Didascalia") %>' Width="104px"
                                                                        Font-Names="Verdana" Font-Size="10px"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="Label2" runat="server" CssClass="titoloboxhome" Text="Immagine:" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="5" cellspacing="0">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:HyperLink ID="lkGalleria" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/utility/folder.small.gif"
                                                                                    NavigateUrl="javascript:ShowGallery1(receiver1);" ToolTip="Cambia" /></td>
                                                                            <td>
                                                                                <span id="noimg" runat="server">
                                                                                    <asp:HyperLink ID="DelImg" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/images/delete.gif"
                                                                                        NavigateUrl="javascript:DelImg1();" ToolTip="Rimuovi" /></span></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <asp:Image ID="imgFoto" runat="server" ImageUrl='<%# IIF(Eval("UrlVideo").tostring().length > 3 ,Eval("UrlVideo","~/imghandler.aspx?w=80&img={0}"),"~/aspnet_client/freetextbox/utility/spacer.gif") %>' /></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="Label8" runat="server" CssClass="titoloboxhome" Text="Video:" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="5" cellspacing="0">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:HyperLink ID="lkGalleriaVideo" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/utility/media.gif"
                                                                                    NavigateUrl="javascript:ShowGalleryVideo1(receiverVideo1);" />
                                                                            </td>
                                                                            <td>
                                                                                <span id="novideo" runat="server">
                                                                                    <asp:HyperLink ID="HyperLink2" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/images/delete.gif"
                                                                                        NavigateUrl="javascript:DelVideo1();" /></span>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <div id="myvideo" runat="server">
                                                                        <%#IIf(Eval("UrlMedia").ToString().Length > 3, Eval("UrlMedia", "<script language=""javascript"" type=""text/javascript"">" _
                                                                                                                                                                                                                                          & "document.write('<object width=""100"" height=""100"" '" _
                                                                                                                                                                                                                                          & "+'classid=""CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6"" border=""0"">'" _
                                                                                                                                                                                                                                          & "+'<param name=""autoStart"" value=""False"">'" _
                                                                                                                                                                                                                                          & "+'<param name=""PlayCount"" value=""1"">'" _
                                                                                                                                                                                                                                          & "+'<param name=""Url"" value=""{0}"">'" _
                                                                                                                                                                                                                                          & "+'<embed type=""application/x-mplayer2"" '" _
                                                                                                                                                                                                                                          & "+'pluginspage=""http://www.microsoft.com/Windows/Downloads/Contents/MediaPlayer/"" '" _
                                                                                                                                                                                                                                          & "+'showcontrols=""true"" showstatusbar=""false"" uimode=""full"" width=""100"" height=""100"" '" _
                                                                                                                                                                                                                                          & "+'src=""{0}"" autostart=""false"" loop=""true"" showdisplay=""false"" autorewind=""true"">'" _
                                                                                                                                                                                                                                          & "+'<\/object>');" _
                                                                                                                                                                                                                                          & "</script>"), "")%>
                                                                    </div>
                                                                    <asp:HiddenField ID="hfVideoPath" runat="server" Value='<%# Bind("UrlMedia") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                                        Text="Aggiorna" CssClass="titoloboxhome" ForeColor="#149B99"></asp:LinkButton></td>
                                                                <td>
                                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                        Text="Annulla" CssClass="titoloboxhome" ForeColor="#FF8000"></asp:LinkButton></td>
                                                            </tr>
                                                        </table>
                                                        <asp:HiddenField ID="hfImgPath" runat="server" Value='<%# Bind("UrlVideo") %>' />
                                                    </EditItemTemplate>
                                                    <EditItemStyle HorizontalAlign="Left" />
                                                </asp:DataList>
                                                <asp:FormView ID="fvVideo" runat="server" CellPadding="0" DataKeyNames="IDVideo"
                                                    DataSourceID="objVideoS" DefaultMode="Insert" Visible="False" Width="100%" OnModeChanging="fvVideo_ModeChanging"
                                                    OnItemInserted="fvVideo_ItemInserted">
                                                    <InsertItemTemplate>

                                                        <script language="javascript" type="text/javascript">
                                                            var gallery1;
                                                            var receiver1 = {id:"0",imageGalleryPath:"img/news",imageGalleryUrl:"GalleriaImmagini.aspx?tipo=CartellaFoto"};
                                                            receiver1.InsertHtml = GetImageUrl1;
                                                            var FTB_API = new Array();

                                                            function ShowGallery1(obj)
                                                            { 
                                                                FTB_API[ 0] = receiver1;
                                                                var url = obj.imageGalleryUrl.replace(/\\{{0\\}}/g,obj.imageGalleryPath);
                                                                url += "&ftb=" + obj.id;
                                                                gallery1 = window.open(url,'gallery','width=700,height=600,toolbars=0,resizable=1');
                                                                gallery1.focus();
                                                            }
                                                            
                                                            function GetImageUrl1(content)
                                                            {
                                                                FTB_API[ 0] = receiver1;
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("imgFoto").ClientID %>').src = '../imghandler.aspx?w=80&img=' + gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                                gallery1.window.close()
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("noimg").ClientID %>').style.display = 'inline';
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("hfImgPath").ClientID %>').value = gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                            }
                                                            
                                                            function DelImg1()
                                                            {
                                                                FTB_API[ 0] = receiver1;
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("noimg").ClientID %>').style.display = 'none';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("imgFoto").ClientID %>').src = '../aspnet_client/FreeTextBox/utility/spacer.gif';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("imgFoto").ClientID %>').style.width = '';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("imgFoto").ClientID %>').style.height = '';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("hfImgPath").ClientID %>').value = '';
                                                            }
                                                        </script>

                                                        <script language="javascript" type="text/javascript">
                                                            var galleryVideo1;
                                                            var receiverVideo1 = {id:"0",videoGalleryPath:"img/video",videoGalleryUrl:"GalleriaVideo.aspx?tipo=CartellaVideo"};
                                                            receiverVideo1.InsertHtml = GetVideoUrl1;
                                                            var FTB_APIVideo = new Array();
                                                            FTB_APIVideo[ 0] = receiverVideo1;

                                                            function ShowGalleryVideo1(obj)
                                                            { 
                                                                var url = obj.videoGalleryUrl.replace(/\\{{0\\}}/g,obj.videoGalleryPath);
                                                                url += "&ftb=" + obj.id;
                                                                galleryVideo1 = window.open(url,'gallery','width=700,height=600,toolbars=0,resizable=1');
                                                                galleryVideo1.focus();
                                                            }
                                                            
                                                            function GetVideoUrl1(content)
                                                            {
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("myvideo").ClientID %>').innerHTML = galleryVideo1.document.getElementById('div_video').innerHTML
                                                                galleryVideo1.window.close()
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("novideo").ClientID %>').style.display = 'inline';
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("hfVideoPath").ClientID %>').value = galleryVideo1.document.getElementById('img_cartella').value.replace("..","") + '/' + galleryVideo1.document.getElementById('video_nome').value;
                                                            }
                                                            
                                                            function DelVideo1()
                                                            {
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("novideo").ClientID %>').style.display = 'none';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("myvideo").ClientID %>').innerHTML = '';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvVideo").FindControl("hfVideoPath").ClientID %>').value = '';
                                                            }
                                                        </script>

                                                        <table border="0" cellpadding="5" cellspacing="0" style="border-right: #149b99 1px solid;
                                                            border-top: #149b99 1px solid; border-left: #149b99 1px solid; border-bottom: #149b99 1px solid">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label4" runat="server" CssClass="titoloboxhome" Text="Categoria:"></asp:Label></td>
                                                                <td>
                                                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="objCat" DataTextField="NomeCategoria"
                                                                        DataValueField="IDCategoria" SelectedValue='<%# Bind("IDCategoria") %>' Font-Names="Verdana"
                                                                        Font-Size="10px">
                                                                    </asp:DropDownList></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label6" runat="server" CssClass="titoloboxhome" Text="Didascalia:"></asp:Label></td>
                                                                <td>
                                                                    <asp:TextBox ID="DidascaliaTextBox" runat="server" Text='<%# Bind("Didascalia") %>'
                                                                        Width="104px" Font-Names="Verdana" Font-Size="10px"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="Label5" runat="server" CssClass="titoloboxhome" Text="Immagine:"></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="5" cellspacing="0">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:HyperLink ID="lkGalleria" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/utility/folder.small.gif"
                                                                                    NavigateUrl="javascript:ShowGallery1(receiver1);" ToolTip="Carica" /></td>
                                                                            <td>
                                                                                <span id="noimg" runat="server" style="display: none">
                                                                                    <asp:HyperLink ID="DelImg" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/images/delete.gif"
                                                                                        NavigateUrl="javascript:DelImg1();" ToolTip="Rimuovi" /></span>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <asp:Image ID="imgFoto" runat="server" ImageUrl='~/aspnet_client/freetextbox/utility/spacer.gif' /></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="Label7" runat="server" CssClass="titoloboxhome" Text="Video:"></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="5" cellspacing="0">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:HyperLink ID="lkGalleriaVideo" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/utility/media.gif"
                                                                                    NavigateUrl="javascript:ShowGalleryVideo1(receiverVideo1);" />
                                                                            </td>
                                                                            <td>
                                                                                <span id="novideo" style="display: none" runat="server">
                                                                                    <asp:HyperLink ID="HyperLink2" runat="server" ImageUrl="~/aspnet_client/FreeTextBox/images/delete.gif"
                                                                                        NavigateUrl="javascript:DelVideo1();" /></span>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <div id="myvideo" runat="server">
                                                                    </div>
                                                                    <asp:HiddenField ID="hfVideoPath" runat="server" Value='<%# Bind("UrlMedia") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                                        Text="Inserisci" CssClass="titoloboxhome" ForeColor="#149B99"></asp:LinkButton></td>
                                                                <td>
                                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                        Text="Annulla" CssClass="titoloboxhome" ForeColor="#FF8000"></asp:LinkButton></td>
                                                            </tr>
                                                        </table>
                                                        <asp:HiddenField ID="hfImgPath" runat="server" Value='<%# Bind("UrlVideo") %>' />
                                                    </InsertItemTemplate>
                                                </asp:FormView>
                                                <asp:ObjectDataSource ID="objVideo" runat="server" SelectMethod="GetVideo" TypeName="DataVideo"
                                                    OldValuesParameterFormatString="original_{0}" UpdateMethod="UpdateVideo" DeleteMethod="DeleteVideo">
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="IDVideo" Type="Int32" />
                                                        <asp:Parameter Name="IDCategoria" Type="Int32" />
                                                        <asp:Parameter Name="UrlVideo" Type="String" />
                                                        <asp:Parameter Name="UrlMedia" Type="String" />
                                                        <asp:Parameter Name="Didascalia" Type="String" />
                                                    </UpdateParameters>
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="IDVideo" Type="Int32" />
                                                    </DeleteParameters>
                                                </asp:ObjectDataSource>
                                                <asp:ObjectDataSource ID="objVideoS" runat="server" TypeName="DataVideo" InsertMethod="InsertVideo">
                                                    <InsertParameters>
                                                        <asp:Parameter Name="IDCategoria" Type="Int32" />
                                                        <asp:Parameter Name="UrlVideo" Type="String" />
                                                        <asp:Parameter Name="UrlMedia" Type="String" />
                                                        <asp:Parameter Name="Didascalia" Type="String" />
                                                    </InsertParameters>
                                                </asp:ObjectDataSource>
                                                <asp:ObjectDataSource ID="objCat" runat="server" SelectMethod="GetCategorie" TypeName="DataVideo">
                                                </asp:ObjectDataSource>
                                            </LoggedInTemplate>
                                        </asp:LoginView>
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
