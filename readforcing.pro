 readcol, "averages.dat", n, t, dke,ke,k 
 
 xs=1000
 ys=xs
 cgdisplay, xs=xs,ys=ys
 pos=cglayout([1,1], oxmargin=[16,11], oymargin=[11,11])
 tnorm=t/2.0/!DPI
 
 px=pos[*,0]
 cgplot, tnorm,dke, $
    charsize=1.5*cgdefcharsize(),$
    pos=px, $
    linestyle=0,$
    ;psym=2, $
    title="Forced HD turbulence", $
    ytitle="!7q!Xv!U2!N/2", $
    xtitle="t (orbits) "


end
