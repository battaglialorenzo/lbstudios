<%@ Control Language="C#"%>
<asp:FormView ID="fvPrimoPiano" runat="server" CellPadding="0" DataKeyNames="IDFotografia"
    DataSourceID="objPrimoPiano" Width="100%">
    <ItemTemplate>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <th scope="row" style="background-color: #000000">
                    <img src="<%# Eval("UrlFoto", "imghandler.ashx?w=583&amp;h=402&amp;img={0}") %>" alt="" /></th>
                <td align="right" valign="top" style="width: 11px">
                    <img src="img/destraflash.jpg" width="11" height="402" alt="" /></td>
            </tr>
        </table>
    </ItemTemplate>
</asp:FormView>
<asp:ObjectDataSource ID="objPrimoPiano" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetFotografie_PrimoPiano" TypeName="DataFotografie"></asp:ObjectDataSource>
