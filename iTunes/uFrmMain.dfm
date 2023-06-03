object Form1: TForm1
  Width = 640
  Height = 480
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  object btnShow: TWebButton
    Left = 56
    Top = 88
    Width = 265
    Height = 25
    ElementID = 'btnShow'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnShowClick
  end
  object Request: TWebHttpRequest
    ResponseType = rtJSON
    URL = 
      'https://itunes.apple.com/search?term=star+wars&country=us&entity' +
      '=movie'
    Left = 80
    Top = 208
  end
end
