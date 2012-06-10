<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucRecapiti.ascx.vb" Inherits="ucRecapiti" %>
<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
</asp:ScriptManagerProxy>
<table width="218" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td style="height: 384px" align="center" valign="top" class="sfondomenu">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <asp:LoginView ID="LoginView1" runat="server">
                <LoggedInTemplate>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                           <div style="overflow:auto; width:190px;height:190px"><table id="tbRecapiti" runat="server" width="170" border="0" cellpadding="0" cellspacing="5"
                                style="background-color: #ffffff">
                                <tr>
                                    <td align="left" valign="top" class="titoloboxhome">
                                        RECAPITI:</td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" style="background-color: #ff6634; height: 2px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                            <span class="titoloboxhome">Indirizzo:</span><br />
                                            <asp:Label ID="lbIndirizzo" runat="server" CssClass="testoboxhome" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <span class="titoloboxhome">Tel: </span>
                                        <br />
                                        <asp:Label ID="lbTel" runat="server" CssClass="testoboxhome" /></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" scope="row">
                                        <span class="titoloboxhome">Fax: </span>
                                        <br />
                                        <asp:Label ID="lbFax" runat="server" CssClass="testoboxhome" /></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <span class="titoloboxhome">E-mail: </span>
                                        <asp:HyperLink ID="lkEmail" runat="server" Target="_blank" CssClass="testoboxhome" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" scope="row" valign="top">
                                        <asp:Button ID="btModifica" runat="server" OnClick="btModifica_Click" Text="Modifica" /></td>
                                </tr>
                            </table>
                            <table id="tbRecapitiMod" runat="server" width="170" border="0" cellpadding="0" cellspacing="5"
                                style="background-color: #ffffff;" visible="false">
                                <tr>
                                    <td align="left" valign="top" class="titoloboxhome">
                                        RECAPITI:</td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" style="background-color: #ff6634; height: 2px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                            <span class="titoloboxhome">Indirizzo:</span><br />
                                            <asp:TextBox ID="txtIndirizzo" runat="server" Width="144px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <span class="titoloboxhome">Tel: </span>
                                        <br />
                                        <asp:TextBox ID="txtTel" runat="server" Width="144px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <span class="titoloboxhome">Fax: </span>
                                        <br />
                                        <asp:TextBox ID="txtFax" runat="server" Width="144px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <span class="titoloboxhome">E-mail:
                                            <asp:TextBox ID="txtEmail" runat="server" Width="144px"></asp:TextBox></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" style="height: 48px">
                                        <asp:Button ID="btSalva" runat="server" Text="Salva" OnClick="btSalva_Click" /> | <asp:Button ID="btAnnulla" runat="server" Text="Annulla"  CausesValidation="False" OnClick="btAnnulla_Click" />
                                        <asp:Label ID="lbMess" runat="server" ForeColor="#FF6634"></asp:Label></td>
                                </tr>
                            </table></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </LoggedInTemplate>
                <AnonymousTemplate>
                    <table id="tbRecapiti" runat="server" width="180" border="0" cellpadding="0" cellspacing="5"
                        style="background-color: #ffffff">
                        <tr>
                            <td align="left" valign="top" class="titoloboxhome">
                                RECAPITI:</td>
                        </tr>
                        <tr>
                            <td id="tdLinea" runat="server" align="left" valign="top" style="height: 2px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <p>
                                    <span class="titoloboxhome">Indirizzo:</span><br />
                                    <asp:Label ID="lbIndirizzo" runat="server" CssClass="testoboxhome" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <span class="titoloboxhome">Tel: </span>
                                <br />
                                <asp:Label ID="lbTel" runat="server" CssClass="testoboxhome" /></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <span class="titoloboxhome">Fax: </span>
                                <br />
                                <asp:Label ID="lbFax" runat="server" CssClass="testoboxhome" /></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <span class="titoloboxhome">E-mail: </span>
                                <asp:HyperLink ID="lkEmail" runat="server" Target="_blank" CssClass="testoboxhome" />
                            </td>
                        </tr>
                    </table>
                </AnonymousTemplate>
            </asp:LoginView>
        </td>
    </tr>
</table>
