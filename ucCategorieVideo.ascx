<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCategorieVideo.ascx.cs"
    Inherits="ucCategorieVideo" %>
<asp:Repeater ID="rpCategorie" runat="server">
    <HeaderTemplate>
        <table width="218" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td style="height: 384px" align="center" valign="top" class="sfondomenu">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <table width="170" border="0" cellpadding="0" cellspacing="5" style="background-color: #FFFFFF">
                        <tr>
                            <td align="left" valign="top" class="titoloboxhome">
                                CATEGORIE:</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" style="height: 2px; background-color: #149B99"></td>
                        </tr>
    </HeaderTemplate>
    <FooterTemplate>
        </table></td></tr></table>
    </FooterTemplate>
    <ItemTemplate>
        <tr>
            <td align="left" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="width: 15px" align="left" valign="middle">
                            <img alt="" src="img/freccia_videogallery.jpg" width="4" height="7" /></td>
                        <td align="left" valign="top">
                            <a href="videogallery_categoria.aspx?codcat=<%# Eval("IDCategoria") %>" class="titoloboxhome">
                                <%# Eval("NomeCategoria") %></td>
                    </tr>
                </table></td>
        </tr>
    </ItemTemplate>
</asp:Repeater>
<asp:LoginView ID="lg1" runat="server">
    <LoggedInTemplate>
        <table width="218" border="0" cellspacing="0" cellpadding="0" id="tbMod" runat="server"
            visible="true">
            <tr>
                <td style="height: 384px" colspan="3" align="center" valign="top" class="sfondomenu">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td scope="row">&nbsp;</td>
                        </tr>
                    </table>
                    <table width="170" border="0" cellpadding="0" cellspacing="5" style="background-color: #ffffff">
                        <tr>
                            <td align="left" valign="top" class="titoloboxhome">
                                CATEGORIE:
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" style="height: 2px; background-color: #149B99">
                            </td>
                        </tr>
                    </table>
                    <asp:UpdatePanel ID="upCategorie" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvCat" runat="server" DataSourceID="objCat" AutoGenerateColumns="False"
                                DataKeyNames="IDCategoria" CellPadding="0" GridLines="None" Width="170px" CellSpacing="5"
                                BackColor="White" OnRowCommand="gvCat_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="NomeCategoria" SortExpression="NomeCategoria">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCat" runat="server" Text='<%# Bind("NomeCategoria") %>' ValidationGroup="cat"
                                                Width="88px" Font-Names="Verdana" Font-Size="10px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCat"
                                                Display="Dynamic" ErrorMessage="*" ValidationGroup="cat" Font-Names="Verdana"
                                                Font-Size="10px"></asp:RequiredFieldValidator>
                                            <asp:Button ID="Button1" runat="server" CommandName="Update" Text="Ok" ToolTip="Aggiorna"
                                                ValidationGroup="cat" BackColor="#149B99" BorderStyle="None" Font-Bold="True"
                                                Font-Names="Verdana" Font-Size="10px" ForeColor="White" />
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="<--" ToolTip="Annulla" BackColor="#FF6634" BorderStyle="None" Font-Bold="True"
                                                Font-Names="Verdana" Font-Size="10px" ForeColor="White" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="width: 15px" align="left" valign="middle">
                                                        <img alt="" src="img/freccia_videogallery.jpg" width="4" height="7" /></td>
                                                    <td align="left" valign="top">
                                                        <asp:LinkButton ID="lbCat" runat="server" CssClass="titoloboxhome" Text='<%# Eval("NomeCategoria") %>'
                                                            CommandName="Edit" />
                                                    </td>
                                                    <td align="right" valign="top">
                                                        <asp:Button ID="Button3" runat="server" CommandName="Delete" OnClientClick='return confirm("Stai per cancellare una categoria confermare?");'
                                                            Text="x" ToolTip="Cancella" Width="20px" BackColor="#C00000" BorderStyle="None"
                                                            Font-Bold="True" Font-Names="Verdana" Font-Size="12px" ForeColor="White" /></td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="New"
                                                Text="Nuova" ToolTip="Nuova categoria" BackColor="#149B99" BorderStyle="None"
                                                Font-Bold="True" Font-Names="Verdana" Font-Size="10px" ForeColor="White" />
                                        </HeaderTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Left" />
                                <EmptyDataRowStyle HorizontalAlign="Left" />
                                <EmptyDataTemplate>
                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="New"
                                        Text="Nuova" ToolTip="Nuova categoria" BackColor="#149B99" BorderStyle="None"
                                        Font-Bold="True" Font-Names="Verdana" Font-Size="10px" ForeColor="White" />
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:DetailsView ID="dvCat" runat="server" AutoGenerateRows="False" BackColor="White"
                                CellPadding="0" CellSpacing="5" DataKeyNames="IDCategoria" DataSourceID="objCatS"
                                DefaultMode="Insert" GridLines="None" OnItemInserted="dvCat_ItemInserted" OnModeChanging="dvCat_ModeChanging"
                                Visible="False" Width="170px">
                                <Fields>
                                    <asp:TemplateField HeaderText="Categoria:" SortExpression="NomeCategoria">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NomeCategoria") %>' Width="88px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NomeCategoria") %>' Width="88px"
                                                Font-Names="Verdana" Font-Size="10px"></asp:TextBox>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("NomeCategoria") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <InsertItemTemplate>
                                            <asp:Button ID="Button1" runat="server" BackColor="#149B99" BorderStyle="None" CausesValidation="True"
                                                CommandName="Insert" Font-Bold="True" Font-Names="Verdana" Font-Size="10px" ForeColor="White"
                                                Text="Inserisci" />&nbsp;<asp:Button ID="Button2" runat="server" BackColor="#FF6634"
                                                    BorderStyle="None" CausesValidation="False" CommandName="Cancel" Font-Bold="True"
                                                    Font-Names="Verdana" Font-Size="10px" ForeColor="White" Text="Annulla" />
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="New"
                                                Text="Nuovo" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                                <FieldHeaderStyle CssClass="titoloboxhome" />
                            </asp:DetailsView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:ObjectDataSource ID="objCat" runat="server" SelectMethod="GetCategorie" TypeName="DataVideo"
                        UpdateMethod="UpdateCategorie" DeleteMethod="DeleteCategorie">
                        <DeleteParameters>
                            <asp:Parameter Name="IDCategoria" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="IDcategoria" Type="Int32" />
                            <asp:Parameter Name="NomeCategoria" Type="String" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="objCatS" runat="server" TypeName="DataVideo" InsertMethod="InsertCategorie">
                        <InsertParameters>
                            <asp:Parameter Name="NomeCategoria" Type="String" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                </td>
            </tr>
        </table>
    </LoggedInTemplate>
</asp:LoginView>
