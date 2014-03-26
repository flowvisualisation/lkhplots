
 cgloadct,33
 cgPS_Open, 'lineplot.ps', /encapsulated, /color
 dat=dist(16)
 dat=sin(2*!DPI*findgen(10,10))
 pos= cgLayout([1,1])
 cgimage, dat, pos=pos
 cgcontour, dat, /nodata, /noerase,pos=pos
   cgPS_Close, /PNG
   end
