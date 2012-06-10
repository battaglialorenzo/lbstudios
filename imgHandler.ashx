<%@ WebHandler Language="VB" Class="imgHandler" %>

Imports System
Imports System.Web
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Byte

Public Class imgHandler : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Try
            context.Response.ContentType = "image/jpeg"
            Dim tipo As String = context.Request("tipo")
            Dim imageUrl As String = context.Server.UrlDecode(context.Request("img"))
            Dim imageHeight As Integer
            Dim imageWidth As Integer = context.Request("w")
            Dim fullSizeImg As System.Drawing.Image
        
            fullSizeImg = System.Drawing.Image.FromFile(context.Server.MapPath(imageUrl))
        
            If Not IsNothing(context.Request("h")) Then
                imageHeight = context.Request("h")
            Else
                imageHeight = (imageWidth * fullSizeImg.Height) / fullSizeImg.Width
          
            End If
        
            Select Case tipo
                Case "homelavori"
                    If imageHeight > 90 Then
                        imageWidth = (90 * imageWidth) / imageHeight
                        imageHeight = 90
                    End If
                Case "homenews"
                    If imageHeight > 84 Then
                        imageWidth = (84 * imageWidth) / imageHeight
                        imageHeight = 84
                    End If
                Case "dettaglionews"
                    If imageHeight > 150 Then
                        imageWidth = (150 * imageWidth) / imageHeight
                        imageHeight = 150
                    End If
                Case "dettagliolavoro"
                    If imageHeight > 51 Then
                        imageWidth = (51 * imageWidth) / imageHeight
                        imageHeight = 51
                    End If
                Case "galleria"
                    If imageHeight > 115 Then
                        imageWidth = (115 * imageWidth) / imageHeight
                        imageHeight = 115
                    End If
                Case "zoom"
                    If imageHeight > 450 Then
                        imageWidth = (450 * imageWidth) / imageHeight
                        imageHeight = 450
                    End If
            End Select
        
            context.Response.Clear()
            context.Response.BufferOutput = True
 
            If imageHeight > 0 And imageWidth > 0 Then
                If imageHeight >= fullSizeImg.Height And imageWidth >= fullSizeImg.Width Then
                    fullSizeImg.Save(context.Response.OutputStream, fullSizeImg.RawFormat)
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
                    Dim colorEncoder As Imaging.Encoder = Imaging.Encoder.ColorDepth
                
                    Dim ratio As EncoderParameter = New EncoderParameter(qualityEncoder, 100L)
                    Dim light As EncoderParameter = New EncoderParameter(colorEncoder, 24L)
                    Dim codecParams As New EncoderParameters(2)
                    codecParams.Param(0) = ratio
                    codecParams.Param(1) = light
                
                    Dim Brightness As Single = CSng(50 - 50) / 50
                    Dim BMatrix As ColorMatrix = New ColorMatrix(New Single()() _
                 {New Single() {1, 0, 0, 0, 0}, _
                New Single() {0, 1, 0, 0, 0}, _
                New Single() {0, 0, 1, 0, 0}, _
                New Single() {0, 0, 0, 1, 0}, _
                New Single() {Brightness, Brightness, Brightness, 0, 1}})
                    ApplyColorMatrix(mybmp, BMatrix)
                

                    'mybmp.Save(Response.OutputStream, ImageFormat.Jpeg)
                    mybmp.Save(context.Response.OutputStream, GetEncoderInfo(mimeType), codecParams)
                    objGraphics.Dispose()
                    mybmp.Dispose()
                End If
           
            Else
                fullSizeImg.Save(context.Response.OutputStream, ImageFormat.Jpeg)
            End If
        
            fullSizeImg.Dispose()
            context.Response.Flush()

        Catch ex As Exception

        End Try
       
        
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
    
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    
    
End Class