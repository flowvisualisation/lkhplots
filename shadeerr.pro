  y=20*cos(findgen(50)/3)
  cgplot,y,ystyle=2 , /nodata
  bot=y-1.0
  top=y+1.0
  cgcolorfill,[findgen(50),reverse(findgen(50))],[bot,reverse(top)],/data, color='pink'
  cgplot,y,color=0, /overplot
  end
