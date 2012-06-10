<%@ Page Language="C#" ValidateRequest="false" Trace="false" %>
<%@ Register Assembly="LandLogicIT" Namespace="LandLogicIT" TagPrefix="LLIT" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    //public void PulisciCache()
    //{
    //    List<string> keyList = new List<string>();
    //    IDictionaryEnumerator CacheEnum = Cache.GetEnumerator();
    //    while (CacheEnum.MoveNext())
    //    {
    //        keyList.Add(CacheEnum.Key.ToString());
    //    }
    //    foreach (string key in keyList)
    //    {
    //        Cache.Remove(key);
    //    }
    //}

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //this.PulisciCache(); 
            {
                string myCartella = Request.QueryString["tipo"];
                this.GalleriaImmagini1.RootImagesFolder = ConfigurationManager.AppSettings[myCartella];
                this.GalleriaImmagini1.CurrentImagesFolder = ConfigurationManager.AppSettings[myCartella];
            }

        }
        
       
    }
</script>

<html>
<head id="Head1" runat="server">
    <title>Galleria Immagini</title>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
            <LLIT:GalleriaImmagini ID="GalleriaImmagini1" runat="server" JavaScriptLocation="ExternalFile"
                UtilityImagesLocation="ExternalFile" SupportFolder="~/aspnet_client/FreeTextBox/"
                AllowImageDelete="true" AllowImageUpload="true" AllowDirectoryCreate="true"
                AllowDirectoryDelete="true">
            </LLIT:GalleriaImmagini>
    </form>
</body>
</html>
