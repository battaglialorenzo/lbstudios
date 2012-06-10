<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCategorieVideov2.ascx.cs"
    Inherits="ucCategorieVideov2" %>
<asp:Repeater ID="rpCategorie" runat="server" DataSourceID="objDati">
    <HeaderTemplate>
        <table width="218" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td style="height: 384px" align="center" valign="top" class="sfondomenu">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <div style="overflow-y:auto; overflow-x:hidden; height:300px; width:170px; margin-left:auto; margin-right:auto"><table width="170" border="0" cellpadding="0" cellspacing="5" style="background-color: #FFFFFF">
                        <tr>
                            <td align="left" valign="top" class="titoloboxhome">
                                CATEGORIE:</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" style="height: 2px; background-color: #149B99"></td>
                        </tr>
    </HeaderTemplate>
    <FooterTemplate>
        </table></div></td></tr></table>
    </FooterTemplate>
    <ItemTemplate>
        <tr>
            <td align="left" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="width: 15px" align="left" valign="middle">
                            <img alt="" src="img/freccia_videogallery.jpg" width="4" height="7" /></td>
                        <td align="left" valign="top">
                            <a href="videogallery_categoriav2.aspx?codcat=<%# Eval("term","{0}") %>" class="titoloboxhome">
                                <%# Eval("Label","{0}") %></td>
                    </tr>
                </table></td>
        </tr>
    </ItemTemplate>
</asp:Repeater>
<asp:ObjectDataSource ID="objDati" runat="server" CacheDuration="900" 
    EnableCaching="True" OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetCategoriev2" TypeName="DataVideo" />
