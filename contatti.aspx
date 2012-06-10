<%@ Page MasterPageFile="MasterSito.master" Language="VB" Title="Riccardo Battaglia - Photography: Contatti" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="ucRecapiti.ascx" TagName="ucRecapiti" TagPrefix="uc1" %>

<script runat="server">

    Protected Sub btInvia_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Page.IsValid Then
            Try
                Dim corpo As New StringBuilder("Modulo contatti" & vbNewLine)
                corpo.Append("-----------------------------------------------" & vbNewLine)
                corpo.Append("Nome: " & txtNome.Text & vbNewLine)
                corpo.Append("Cognome: " & txtCognome.Text & vbNewLine)
                corpo.Append("Email: " & txtEmail.Text & vbNewLine)
                corpo.Append("Telefono: " & txtTel.Text & vbNewLine)
                corpo.Append("Messaggio: " & txtMessaggio.Text & vbNewLine)

                Dim objmail As New Net.Mail.MailMessage("noreply@riccardobattaglia.it", "info@riccardobattaglia.it", "Modulo contatti - Sito", corpo.ToString)
                Dim smtp As New Net.Mail.SmtpClient("localhost")
                smtp.Send(objmail)
                Me.lbMess.Text = " - Dati inviati"
            Catch ex As Exception
                Me.lbMess.Text = " - Errore: Dati non inviati. Tentare di nuovo."
            End Try

            
        End If
    End Sub
</script>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucRecapiti ID="UcRecapiti1" runat="server" ColoreLinea="#9C6363" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <th align="left" valign="top" style="background-color: #ebebeb" scope="row">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th style="height: 61px; background-color: #9c6363" align="left" valign="bottom"
                            class="titolo" scope="row">
                            <table width="100%" border="0" cellspacing="15">
                                <tr>
                                    <th align="left" valign="bottom" class="titolo" scope="row">
                                        Contatti<asp:Label ID="lbMess" runat="server"></asp:Label></th>
                                </tr>
                            </table>
                        </th>
                    </tr>
                    <tr>
                        <th align="left" valign="top" scope="row">
                            <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                <tr>
                                    <th align="left" valign="top" scope="row">
                                        <table cellspacing="5" cellpadding="0" width="100%" border="0" class="testostandard">
                                            <tbody>
                                                <tr>
                                                    <th class="testo" scope="row" align="left" colspan="2">
                                                        <strong>Per contatti via e-mail consigliamo di compilare il seguente modulo:</strong></th>
                                                </tr>
                                                <tr>
                                                    <th class="testo" scope="row" align="left">
                                                        <strong>Nome:
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNome"
                                                                ErrorMessage="*" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:RequiredFieldValidator></strong></th>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtNome" runat="server" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="testo" scope="row" align="left">
                                                        <strong>Cognome:
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCognome"
                                                                ErrorMessage="*" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:RequiredFieldValidator></strong></th>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtCognome" runat="server" Font-Names="Verdana" Font-Size="12px"
                                                            ValidationGroup="contatti"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="testo" scope="row" align="left">
                                                        <strong>E-mail:
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail"
                                                                ErrorMessage="*" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
                                                                    Display="Dynamic" ErrorMessage="*" Font-Names="Verdana" Font-Size="12px" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                    ValidationGroup="contatti"></asp:RegularExpressionValidator></strong></th>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtEmail" runat="server" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="testo" scope="row" align="left">
                                                        <strong>Telefono:
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtTel"
                                                                ErrorMessage="*" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:RequiredFieldValidator></strong></th>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtTel" runat="server" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="testo" scope="row" align="left">
                                                        <strong>Messaggio:
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtMessaggio"
                                                                ErrorMessage="*" Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti"></asp:RequiredFieldValidator></strong></th>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtMessaggio" runat="server" Rows="5" Columns="50" TextMode="MultiLine"
                                                            Font-Names="Verdana" Font-Size="12px" ValidationGroup="contatti" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="testo" scope="row" align="left" colspan="2">
                                                        <asp:Panel ID="plInfo" runat="server" Width="472px">
                                                            <div style="cursor: pointer; padding-right: 0px; padding-left: 0px; padding-bottom: 5px;
                                                                padding-top: 5px;">
                                                                <asp:Label ID="lbInfo" runat="server" Text="Informativa ai sensi dell’art. 13 del D.Lgs. 196/2003"
                                                                    Font-Underline="True" /><span style="margin-left: 20px;">
                                                                        <asp:Label ID="Label1" runat="server" ForeColor="#9C6363">(Mostra...)</asp:Label>
                                                                    </span>
                                                            </div>
                                                        </asp:Panel>
                                                        <asp:Panel ID="plInformativa" runat="server" Width="472px" Height="0px">
                                                            <br />
                                                            <p style="text-align: left">
                                                                INFORMATIVA ART. 13 D.lgs 196/2003</p>
                                                            <p style="text-align: left" class="testoboxhome">
                                                                Ai sensi e per gli effetti dell'art.13 D.lgs 196/2003 informiamo che Riccardo Battaglia
                                                                procederà al trattamento dei dati da Lei forniti nel rispetto della normativa in
                                                                materia di tutela del trattamento dei dati personali.
                                                                <br />
                                                                Il conferimento dei dati è facoltativo ma un eventuale rifiuto di fornirli determina
                                                                l'impossibilità di dare esecuzione all'invio del messaggio.<br />
                                                                I dati personali da Lei forniti sono raccolti con modalità telematiche e trattati,
                                                                anche con l'ausilio di mezzi elettronici, direttamente e/o tramite terzi delegati
                                                                (società di consegna) per le finalità connesse all'esecuzione del servizio;</p>
                                                            <p style="text-align: left" class="testoboxhome">
                                                                In ogni caso i suoi dati non verranno comunicati o venduti a terzi.<br />
                                                                I dati potranno essere conosciuti solo da soggetti specificatamente incaricati alla
                                                                gestione dei clienti.<br />
                                                                Ai sensi dell'art. 7 del D. Lgs. 196/2003, Lei ha diritto in qualsiasi momento di
                                                                ottenere informazioni sul trattamento dei Suoi dati, sulle sue modalità e finalità
                                                                e sulla logica ad esso applicata nonché:<br />
                                                                1) la conferma dell'esistenza dei dati e la comunicazione degli stessi e della loro
                                                                origine;<br />
                                                                2) gli estremi identificativi del Titolare e dei Responsabili nonché i soggetti
                                                                o le categorie di soggetti ai quali i dati possono essere comunicati o che possono
                                                                venirne a conoscenza in qualità di Responsabili o incaricati;<br />
                                                                3) l'aggiornamento, la rettifica e l'integrazione dei dati;<br />
                                                                4) la cancellazione, la trasformazione in forma anonima, il blocco dei dati trattati
                                                                in violazione di legge;<br />
                                                                5) l'attestazione che le operazioni di cui ai punti 3) e 4) sono state portate a
                                                                conoscenza di coloro ai quali i dati sono stati comunicati e diffusi, con l’eccezione
                                                                del caso in cui tale adempimento si rivela impossibile o comporta un impiego di
                                                                mezzi manifestamente sproporzionato rispetto al diritto tutelato;<br />
                                                                6) di opporsi: al trattamento dei dati, ancorché pertinenti allo scopo della raccolta,
                                                                per motivi legittimi al trattamento dei dati per fini di informazione commerciale
                                                                o per il compimento di ricerche di mercato.</p>
                                                            <p style="text-align: left" class="testoboxhome">
                                                                Titolare e responsabile del trattamento dei dati è il <strong>sig. Riccardo Battaglia
                                                                </strong>
                                                                <br />
                                                                Potranno essere esercitati i diritti tramite comunicazione ai seguenti recapiti:<br />
                                                                <strong>E-mail:</strong> <a href="mailto:info@riccardobattaglia.it" style="color: #9c6363">
                                                                    info@riccardobattaglia.it </a>
                                                                <br />
                                                                <strong>Indirizzo:</strong> Viale Roma, 16 - 70031 Andria (Barletta Andria Trani)
                                                                <br />
                                                                <strong>Telefono: </strong>0883 556407<strong>
                                                                    <br />
                                                                    Fax:</strong> 0883 556407
                                                            </p>
                                                        </asp:Panel>
                                                        <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="plInformativa"
                                                            ExpandControlID="plInfo" CollapseControlID="plInfo" Collapsed="True" SuppressPostBack="True"
                                                            TextLabelID="Label1" ExpandedText="(Nascondi...)" CollapsedText="(Mostra...)">
                                                        </cc1:CollapsiblePanelExtender>
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <th class="testo" scope="row" align="left">
                                                        <strong>Consenso:
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="listConsenso"
                                                                Display="Dynamic" ErrorMessage="*" ValidationGroup="contatti"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                                                    ID="RequiredFieldValidator7" runat="server" ControlToValidate="listConsenso"
                                                                    Display="Dynamic" ErrorMessage="*" InitialValue="no" ValidationGroup="contatti"></asp:RequiredFieldValidator></strong></th>
                                                    <td align="left">
                                                        <label>
                                                            <span class="testo">
                                                                <asp:RadioButtonList ID="listConsenso" runat="server" RepeatColumns="2" ValidationGroup="contatti">
                                                                    <asp:ListItem>si</asp:ListItem>
                                                                    <asp:ListItem>no</asp:ListItem>
                                                                </asp:RadioButtonList></span></label></td>
                                                </tr>
                                                <tr id="trPulsanti">
                                                    <th valign="middle" scope="row" align="center" colspan="2">
                                                        <asp:Button ID="btInvia" runat="server" Text="Invia" BackColor="#9C6363" BorderStyle="None"
                                                            Font-Bold="True" Font-Names="Verdana" Font-Size="12px" ForeColor="White" ValidationGroup="contatti"
                                                            OnClick="btInvia_Click" />
                                                    </th>
                                                </tr>
                                            </tbody>
                                        </table>
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
