<%@ Page Language="VB" EnableSessionState="ReadOnly" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing" %>

<script language="VB" runat="server">

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        
        Dim tipo As String = Request.QueryString("tipo")
      
        Dim imageUrl As String = Server.UrlDecode(Request.QueryString("img"))
    
   
        Dim imageHeight As Integer
        
        Dim imageWidth As Integer = Request.QueryString("w")

        Dim fullSizeImg As System.Drawing.Image
        
        If tipo = "anteprima" Then
            fullSizeImg = System.Drawing.Image.FromStream(New IO.MemoryStream(CType(Session("Byte"), Byte())), True, False)

            Response.ContentType = CStr(Session("Content"))

        Else
            Try
                fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(imageUrl))
            catch ex as Exception
                fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath("IN_costruzione.jpg"))
            Finally
                 Response.ContentType = "image/jpeg"   
            End Try
            
        End If
        
        If Not IsNothing(Request.QueryString("h")) Then
            imageHeight = Request.QueryString("h")
        Else
            imageHeight = (imageWidth * fullSizeImg.Height) / fullSizeImg.Width

        End If
       
        Select Case tipo
            Case "galleria"
                If imageHeight > 130 Then
                    imageWidth = (130 * imageWidth) / imageHeight
                    imageHeight = 130
                End If
            Case "galimg"
                If imageHeight > 94 Then
                    imageWidth = (94 * imageWidth) / imageHeight
                    imageHeight = 94
                End If
            Case "logoclienti"
                If imageHeight > 65 Then
                    imageWidth = (65 * imageWidth) / imageHeight
                    imageHeight = 65
                End If
            Case "news"
                If imageHeight > 80 Then
                    imageWidth = (80 * imageWidth) / imageHeight
                    imageHeight = 80
                End If
            Case "abiti"
                If imageHeight > 94 Then
                    imageWidth = (94 * imageWidth) / imageHeight
                    imageHeight = 94
                End If
            Case "zoomnews"
                If imageHeight > 200 Then
                    imageWidth = (200 * imageWidth) / imageHeight
                    imageHeight = 200
                End If
            Case "zoomfoto"
                If imageHeight > 600 Then
                    imageWidth = (600 * imageWidth) / imageHeight
                    imageHeight = 600
                End If
            Case "antvideo"
                If imageHeight > 150 Then
                    imageWidth = (150 * imageWidth) / imageHeight
                    imageHeight = 150
                End If
        End Select
        
        Response.Clear()
        Response.BufferOutput = True

        If imageHeight > 0 And imageWidth > 0 Then
            If imageHeight >= fullSizeImg.Height And imageWidth >= fullSizeImg.Width Then
                fullSizeImg.Save(Response.OutputStream, fullSizeImg.RawFormat)
            Else
                Dim mybmp As New Bitmap(imageWidth, imageHeight)
                Dim objGraphics As Graphics = Graphics.FromImage(mybmp)
                
                objGraphics.CompositingMode = Drawing2D.CompositingMode.SourceOver
                objGraphics.CompositingQuality = Drawing2D.CompositingQuality.GammaCorrected
                
                objGraphics.PixelOffsetMode = Drawing2D.PixelOffsetMode.HighQuality

                objGraphics.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
                objGraphics.SmoothingMode = Drawing2D.SmoothingMode.HighQuality
                objGraphics.DrawImage(fullSizeImg, 0, 0, mybmp.Width, mybmp.Height)
                
				Dim qualityEncoder As Imaging.Encoder = Imaging.Encoder.Quality
            	Dim ratio As EncoderParameter = New EncoderParameter(qualityEncoder, 100L)

            	Dim codecParams As New EncoderParameters(1)
            	codecParams.Param(0) = ratio
			
						   Dim Brightness As Single = CSng(50 - 50) / 50
               Dim BMatrix As ColorMatrix = New ColorMatrix(New Single()() _
             {New Single() {1, 0, 0, 0, 0}, _
            New Single() {0, 1, 0, 0, 0}, _
            New Single() {0, 0, 1, 0, 0}, _
            New Single() {0, 0, 0, 1, 0}, _
            New Single() {Brightness, Brightness, Brightness, 0, 1}})
                ApplyColorMatrix(mybmp, BMatrix)
			
				mybmp.Save(Response.OutputStream, GetEncoderInfo(mimeType), codecParams)
				
                'mybmp.Save(Response.OutputStream, ImageFormat.Jpeg)
                objGraphics.Dispose()
                mybmp.Dispose()
            End If
           
        Else
            fullSizeImg.Save(Response.OutputStream, ImageFormat.Jpeg)
        End If
        
        fullSizeImg.Dispose()
        Response.Flush()

    End Sub
	
	Dim mimeType As String = "image/jpeg"
    Function GetEncoderInfo(ByVal mimeType As String) As ImageCodecInfo
        Dim j As Integer
        Dim encoders() As ImageCodecInfo
        encoders = ImageCodecInfo.GetImageEncoders()
        For j = 0 To encoders.Length - 1
            If encoders(j).MimeType = mimeType Then
                Return encoders(j)
                
            End If
        Next
        
        Return Nothing
 
    End Function
	
		    Private Sub ApplyColorMatrix(ByRef MyImage As Drawing.Image, ByRef MyMatrix As ColorMatrix)
        'The magic that converts the image
        Dim ImgAtt As New ImageAttributes
        Dim bmpMatrix As New Bitmap(MyImage.Width, MyImage.Height)
        Dim grMatrix As Graphics = Graphics.FromImage(bmpMatrix)
        'Put the matrix into an ImageAttribute
        ImgAtt.SetColorMatrix(MyMatrix)

        'This Gamma code doesn't fit in elegantly with the rest of the code
        'but it's a useful extra idea with very little code.
        'You would integrate it better in real code.
        'We want the Gamma value to vary from 0 to 4 with 1=normal
        Dim Gamma As Single = CSng(50) / 50
        If Gamma > 1 Then Gamma += 3 * (Gamma - 1)

        ImgAtt.SetGamma(Gamma)

        'Now draw the whole of MyImage onto bmpMatrix using the ImgAtt matrix
        grMatrix.DrawImage(MyImage, New Rectangle(0, 0, MyImage.Width, MyImage.Height), 0, 0, MyImage.Width, MyImage.Height, GraphicsUnit.Pixel, ImgAtt)
        'Now show the transformed image
        MyImage = bmpMatrix
        'Always a good habit to dispose of these graphic things
        grMatrix.Dispose()
        ImgAtt.Dispose()
    End Sub
	

</script>

