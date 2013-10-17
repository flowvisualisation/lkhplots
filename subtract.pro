 !p.position=0
 !p.multi=[0,1,3]
 window, xs=900, ys=1200


 cgplot, x3,vmri(16,16,*), xstyle=1, title="vmri"
 cgplot, x3, vx1(16,16,*), xstyle=1 , /overplot
 cgplot, x3,vx1(16,16,*), xstyle=1 
 cgplot, x3,smooth(vx(16,16,*),5), xstyle=1  
 cgplot, x3, vx(16,16,*), xstyle=1  , /overplot
end
