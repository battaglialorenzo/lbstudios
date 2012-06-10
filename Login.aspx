<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="false"
    CodeFile="Login.aspx.cs" Inherits="Login" Title="Riccardo Battaglia - Photography: Amministrazione" %>

<%@ Register Src="ucRecapiti.ascx" TagName="ucRecapiti" TagPrefix="uc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <th align="left" valign="top" scope="row" style="background-color: #ebebeb">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th style="height: 61px; background-color: #ff6634" align="left" valign="bottom"
                            class="titolo" scope="row">
                            <asp:LoginView ID="LoginView2" runat="server">
                                <AnonymousTemplate>
                                    <table width="100%" border="0" cellspacing="15">
                                        <tr>
                                            <th align="left" valign="bottom" class="titolo" scope="row">
                                                Login - Area amministrazione&nbsp;</th>
                                        </tr>
                                    </table>
                                </AnonymousTemplate>
                                <RoleGroups>
                                    <asp:RoleGroup Roles="Amministratori">
                                        <ContentTemplate>
                                            <table width="100%" border="0" cellspacing="15">
                                                <tr>
                                                    <th align="left" valign="bottom" class="titolo" scope="row">
                                                        Profilo - Area amministrazione&nbsp;</th>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:RoleGroup>
                                </RoleGroups>
                            </asp:LoginView>
                        </th>
                    </tr>
                    <tr>
                        <th align="left" valign="top" scope="row">
                            <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                <tr>
                                    <th align="left" valign="top" scope="row">
                                        <asp:LoginView ID="LoginView1" runat="server">
                                            <RoleGroups>
                                                <asp:RoleGroup Roles="Amministratori">
                                                    <ContentTemplate>
                                                        <table style="width: 344px">
                                                            <tr>
                                                                <td style="width: 100px">
                                                                    <asp:TextBox ID="txtCat" runat="server"></asp:TextBox></td>
                                                                <td style="width: 100px">
                                                                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" /></td>
                                                                <td style="width: 100px">
                                                                    <asp:DropDownList ID="listCat" runat="server" DataTextField="NomeCategoria" DataValueField="IDCategoria">
                                                                    </asp:DropDownList></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px">
                                                                </td>
                                                                <td style="width: 100px">
                                                                </td>
                                                                <td style="width: 100px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px">
                                                                </td>
                                                                <td style="width: 100px">
                                                                </td>
                                                                <td style="width: 100px">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        &nbsp; &nbsp;
                                                    </ContentTemplate>
                                                </asp:RoleGroup>
                                            </RoleGroups>
                                            <AnonymousTemplate>
                                                <asp:Login ID="Login1" runat="server" Width="100%">
                                                    <LayoutTemplate>
                                                        <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse"
                                                            width="100%">
                                                            <tr>
                                                                <td align="center" valign="middle">
                                                                    <table border="0" cellpadding="2" cellspacing="0">
                                                                        <tr>
                                                                            <td align="right">
                                                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="titoloboxhome">Nome utente:</asp:Label></td>
                                                                            <td>
                                                                                <asp:TextBox ID="UserName" runat="server" MaxLength="10" Width="125px"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                                                    ErrorMessage="Il nome utente è obbligatorio." ToolTip="Il nome utente è obbligatorio."
                                                                                    ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right">
                                                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="titoloboxhome">Password:</asp:Label></td>
                                                                            <td>
                                                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" MaxLength="10" 
                                                                                    Width="125px"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                                                    ErrorMessage="La password è obbligatoria." ToolTip="La password è obbligatoria."
                                                                                    ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:CheckBox ID="RememberMe" runat="server" CssClass="testoboxhome" Text="Memorizza dati per la prossima volta." />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="center" class="testoboxhome" colspan="2" style="color: red">
                                                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" colspan="2">
                                                                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Accedi" ValidationGroup="Login1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </LayoutTemplate>
                                                </asp:Login>
                                                <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" Width="100%">
                                                    <MailDefinition From="noreply@riccardobattaglia.it" Subject="Recupero password">
                                                    </MailDefinition>
                                                    <QuestionTemplate>
                                                        <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse"
                                                            width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="0" style="width: 100%">
                                                                        <tr>
                                                                            <td align="center" class="testoboxhome" colspan="2">
                                                                                Per ricevere la password, rispondere alla seguente domanda.</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" class="titoloboxhome">
                                                                                Nome utente:</td>
                                                                            <td class="testoboxhome">
                                                                                <asp:Literal ID="UserName" runat="server"></asp:Literal>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" class="titoloboxhome" style="height: 19px">
                                                                                Domanda:</td>
                                                                            <td class="testoboxhome" style="height: 19px">
                                                                                <asp:Literal ID="Question" runat="server"></asp:Literal>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right">
                                                                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer" CssClass="titoloboxhome">Risposta:</asp:Label></td>
                                                                            <td>
                                                                                <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                                                                    ErrorMessage="La risposta è obbligatoria." ToolTip="La risposta è obbligatoria."
                                                                                    ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="center" class="testoboxhome" colspan="2" style="color: red">
                                                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" colspan="2">
                                                                                <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Invia" ValidationGroup="PasswordRecovery1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </QuestionTemplate>
                                                    <UserNameTemplate>
                                                        <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse"
                                                            width="100%">
                                                            <tr>
                                                                <td align="center" valign="middle">
                                                                    <table border="0" cellpadding="0">
                                                                        <tr>
                                                                            <td align="center" class="testoboxhome" colspan="2">
                                                                                Per ricevere la password, immettere il nome utente.</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right">
                                                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="titoloboxhome">Nome utente:</asp:Label></td>
                                                                            <td>
                                                                                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                                                    ErrorMessage="Il nome utente è obbligatorio." ToolTip="Il nome utente è obbligatorio."
                                                                                    ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="center" class="testoboxhome" colspan="2" style="color: red">
                                                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" colspan="2">
                                                                                <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Invia" ValidationGroup="PasswordRecovery1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </UserNameTemplate>
                                                    <SuccessTemplate>
                                                        <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse"
                                                            width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="0" style="width: 100%">
                                                                        <tr>
                                                                            <td class="testoboxhome">
                                                                                La password è stata inviata.</td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </SuccessTemplate>
                                                </asp:PasswordRecovery>
                                            </AnonymousTemplate>
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
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucRecapiti ID="UcRecapiti1" runat="server" ColoreLinea="#ff6634" />
</asp:Content>
