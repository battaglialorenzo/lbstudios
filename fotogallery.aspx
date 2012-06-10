<%@ Page MasterPageFile="MasterSito.master" Language="VB" Title="Riccardo Battaglia - Photography: Fotogallery" %>

<%@ Register Src="ucCategorieFoto.ascx" TagName="ucCategorieFoto" TagPrefix="uc1" %>

<script runat="server">

    Protected Sub listFoto_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        If e.CommandName = "New" Then
            Me.LoginView1.FindControl("fvFoto").Visible = True
            CType(source, DataList).Enabled = False
        End If
    End Sub

    Protected Sub fvFoto_ModeChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewModeEventArgs)
        If e.CancelingEdit Then
            CType(Me.LoginView1.FindControl("listFoto"), DataList).Enabled = True
            Me.LoginView1.FindControl("fvFoto").Visible = False
        End If
    End Sub

    Protected Sub fvFoto_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs)
        CType(Me.LoginView1.FindControl("listFoto"), DataList).Enabled = True
        Me.LoginView1.FindControl("listFoto").DataBind()
        Me.LoginView1.FindControl("fvFoto").Visible = False
    End Sub

    Protected Sub objFoto_An_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs)
        e.InputParameters("dtFotografie") = Profile.GetProfile("admin").DatiFotogallery.Fotografie
    End Sub

    Protected Sub objFoto_An_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs)
        Dim mypg As PagedDataSource = CType(e.ReturnValue, PagedDataSource)
        If mypg.PageCount > 1 Then
            CType(Me.LoginView1.FindControl("tbPager"), HtmlTable).Visible = True
            CType(Me.LoginView1.FindControl("ltPgTotali"), Literal).Text = mypg.PageCount
            CType(Me.LoginView1.FindControl("ltPgCorrente"), Literal).Text = mypg.CurrentPageIndex + 1
            CType(Me.LoginView1.FindControl("btIndietro"), LinkButton).Enabled = Not mypg.IsFirstPage
            CType(Me.LoginView1.FindControl("btAvanti"), LinkButton).Enabled = Not mypg.IsLastPage
        
        Else
            CType(Me.LoginView1.FindControl("tbPager"), HtmlTable).Visible = False
        End If
    End Sub

    Protected Sub btAvanti_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("objFoto_An"), ObjectDataSource).SelectParameters("pageIndex").DefaultValue += 1
        CType(Me.LoginView1.FindControl("listFoto_An"), DataList).DataBind()
    End Sub

    Protected Sub btIndietro_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("objFoto_An"), ObjectDataSource).SelectParameters("pageIndex").DefaultValue -= 1
        CType(Me.LoginView1.FindControl("listFoto_An"), DataList).DataBind()
    End Sub

    Protected Sub listFoto_An_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or _
            e.Item.ItemType = ListItemType.AlternatingItem Then

            Dim dsGlobale As New dsBattaglia
            dsGlobale.Merge(Profile.GetProfile("admin").DatiFotogallery.Categorie)
            Dim dt As New dsBattaglia.FotografieDataTable
            Dim myr As dsBattaglia.FotografieRow = CType(e.Item.DataItem, dsBattaglia.FotografieRow)
            dt.ImportRow(myr)
            dsGlobale.Merge(dt)
        
            Dim ltCat As Literal = CType(e.Item.FindControl("ltCategoria"), Literal)
            ltCat.Text = dsGlobale.Fotografie(0).Categorie_FotogalleryRow.NomeCategoria
        
        End If

    End Sub

    Protected Sub listFoto_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim listfoto As DataList = CType(source, DataList)
        listfoto.EditItemIndex = e.Item.ItemIndex
        listfoto.DataBind()
        
    End Sub

    Protected Sub listFoto_CancelCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim listfoto As DataList = CType(source, DataList)
        listfoto.EditItemIndex = -1
        listfoto.DataBind()
    End Sub

    Protected Sub listFoto_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim listfoto As DataList = CType(source, DataList)
        Dim objFoto As ObjectDataSource = CType(Me.LoginView1.FindControl("objFoto"), ObjectDataSource)
         
        Dim url As HiddenField = CType(e.Item.FindControl("hfImgPath"), HiddenField)
        Dim cat As DropDownList = CType(e.Item.FindControl("listCat"), DropDownList)
        Dim testo As TextBox = CType(e.Item.FindControl("txtTesto"), TextBox)
        Dim ckPrimo As CheckBox = CType(e.Item.FindControl("ckPrimoPiano"), CheckBox)
        Dim ckSecondo As CheckBox = CType(e.Item.FindControl("ckSecondoPiano"), CheckBox)
        
        
        objFoto.UpdateParameters("IDFotografia").DefaultValue = listfoto.DataKeys(e.Item.ItemIndex).ToString
        objFoto.UpdateParameters("IDCategoria").DefaultValue = cat.SelectedValue
        objFoto.UpdateParameters("Didascalia").DefaultValue = testo.Text
        objFoto.UpdateParameters("UrlFoto").DefaultValue = url.Value
        objFoto.UpdateParameters("PrimoPiano").DefaultValue = ckPrimo.Checked.ToString
        objFoto.UpdateParameters("SecondoPiano").DefaultValue = ckSecondo.Checked.ToString
        
        
        objFoto.Update()
        listfoto.EditItemIndex = -1
    End Sub

    Protected Sub listFoto_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs)
        Dim objFoto As ObjectDataSource = CType(Me.LoginView1.FindControl("objFoto"), ObjectDataSource)
        Dim listfoto As DataList = CType(source, DataList)

        objFoto.DeleteParameters("IDFotografia").DefaultValue = listfoto.DataKeys(e.Item.ItemIndex).ToString
        objFoto.Delete()
    End Sub

    Protected Sub btIndietro_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("objFoto"), ObjectDataSource).SelectParameters("pageIndex").DefaultValue -= 1
        CType(Me.LoginView1.FindControl("listFoto"), DataList).DataBind()
    End Sub

    Protected Sub btAvanti_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("objFoto"), ObjectDataSource).SelectParameters("pageIndex").DefaultValue += 1
        CType(Me.LoginView1.FindControl("listFoto"), DataList).DataBind()
    End Sub
</script>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="left" valign="top" style="background-color: #EBEBEB">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="height: 61px; background-color: #949C63" align="left" valign="bottom"
                            class="titolo">
                            <table width="100%" border="0" cellspacing="15">
                                <tr>
                                    <td align="left" valign="bottom" class="titolo">
                                        Fotogallery</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">
                            <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:LoginView ID="LoginView1" runat="server">
                                            <AnonymousTemplate>
                                                <asp:DataList ID="listFoto_An" runat="server" CellPadding="5" RepeatColumns="4" RepeatDirection="Horizontal"
                                                    DataSourceID="objFoto_An" OnItemDataBound="listFoto_An_ItemDataBound" Style="height: 280px">
                                                    <ItemStyle Width="125px" Height="137px" HorizontalAlign="Center" VerticalAlign="Top" />
                                                    <ItemTemplate>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 125px; height: 125px; background-color: #cccccc" align="center"
                                                                    valign="middle">
                                                                    <a href="#">
                                                                        <img alt="" src="<%# Eval("UrlFoto", "imghandler.ashx?tipo=galleria&amp;w=115&amp;img={0}") %>"
                                                                            style="border-style: none" onclick="MM_openBrWindow('pop_up_fotogallery.aspx?codfoto=<%# Eval("IDFotografia") %>','','scrollbars=yes,width=500,height=500')" /></a></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle" style="background-color: #ffffff" class="titoloboxhome">
                                                                    <asp:Literal ID="ltCategoria" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                                <asp:ObjectDataSource ID="objFoto_An" runat="server" OnSelecting="objFoto_An_Selecting"
                                                    SelectMethod="GetFotografiePaging" TypeName="DataFotografie" OnSelected="objFoto_An_Selected">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="0" Name="pageIndex" Type="Int32" />
                                                        <asp:Parameter DefaultValue="8" Name="pageSize" Type="Int32" />
                                                        <asp:Parameter Name="dtFotografie" Type="Object" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%" id="tbPager"
                                                    runat="server">
                                                    <tr>
                                                        <td align="center" class="testoboxhome" valign="bottom">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="370">
                                                                <tr>
                                                                    <th align="left" scope="row" valign="middle" style="width: 15px">
                                                                        <img alt="Indietro" height="9" src="img/frecciaindietro.jpg" width="5" /></th>
                                                                    <th align="left" scope="row" valign="middle" style="width: 70px">
                                                                        <asp:LinkButton ID="btIndietro" runat="server" CssClass="titoloboxhome" CausesValidation="false"
                                                                            Text="Indietro" OnClick="btIndietro_Click" />
                                                                    </th>
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
                                                                        <img alt="Avanti" height="9" src="img/frecciaavanti.jpg" width="5" /></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </AnonymousTemplate>
                                            <LoggedInTemplate>
                                                <asp:FormView ID="fvFoto" runat="server" CellPadding="0" DataKeyNames="IDFotografia"
                                                    DataSourceID="objFotoS" DefaultMode="Insert" Visible="False" Width="100%" OnModeChanging="fvFoto_ModeChanging"
                                                    OnItemInserted="fvFoto_ItemInserted">
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
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("imgFoto").ClientID %>').src = '../imghandler.aspx?w=80&img=' + gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                                gallery1.window.close()
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("noimg").ClientID %>').style.display = 'inline';
                                                                document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("hfImgPath").ClientID %>').value = gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                            }
                                                            
                                                            function DelImg1()
                                                            {
                                                                FTB_API[ 0] = receiver1;
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("noimg").ClientID %>').style.display = 'none';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("imgFoto").ClientID %>').src = '../aspnet_client/FreeTextBox/utility/spacer.gif';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("imgFoto").ClientID %>').style.width = '';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("imgFoto").ClientID %>').style.height = '';
                                                                 document.getElementById('<%= me.loginview1.findcontrol("fvFoto").FindControl("hfImgPath").ClientID %>').value = '';
                                                            }
                                                        </script>

                                                        <table border="0" cellpadding="5" cellspacing="0" style="border-right: #949c63 1px solid;
                                                            border-top: #949c63 1px solid; border-left: #949c63 1px solid; border-bottom: #949c63 1px solid">
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
                                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("PrimoPiano") %>' CssClass="titoloboxhome"
                                                                        Text="Primo piano" />
                                                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("SecondoPiano") %>'
                                                                        CssClass="titoloboxhome" Text="Secondo piano" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                                        Text="Inserisci" CssClass="titoloboxhome" ForeColor="Green"></asp:LinkButton></td>
                                                                <td>
                                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                        Text="Annulla" CssClass="titoloboxhome" ForeColor="#FF8000"></asp:LinkButton></td>
                                                            </tr>
                                                        </table>
                                                        <asp:HiddenField ID="hfImgPath" runat="server" Value='<%# Bind("UrlFoto") %>' />
                                                    </InsertItemTemplate>
                                                </asp:FormView>
                                                <asp:DataList ID="listFoto" runat="server" CellPadding="5" RepeatColumns="4" RepeatDirection="Horizontal"
                                                    Width="100%" DataKeyField="IDFotografia" DataSourceID="objFoto" OnItemCommand="listFoto_ItemCommand"
                                                    OnEditCommand="listFoto_EditCommand" OnCancelCommand="listFoto_CancelCommand"
                                                    OnUpdateCommand="listFoto_UpdateCommand" OnDeleteCommand="listFoto_DeleteCommand">
                                                    <ItemStyle Width="125px" Height="137px" HorizontalAlign="Center" VerticalAlign="Top" />
                                                    <ItemTemplate>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td align="right" style="background-color: #cccccc" valign="middle">
                                                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete"
                                                                        Text="x" ToolTip="Cancella" BackColor="#C00000" BorderStyle="None" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="12px" ForeColor="White" OnClientClick="return confirm('Stai per cancellare una foto. Confermare?')"
                                                                        Width="20px" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="background-color: #cccccc; width: 125px; height: 125px" align="center"
                                                                    valign="middle">
                                                                    <asp:ImageButton ID="btImg" runat="server" ImageUrl='<%# Eval("UrlFoto", "~/imghandler.ashx?w=80&img={0}") %>'
                                                                        AlternateText="Modifica" CommandName="Edit" CausesValidation="False" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle" style="background-color: #ffffff" class="titoloboxhome">
                                                                    <asp:Literal ID="ltdidascalia" runat="server" Text='<%# Eval("Didascalia") %>'></asp:Literal></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:Button ID="Button1" runat="server" CommandName="New" Text="Aggiungi" Font-Names="Verdana"
                                                            Font-Size="10px" BackColor="#949C63" BorderStyle="None" Font-Bold="True" ForeColor="White" />
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
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').src = '../imghandler.aspx?w=80&img=' + gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                                gallery1.window.close()
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("noimg").ClientID %>').style.display = 'inline';
                                                                document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("hfImgPath").ClientID %>').value = gallery1.document.getElementById('img_cartella').value.replace("..","") + '/' + gallery1.document.getElementById('img_alt').value;
                                                            }
                                                            
                                                            function DelImg1()
                                                            {
                                                                FTB_API[ 0] = receiver1;
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("noimg").ClientID %>').style.display = 'none';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').src = '../aspnet_client/FreeTextBox/utility/spacer.gif';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').style.width = '';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("imgFoto").ClientID %>').style.height = '';
                                                                 document.getElementById('<%= ctype(me.loginview1.findcontrol("listFoto"),datalist).Items(ctype(me.loginview1.findcontrol("listFoto"),datalist).EditItemIndex).FindControl("hfImgPath").ClientID %>').value = '';
                                                            }
                                                        </script>

                                                        <table style="border-right: #949c63 1px solid; border-top: #949c63 1px solid; border-left: #949c63 1px solid;
                                                            border-bottom: #949c63 1px solid" border="0" cellpadding="5" cellspacing="0"
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
                                                                    <asp:Image ID="imgFoto" runat="server" ImageUrl='<%# IIF(Eval("UrlFoto").tostring().length > 3 ,Eval("UrlFoto","~/imghandler.aspx?w=80&img={0}"),"~/aspnet_client/freetextbox/utility/spacer.gif") %>' /></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" style="white-space: nowrap">
                                                                    <asp:CheckBox ID="ckPrimoPiano" runat="server" Checked='<%# IIF(Eval("PrimoPiano").tostring ="","False",Eval("PrimoPiano")) %>'
                                                                        CssClass="titoloboxhome" Text="Primo piano" />
                                                                    <asp:CheckBox ID="ckSecondoPiano" runat="server" Checked='<%# IIF(Eval("SecondoPiano").tostring ="","False",Eval("SecondoPiano")) %>'
                                                                        CssClass="titoloboxhome" Text="Secondo piano" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                                        Text="Aggiorna" CssClass="titoloboxhome" ForeColor="Green"></asp:LinkButton></td>
                                                                <td>
                                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                        Text="Annulla" CssClass="titoloboxhome" ForeColor="#FF8000"></asp:LinkButton></td>
                                                            </tr>
                                                        </table>
                                                        <asp:HiddenField ID="hfImgPath" runat="server" Value='<%# Bind("UrlFoto") %>' />
                                                    </EditItemTemplate>
                                                    <EditItemStyle HorizontalAlign="Left" />
                                                </asp:DataList>
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%" id="tbPager"
                                                    runat="server">
                                                    <tr>
                                                        <td align="center" class="testoboxhome" valign="bottom">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="370">
                                                                <tr>
                                                                    <td align="left"valign="middle" style="width: 15px">
                                                                        <img alt="Indietro" height="9" src="img/frecciaindietro.jpg" width="5" /></td>
                                                                    <td align="left" valign="middle" style="width: 70px">
                                                                        <asp:LinkButton ID="btIndietro" runat="server" CssClass="titoloboxhome" CausesValidation="false"
                                                                            Text="Indietro" OnClick="btIndietro_Click1" />
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
                                                                            CausesValidation="false" OnClick="btAvanti_Click1" /></td>
                                                                    <td align="right" valign="middle" style="width: 15px">
                                                                        <img alt="Avanti" height="9" src="img/frecciaavanti.jpg" width="5" /></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:ObjectDataSource ID="objFoto" runat="server" SelectMethod="GetFotografiePaging"
                                                    TypeName="DataFotografie" OldValuesParameterFormatString="original_{0}" UpdateMethod="UpdateFotografie"
                                                    DeleteMethod="DeleteFotografie" OnSelected="objFoto_An_Selected" OnSelecting="objFoto_An_Selecting">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="0" Name="pageIndex" Type="Int32" />
                                                        <asp:Parameter DefaultValue="8" Name="pageSize" Type="Int32" />
                                                        <asp:Parameter Name="dtFotografie" Type="Object" />
                                                    </SelectParameters>
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="IDFotografia" Type="Int32" />
                                                        <asp:Parameter Name="IDCategoria" Type="Int32" />
                                                        <asp:Parameter Name="UrlFoto" Type="String" />
                                                        <asp:Parameter Name="Didascalia" Type="String" />
                                                        <asp:Parameter Name="PrimoPiano" Type="Boolean" />
                                                        <asp:Parameter Name="SecondoPiano" Type="Boolean" />
                                                    </UpdateParameters>
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="IDFotografia" Type="Int32" />
                                                    </DeleteParameters>
                                                </asp:ObjectDataSource>
                                                <asp:ObjectDataSource ID="objFotoS" runat="server" TypeName="DataFotografie" InsertMethod="InsertFotografie"
                                                    OldValuesParameterFormatString="original_{0}">
                                                    <InsertParameters>
                                                        <asp:Parameter Name="IDCategoria" Type="Int32" />
                                                        <asp:Parameter Name="UrlFoto" Type="String" />
                                                        <asp:Parameter Name="Didascalia" Type="String" />
                                                        <asp:Parameter Name="PrimoPiano" Type="Boolean" />
                                                        <asp:Parameter Name="SecondoPiano" Type="Boolean" />
                                                        <asp:ProfileParameter Name="dtCategorie" PropertyName="DatiFotogallery.Fotografie"
                                                            Type="Object" />
                                                    </InsertParameters>
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="IDFotografia" Type="Int32" />
                                                    </DeleteParameters>
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="IDFotografia" Type="Int32" />
                                                        <asp:Parameter Name="IDCategoria" Type="Int32" />
                                                        <asp:Parameter Name="UrlFoto" Type="String" />
                                                        <asp:Parameter Name="Didascalia" Type="String" />
                                                        <asp:Parameter Name="PrimoPiano" Type="Boolean" />
                                                        <asp:Parameter Name="SecondoPiano" Type="Boolean" />
                                                    </UpdateParameters>
                                                </asp:ObjectDataSource>
                                                <asp:ObjectDataSource ID="objCat" runat="server" SelectMethod="GetCategorie" TypeName="DataBattaglia">
                                                    <SelectParameters>
                                                        <asp:ProfileParameter Name="dtCategorie" PropertyName="DatiFotogallery.Categorie"
                                                            Type="Object" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </LoggedInTemplate>
                                        </asp:LoginView>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 11px" align="right" valign="top">
                <img alt="" src="img/destraflash.jpg" width="11" height="402" /></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucCategorieFoto ID="UcCategorieFoto1" runat="server" />
</asp:Content>
