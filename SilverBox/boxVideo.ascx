<%@ Control Language="C#" AutoEventWireup="true" CodeFile="boxVideo.ascx.cs" Inherits="SilverBox_boxVideo" %>
<div id="divVideo">
            <div id="LandLogicITPlayer">
                <div id="silverlightControlHost">
        <object data="data:application/x-silverlight," type="application/x-silverlight" 
                        height="340" style="width: 480px">
		  <param name="initparams" value="Tipo=0,PreviewImage=,VideoSource=<%= Request.Url.Scheme + "://" + Request.Url.DnsSafeHost + ":" + Request.Url.Port %><%= UrlVideo %>,AutoPlay=true,EnableScrubbing=true" />
		  <param name="source" value="/LandLogicITPlayer.xap"/>
		  <param name="onError" value="onSilverlightError" />
		  <param name="onLoad" value="pluginLoaded" />
		  <param name="background" value="black" />
          <param name="windowless" value="true" />
		  <param name="minRuntimeVersion" value="3.0.40624.0" />
		  <param name="autoUpgrade" value="true" />
		  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=3.0.40624.0" style="text-decoration:none">
 			  <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style:none"/>
		  </a>
	    </object><iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe></div>
            </div>
             
        </div>