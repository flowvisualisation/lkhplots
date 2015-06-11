
cgDisplay, WID=1
   cgLoadCT, 22, /Brewer, /Reverse
   pos = cgLayout([2,1], OXMargin=[5,5], OYMargin=[5,12], XGap=3, YGap=10)
   FOR j=0,1 DO BEGIN
     p = pos[*,j]
     cgImage, cgDemoData(18), NoErase=j NE 0, Position=p
     cgColorBar, position=[p[0], p[3]+0.05, p[2], p[3]+0.1]
   ENDFOR
   cgText, 0.5, 0.925, /Normal, 'Example Image Layout', Alignment=0.5, $
      Charsize=cgDefCharsize()*1.25
		end
