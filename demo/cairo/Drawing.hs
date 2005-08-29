-- Example of an drawing graphics onto a canvas.
import Graphics.UI.Gtk
import Graphics.Rendering.Cairo

main = do
  initGUI
  dia <- dialogNew
  dialogAddButton dia stockOk ResponseOk
  contain <- dialogGetUpper dia
  canvas <- drawingAreaNew
  canvas `onSizeRequest` return (Requisition 40 40)
  text <- canvas `widgetCreateLayout` "Hello World."
  canvas `onExpose` updateCanvas canvas text
  boxPackStartDefaults contain canvas
  widgetShow canvas
  dialogRun dia
  return ()

updateCanvas :: DrawingArea -> PangoLayout -> Event -> IO Bool
updateCanvas canvas text (Expose { area=rect }) = do
  win <- drawingAreaGetDrawWindow canvas
  (width',height') <- drawingAreaGetSize canvas
  let width  = realToFrac width'
      height = realToFrac height'

  -- Draw using the cairo api
  renderWithDrawable win $ do
    setSourceRGB 1 0 0
    setLineWidth 20
    setLineCap LineCapRound
    setLineJoin LineJoinRound

    moveTo 30 30
    lineTo (width-30) (height-30)
    lineTo (width-30) 30
    lineTo 30 (height-30)
    stroke

    setSourceRGB 1 1 0
    setLineWidth 4
  
    save
    translate (width / 2) (height / 2)
    scale (width / 2) (height / 2)
    arc 0 0 1 (135 * pi/180) (225 * pi/180)
    restore
    stroke
  
    setSourceRGB 0 0 0
    moveTo 30 (realToFrac height / 2)
    showText "Hello World."

  -- draw some text using the Gdk api
  gc <- gcNew win
  drawLayoutWithColors win gc 30 (height' `div` 2) text 
    (Just (Color 0 0 0)) Nothing

  return True
