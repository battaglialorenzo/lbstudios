<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Riccardo Battaglia - Photography</title>
    <link href="stilebattaglia.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-5659737-49']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</head>
<body>
    <form id="frmPopup" runat="server">
        <div align="center">
            <table width="480" border="0" cellpadding="0" cellspacing="0" style="background-color: #EBEBEB">
                <tr>
                    <th style="height: 61px; background-color: #949C63" align="left" valign="bottom"
                        class="titolo" scope="row">
                        <asp:FormView ID="fvCat" runat="server" Width="100%" DataSourceID="objCat">
                            <ItemTemplate>
                                <table width="100%" border="0" cellspacing="15">
                                    <tr>
                                        <th align="left" valign="bottom" class="titolo" scope="row">
                                            Fotogallery <span class="titolo2">-
                                                <asp:Literal ID="ltCat" runat="server" Text='<%# Eval("NomeCategoria") %>'></asp:Literal>
                                            </span>
                                        </th>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:ObjectDataSource ID="objCat" runat="server" SelectMethod="GetCategoria_ByFoto"
                            TypeName="DataFotografie">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="-1" Name="idfoto" QueryStringField="codfoto"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </th>
                </tr>
                <tr>
                    <th align="left" valign="top" scope="row">
                        <asp:FormView ID="fvFoto" runat="server" Width="100%" DataSourceID="objFoto">
                            <ItemTemplate>
                                <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                    <tr>
                                        <th align="left" valign="top" scope="row">
                                            <img alt="" src="<%# Eval("UrlFoto", "imghandler.ashx?w=450&img={0}") %>" /></th>
                                    </tr>
                                    <tr>
                                        <th align="left" valign="top" scope="row">
                                            <span class="testopopup">
                                                <asp:Literal ID="ltDidascalia" runat="server" Text='<%# Eval("Didascalia") %>'></asp:Literal></span></th>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:ObjectDataSource ID="objFoto" runat="server" SelectMethod="GetFoto" TypeName="DataFotografie">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="-1" Name="idfoto" QueryStringField="codfoto"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </th>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
