
 cgloadct,33
 cgPS_Open, 'lineplot.ps', /encapsulated, /color, font=1, tt_font='times'
 dat=dist(16)
 dat=sin(2*!DPI*findgen(10,10))
 pos= cgLayout([1,1])
 cgimage, dat, pos=pos
 cgcontour, dat, /nodata, /noerase,pos=pos, title='Test'
   cgPS_Close, /PNG
   end
