<%@ Page MasterPageFile="MasterSito.master" Language="VB" Title="Riccardo Battaglia - Photography: Videogallery" %>

<%@ Register Src="ucCategorieVideov2.ascx" TagName="ucCategorieVideo" TagPrefix="uc1" %>

<script runat="server">

    Protected Sub btIndietro_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.objVideo.SelectParameters("pageIndex").DefaultValue -= 1
        Me.listVideo.DataBind()
    End Sub

    Protected Sub btAvanti_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.objVideo.SelectParameters("pageIndex").DefaultValue += 1
        Me.listVideo.DataBind()
    End Sub

    Protected Sub objVideo_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs)
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
</script>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucCategorieVideo ID="UcCategorieVideo1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="left" valign="top" style="background-color: #ebebeb">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="left" valign="bottom" style="background-color: #149B99; height: 61px"
                            class="titolo">
                            <asp:FormView ID="fvCat" runat="server" Width="100%" DataSourceID="objCat">
                                <ItemTemplate>
                                    <table width="100%" border="0" cellspacing="15">
                                        <tr>
                                            <td align="left" valign="bottom" class="titolo">
                                                Videogallery <span class="titolo2">-
                                                    <%# Eval("Label","{0}") %>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:ObjectDataSource ID="objCat" runat="server" SelectMethod="GetCategoria_ByIDv2"
                                TypeName="DataVideo">
                                <SelectParameters>
                                    <asp:QueryStringParameter DefaultValue="-1" Name="idcat" QueryStringField="codcat"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">
                            <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                <tr>
                                    <td align="left" valign="top">
                                        <asp:DataList ID="listVideo" runat="server" RepeatDirection="Horizontal" RepeatColumns="3"
                                            CellPadding="5" DataSourceID="objVideo" Height="280px">
                                            <ItemStyle Width="180px" Height="137px" HorizontalAlign="Center" VerticalAlign="Top" />
                                            <ItemTemplate>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 180px; height: 125px; background-color: #cccccc" align="center"
                                                            valign="middle">
                                                            <a href="javascript:void(0);" onclick="MM_openBrWindow('popupVideov2.aspx?codvideo=<%# Eval("VideoId") %>','','scrollbars=yes,width=550,height=550');">
                                                                <img alt="" src="<%# ListVideosStudio.GetImmagine(Eval("Thumbnails"))%>" width="161" style="border-style: none"></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" valign="middle" style="background-color: #FFFFFF" class="titoloboxhome">
                                                            <%#Eval("Title","{0}") %>
                                                        </td>
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
                                                                    <td valign="middle" align="left" style="width: 15px">
                                                                        <img height="9" alt="Indietro" src="img/freccia_indietro.jpg" width="5" />
                                                                    </td>
                                                                    <td valign="middle" align="left" style="width: 70px">
                                                                        <asp:LinkButton ID="btIndietro" runat="server" Text="Indietro" CausesValidation="false"
                                                                            CssClass="titoloboxhome" OnClick="btIndietro_Click"></asp:LinkButton>
                                                                    </td>
                                                                    <td class="testoboxhome" valign="middle" align="center" style="width: 200px">
                                                                        | pagina
                                                                        <asp:Literal ID="ltPgCorrente" runat="server"></asp:Literal>
                                                                        di
                                                                        <asp:Literal ID="ltPgTotali" runat="server"></asp:Literal>
                                                                        |
                                                                    </td>
                                                                    <td valign="middle" align="right" style="width: 70px">
                                                                        <asp:LinkButton ID="btAvanti" runat="server" Text="Avanti" CausesValidation="false"
                                                                            CssClass="titoloboxhome" OnClick="btAvanti_Click"></asp:LinkButton>
                                                                    </td>
                                                                    <td valign="middle" align="right" style="width: 15px">
                                                                        <img height="9" alt="Avanti" src="img/freccia_avanti.jpg" width="5" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <asp:ObjectDataSource ID="objVideo" runat="server" OnSelected="objVideo_Selected"
                                            SelectMethod="GetVideoPaging_ByIDCatv2" TypeName="DataVideo">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="pageIndex" Type="Int32" />
                                                <asp:Parameter DefaultValue="6" Name="pageSize" Type="Int32" />
                                                <asp:QueryStringParameter Name="idcat" QueryStringField="codcat" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 11px" align="right" valign="top">
                <img alt="" src="img/destraflash.jpg" width="11" height="402" />
            </td>
        </tr>
    </table>
</asp:Content>
