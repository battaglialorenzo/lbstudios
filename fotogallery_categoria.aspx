<%@ Page MasterPageFile="MasterSito.master" Language="VB" Title="Riccardo Battaglia - Photography: Fotogallery" %>

<%@ Register Src="ucCategorieFoto.ascx" TagName="ucCategorieFoto" TagPrefix="uc1" %>

<script runat="server">

    Protected Sub objFoto_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs)
        Dim mypg As PagedDataSource = CType(e.ReturnValue, PagedDataSource)
        If mypg.PageCount > 1 Then
            Me.tbPager.Visible = True
            ltPgTotali.Text = mypg.PageCount
            ltPgCorrente.Text = mypg.CurrentPageIndex + 1
            btIndietro.Enabled = Not mypg.IsFirstPage
            btAvanti.Enabled = Not mypg.IsLastPage
        Else
            tbPager.Visible = False
        End If
    End Sub

    Protected Sub btAvanti_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.objFoto.SelectParameters("pageIndex").DefaultValue += 1
        Me.listFoto.DataBind()
    End Sub

    Protected Sub btIndietro_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.objFoto.SelectParameters("pageIndex").DefaultValue -= 1
        Me.listFoto.DataBind()
    End Sub
</script>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucCategorieFoto ID="UcCategorieFoto1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <th align="left" valign="top" style="background-color: #EBEBEB" scope="row">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th align="left" valign="bottom" style="background-color: #949C63; height: 61px"
                            class="titolo" scope="row">
                            <asp:FormView ID="fvCat" runat="server" Width="100%" DataSourceID="objCat">
                                <ItemTemplate>
                                    <table width="100%" border="0" cellspacing="15">
                                        <tr>
                                            <th align="left" valign="bottom" class="titolo" scope="row">
                                                Fotogallery <span class="titolo2">-
                                                    <asp:Literal ID="ltNomeCat" runat="server" Text='<%# Eval("NomeCategoria") %>'></asp:Literal>
                                                </span>
                                            </th>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:ObjectDataSource ID="objCat" runat="server" InsertMethod="InsertFotografie"
                                OldValuesParameterFormatString="original_{0}" SelectMethod="GetCategoria_ByID"
                                TypeName="DataFotografie">
                                <SelectParameters>
                                    <asp:QueryStringParameter DefaultValue="-1" Name="idcat" QueryStringField="codcat"
                                        Type="Int32" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="IDCategoria" Type="Int32" />
                                    <asp:Parameter Name="UrlFoto" Type="String" />
                                    <asp:Parameter Name="Didascalia" Type="String" />
                                    <asp:Parameter Name="dtCategorie" Type="Object" />
                                </InsertParameters>
                            </asp:ObjectDataSource>
                        </th>
                    </tr>
                    <tr>
                        <th align="left" valign="top" scope="row">
                            <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:DataList ID="listFoto" runat="server" RepeatDirection="Horizontal" RepeatColumns="4"
                                            CellPadding="5" DataSourceID="objFoto" Height="280px">
                                            <ItemStyle Width="125px" Height="137px" HorizontalAlign="Center" VerticalAlign="Top" />
                                            <ItemTemplate>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 125px; height: 125px; background-color: #cccccc" align="center"
                                                            valign="middle">
                                                            <a href="#">
                                                                <img alt="" src="<%# Eval("UrlFoto", "imghandler.ashx?tipo=galleria&amp;w=115&img={0}") %>" style="border-style: none"
                                                                    onclick="MM_openBrWindow('pop_up_fotogallery.aspx?codfoto=<%# Eval("IDFotografia") %>','','scrollbars=yes,width=500,height=500')" /></a></td>
                                                    </tr>
                                                    <tr>
                                                        <th align="center" valign="middle" style="background-color: #ffffff" class="titoloboxhome"
                                                            scope="row">
                                                            <asp:Literal ID="ltDidascalia" runat="server" Text='<%# Eval("Didascalia") %>' />
                                                        </th>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <table style="width: 100%" id="tbPager" cellspacing="0" cellpadding="0" border="0"
                                            runat="server">
                                            <tbody>
                                                <tr>
                                                    <td class="testoboxhome" valign="bottom" align="center">
                                                        <table cellspacing="0" cellpadding="0" width="370" border="0">
                                                            <tbody>
                                                                <tr>
                                                                    <th valign="middle" scope="row" align="left" style="width: 15px">
                                                                        <img height="9" alt="Indietro" src="img/frecciaindietro.jpg" width="5" /></th>
                                                                    <th valign="middle" scope="row" align="left" style="width: 70px">
                                                                        <asp:LinkButton ID="btIndietro" runat="server" Text="Indietro" CausesValidation="false"
                                                                            CssClass="titoloboxhome" OnClick="btIndietro_Click"></asp:LinkButton>
                                                                    </th>
                                                                    <td class="testoboxhome" valign="middle" align="center" style="width: 200px">
                                                                        | pagina
                                                                        <asp:Literal ID="ltPgCorrente" runat="server"></asp:Literal>
                                                                        di
                                                                        <asp:Literal ID="ltPgTotali" runat="server"></asp:Literal>
                                                                        |
                                                                    </td>
                                                                    <td valign="middle" align="right" style="width: 70px">
                                                                        <asp:LinkButton ID="btAvanti" runat="server" Text="Avanti" CausesValidation="false"
                                                                            CssClass="titoloboxhome" OnClick="btAvanti_Click"></asp:LinkButton></td>
                                                                    <td valign="middle" align="right" style="width: 15px">
                                                                        <img height="9" alt="Avanti" src="img/frecciaavanti.jpg" width="5" /></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <asp:ObjectDataSource ID="objFoto" runat="server" InsertMethod="InsertFotografie"
                                            OldValuesParameterFormatString="original_{0}" OnSelected="objFoto_Selected" SelectMethod="GetFotografiePaging_ByIDCat"
                                            TypeName="DataFotografie">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="pageIndex" Type="Int32" />
                                                <asp:Parameter DefaultValue="8" Name="pageSize" Type="Int32" />
                                                <asp:QueryStringParameter Name="idcat" QueryStringField="codcat" Type="Int32" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="IDCategoria" Type="Int32" />
                                                <asp:Parameter Name="UrlFoto" Type="String" />
                                                <asp:Parameter Name="Didascalia" Type="String" />
                                                <asp:Parameter Name="dtCategorie" Type="Object" />
                                            </InsertParameters>
                                        </asp:ObjectDataSource>
                                    </td>
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
