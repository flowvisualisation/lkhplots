
   cgPS_Open, 'lineplot.png', tt_font='Times Bold'
   !p.charthick=30
   cgPlot, Findgen(11), COLOR='navy', /NODATA, XTITLE='Time', YTITLE='Signal', charthick=10, charsize=3
   cgPlot, Findgen(11), COLOR='indian red', /OVERPLOT
   cgPlot, Findgen(11), COLOR='olive', PSYM=2, /OVERPLOT
   cgPS_Close
   end
