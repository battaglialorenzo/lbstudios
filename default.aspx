<%@ Page MasterPageFile="MasterSito.master" Language="VB" %>

<%@ Register Src="ucBoxPrimoPiano.ascx" TagName="ucBoxPrimoPiano" TagPrefix="uc2" %>
<%@ Register Src="ucBoxSecondoPiano.ascx" TagName="ucBoxSecondoPiano" TagPrefix="uc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <uc1:ucBoxSecondoPiano ID="UcBoxSecondoPiano1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <uc2:ucBoxPrimoPiano ID="UcBoxPrimoPiano1" runat="server" />
</asp:Content>
