<%@ Page MasterPageFile="MasterSito.master" Language="VB" Title="Riccardo Battaglia - Photography: Biografia" %>

<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<%@ Register Src="ucRecapiti.ascx" TagName="ucRecapiti" TagPrefix="uc1" %>

<script runat="server">

    Protected Sub btModificaBiografia_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("txtBiografia"), FreeTextBox).Text = Profile.GetProfile("admin").DatiBiografia.Testobiografia
        
        Me.LoginView1.FindControl("tbBiografia").Visible = False
        Me.LoginView1.FindControl("tbModBiografia").Visible = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            If Not User.Identity.IsAuthenticated Then
                CType(Me.LoginView1.FindControl("ltAnBiografia"), Literal).Text = Profile.GetProfile("admin").DatiBiografia.Testobiografia
            Else
                Try
                    CType(Me.LoginView1.FindControl("ltBiografia"), Literal).Text = Profile.GetProfile("admin").DatiBiografia.Testobiografia
                Catch ex As Exception

                End Try
  
            End If
            
        End If
    End Sub

    Protected Sub txtBiografia_SaveClick(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim prAdmin As ProfileCommon = Profile.GetProfile("admin")
        
        prAdmin.DatiBiografia.Testobiografia = CType(Me.LoginView1.FindControl("txtBiografia"), FreeTextBox).Text
        
        Me.LoginView1.FindControl("tbBiografia").Visible = True
        Me.LoginView1.FindControl("tbModBiografia").Visible = False
        
        prAdmin.Save()
        
        CType(Me.LoginView1.FindControl("ltBiografia"), Literal).Text = CType(Me.LoginView1.FindControl("txtBiografia"), FreeTextBox).Text

    End Sub
</script>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <th align="left" valign="top" style="background-color: #ebebeb" scope="row">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th style="height: 61px; background-color: #ff6634" align="left" valign="bottom"
                            class="titolo" scope="row">
                            <table width="100%" border="0" cellspacing="15">
                                <tr>
                                    <th align="left" valign="bottom" class="titolo" scope="row">
                                        Biografia</th>
                                </tr>
                            </table>
                        </th>
                    </tr>
                    <tr>
                        <th align="left" valign="top" scope="row">
                            <asp:LoginView ID="LoginView1" runat="server">
                                <RoleGroups>
                                    <asp:RoleGroup Roles="Amministratori">
                                        <ContentTemplate>
                                            <table width="100%" border="0" cellspacing="15" cellpadding="0" id="tbBiografia"
                                                runat="server">
                                                <tr>
                                                    <th align="left" valign="top" scope="row">
                                                        <asp:Literal ID="ltBiografia" runat="server" />
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <th align="left" scope="row" valign="top">
                                                        <asp:Button ID="btModificaBiografia" runat="server" Text="Modifica" OnClick="btModificaBiografia_Click" /></th>
                                                </tr>
                                            </table>
                                            <table width="100%" border="0" cellspacing="15" cellpadding="0" id="tbModBiografia"
                                                runat="server" visible="false">
                                                <tr>
                                                    <th align="left" valign="top" scope="row">
                                                        <FTB:FreeTextBox ID="txtBiografia" ToolbarLayout="paragraphmenu,fontsizesmenu;bold,italic,underline|
        bulletedlist,numberedlist,Save" runat="Server" Height="250px" Language="it-IT" Width="500px" BackColor="White" GutterBackColor="White"
                                                            OnSaveClick="txtBiografia_SaveClick" ButtonSet="OfficeMac" />
                                                    </th>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:RoleGroup>
                                </RoleGroups>
                                <AnonymousTemplate>
                                    <table width="100%" border="0" cellspacing="15" cellpadding="0" id="tbAnBiografia"
                                        runat="server">
                                        <tr>
                                            <th align="left" valign="top" scope="row">
                                                <asp:Literal ID="ltAnBiografia" runat="server" />
                                            </th>
                                        </tr>
                                    </table>
                                </AnonymousTemplate>
                            </asp:LoginView>
                        </th>
                    </tr>
                </table>
            </th>
            <td style="width:11px" align="right" valign="top">
                <img alt="" src="img/destraflash.jpg" width="11" height="402" /></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucRecapiti ID="UcRecapiti1" runat="server" ColoreLinea="#ff6634" />
</asp:Content>
