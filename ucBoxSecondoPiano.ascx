<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucBoxSecondoPiano.ascx.vb"
    Inherits="ucBoxSecondoPiano" %>
<asp:ObjectDataSource ID="objSecondoPiano" runat="server" SelectMethod="GetFotografie_SecondoPiano"
    TypeName="DataFotografie" />
<asp:Repeater ID="rpSec1" runat="server">
    <HeaderTemplate>
        <table width="218" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <th colspan="3" scope="row">
                    <img src="img/sottologo.jpg" width="218" height="16" alt="" /></th>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <th scope="row">
                <img src="img/1.jpg" width="25" height="100" alt="" /></th>
            <td align="center" valign="middle" style="width: 169px; height: 100px; background-color: #000000;">
                <a href="#" onclick="MM_openBrWindow('pop_up_fotogallery.aspx?codfoto=<%# Eval("IDFotografia") %>','','scrollbars=yes,width=500,height=500')">
                    <img alt="" src="<%# Eval("UrlFoto", "imghandler.ashx?w=169&amp;h=100&amp;img={0}") %>"
                        style="border-style: none" /></a></td>
            <td>
                <img alt="" src="img/2.jpg" width="24" height="100" /></td>
        </tr>
        <tr>
            <th colspan="3" scope="row">
                <img src="img/freccia1.jpg" width="218" height="14" alt="" /></th>
        </tr>
        <tr>
            <th scope="row">
                <img src="img/3.jpg" width="25" height="56" alt="" /></th>
            <td align="left" valign="top" style="background-color: #FFFFFF">
                <table width="100%" border="0" cellspacing="5" cellpadding="0">
                    <tr>
                        <th align="left" valign="top" class="titoloboxhome" scope="row">
                            <asp:Literal ID="ltCategoria" runat="server" /></th>
                    </tr>
                    <tr>
                        <th align="left" valign="top" class="testoboxhome" scope="row">
                            <a href="#" class="testoboxhome" onclick="MM_openBrWindow('pop_up_fotogallery.aspx?codfoto=<%# Eval("IDFotografia") %>','','scrollbars=yes,width=500,height=500')">
                                <%# Eval("Didascalia") %>
                            </a>
                        </th>
                    </tr>
                </table>
            </td>
            <td>
                <img src="img/4.jpg" width="24" height="56" alt="" /></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>
<asp:Repeater ID="rpSec2" runat="server">
    <HeaderTemplate>
        <table width="218" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <th colspan="3" scope="row">
                    <img src="img/5.jpg" width="218" height="15" alt="" /></th>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <th scope="row">
                <img src="img/6.jpg" width="25" height="100" alt="" /></th>
            <td align="center" valign="middle" style="background-color: #000000">
                <a href="#" onclick="MM_openBrWindow('pop_up_fotogallery.aspx?codfoto=<%# Eval("IDFotografia") %>','','scrollbars=yes,width=500,height=500')">
                    <img src="<%# Eval("UrlFoto", "imghandler.ashx?w=169&amp;h=100&amp;img={0}") %>"
                        alt="" style="border-style: none" /></a></td>
            <td>
                <img src="img/7.jpg" width="24" height="100" alt="" /></td>
        </tr>
        <tr>
            <th colspan="3" scope="row">
                <img src="img/freccia2.jpg" width="218" height="14" alt="" /></th>
        </tr>
        <tr>
            <th scope="row">
                <img src="img/8.jpg" width="25" height="56" alt="" /></th>
            <td align="left" valign="top" style="background-color: #FFFFFF">
                <table width="100%" border="0" cellspacing="5" cellpadding="0">
                    <tr>
                        <th align="left" valign="top" class="titoloboxhome" scope="row">
                            <asp:Literal ID="ltCategoria" runat="server" /></th>
                    </tr>
                    <tr>
                        <th align="left" valign="top" class="testoboxhome" scope="row">
                            <a href="#" class="testoboxhome" onclick="MM_openBrWindow('pop_up_fotogallery.aspx?codfoto=<%# Eval("IDFotografia") %>','','scrollbars=yes,width=500,height=500')">
                                <%# Eval("Didascalia") %>
                            </a>
                        </th>
                    </tr>
                </table>
            </td>
            <td>
                <img src="img/9.jpg" width="24" height="56" alt="" /></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        <tr>
            <th colspan="3" scope="row">
                <img src="img/10.jpg" width="218" height="13" alt="" /></th>
        </tr>
        </table>
    </FooterTemplate>
</asp:Repeater>
