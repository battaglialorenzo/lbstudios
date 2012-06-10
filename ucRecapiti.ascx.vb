Imports System.Drawing

Partial Class ucRecapiti
    Inherits System.Web.UI.UserControl

    Private _colorelinea As String

    Public Property ColoreLinea() As String
        Get
            Return _colorelinea
        End Get
        Set(ByVal value As String)
            _colorelinea = value
            If Not Context.User.Identity.IsAuthenticated Then
                CType(Me.LoginView1.FindControl("tdLinea"), HtmlTableCell).BgColor = value
            End If
        End Set
    End Property

    Sub CaricaDati()
        If Context.User.IsInRole("Amministratori") Then

            CType(Me.LoginView1.FindControl("txtIndirizzo"), TextBox).Text = Profile.DatiStudio.Indirizzo
            CType(Me.LoginView1.FindControl("txtEmail"), TextBox).Text = Profile.DatiStudio.Email
            CType(Me.LoginView1.FindControl("txtFax"), TextBox).Text = Profile.DatiStudio.Fax
            CType(Me.LoginView1.FindControl("txtTel"), TextBox).Text = Profile.DatiStudio.Telefono


            CType(Me.LoginView1.FindControl("lbIndirizzo"), Label).Text = Profile.DatiStudio.Indirizzo
            CType(Me.LoginView1.FindControl("lkEmail"), HyperLink).Text = Profile.DatiStudio.Email
            CType(Me.LoginView1.FindControl("lbFax"), Label).Text = Profile.DatiStudio.Fax
            CType(Me.LoginView1.FindControl("lbTel"), Label).Text = Profile.DatiStudio.Telefono


        Else

            Dim prAdmin As ProfileCommon = Profile.GetProfile("admin")

            CType(Me.LoginView1.FindControl("lbIndirizzo"), Label).Text = prAdmin.DatiStudio.Indirizzo
            CType(Me.LoginView1.FindControl("lkEmail"), HyperLink).Text = prAdmin.DatiStudio.Email
            CType(Me.LoginView1.FindControl("lbFax"), Label).Text = prAdmin.DatiStudio.Fax
            CType(Me.LoginView1.FindControl("lbTel"), Label).Text = prAdmin.DatiStudio.Telefono

        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Try
                Me.CaricaDati()
            Catch ex As Exception

            End Try
        End If

    End Sub

    Protected Sub btSalva_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim indirizzo, tel, fax, email As String
            indirizzo = CType(Me.LoginView1.FindControl("txtIndirizzo"), TextBox).Text
            tel = CType(Me.LoginView1.FindControl("txtTel"), TextBox).Text
            fax = CType(Me.LoginView1.FindControl("txtFax"), TextBox).Text
            email = CType(Me.LoginView1.FindControl("txtEmail"), TextBox).Text

            Profile.DatiStudio.Indirizzo = indirizzo
            Profile.DatiStudio.Email = email
            Profile.DatiStudio.Fax = fax
            Profile.DatiStudio.Telefono = tel
            'CType(Me.LoginView1.FindControl("lbMess"), Label).Text = "Ok"
            CType(Me.LoginView1.FindControl("tbRecapiti"), HtmlTable).Visible = True
            CType(Me.LoginView1.FindControl("tbRecapitiMod"), HtmlTable).Visible = False

            Me.CaricaDati()
        Catch ex As Exception
            CType(Me.LoginView1.FindControl("lbMess"), Label).Text = "Errore"
        End Try


    End Sub

    Protected Sub btModifica_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("tbRecapiti"), HtmlTable).Visible = False
        CType(Me.LoginView1.FindControl("tbRecapitiMod"), HtmlTable).Visible = True
    End Sub

    Protected Sub btAnnulla_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Me.LoginView1.FindControl("tbRecapiti"), HtmlTable).Visible = True
        CType(Me.LoginView1.FindControl("tbRecapitiMod"), HtmlTable).Visible = False
    End Sub

End Class
