<%@ Page Language="C#" %>
<%@ Register Src="SilverBox/boxVideo.ascx" TagName="boxVideo" TagPrefix="uc1" %>
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
                <td style="height: 61px; background-color: #149b99" align="left" valign="bottom"
                    class="titolo">
                    <asp:FormView ID="fvCat" runat="server" Width="100%" DataSourceID="objCat">
                        <ItemTemplate>
                            <table width="100%" border="0" cellspacing="15">
                                <tr>
                                    <th align="left" valign="bottom" class="titolo" scope="row">
                                        Videogallery <span class="titolo2"> - <%# Eval("Label") %>
                                        </span>
                                    </th>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:ObjectDataSource ID="objCat" runat="server" SelectMethod="GetCategoria_ByVideov2"
                        TypeName="DataVideo">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="-1" Name="idvideo" QueryStringField="codvideo"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <asp:FormView ID="fvVideo" runat="server" Width="100%" DataSourceID="objVideo">
                        <ItemTemplate>
                            <table width="100%" border="0" cellspacing="15" cellpadding="0">
                                <tr>
                                    <th align="left" valign="top" scope="row">
                                       <iframe width="500" height="385" frameborder="0" marginheight="0"
                                                                         marginwidth="0" scrolling="no" src="http://www.youtube.com/watch_popup?v=<%#Eval("VideoId") %>"></iframe>
                                    </th>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <div class="testopopup" style="padding:15px;">
                                            <asp:Literal ID="ltDidascalia" runat="server" Text='<%# Eval("Title") %>'></asp:Literal></span>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:ObjectDataSource ID="objVideo" runat="server" SelectMethod="GetVideo_ByIDVideov2"
                        TypeName="DataVideo">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="-1" Name="idvideo" QueryStringField="codvideo"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
