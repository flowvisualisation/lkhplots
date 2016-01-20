pload, 0, dir='q01', /nodata
nfile=50
tptr=ptrarr(12)

qarr=[0.1,0.5,0.7,0.9,1.3,1.5,1.7,1.9]
for i=0,7 do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
print, dirtag
PLOAD, nfile, DIR = dirtag, var='bx2'
tptr[i]=ptr_new(reform(bx2(*,*,0)))
endfor


bptr=ptrarr(12)
bptr[0]=ptr_new(bx1)
bptr[1]=ptr_new(bx1)
bptr[2]=ptr_new(bx1)
bptr[3]=ptr_new(bx1)
bptr[4]=ptr_new(bx1)
bptr[5]=ptr_new(bx1)
bptr[6]=ptr_new(bx1)
bptr[7]=ptr_new(bx1)

items=[ $
    'q=0.5'  $
    , 'q=0.7'  $
    , 'q=0.9'  $
    , 'q=1.1'  $
    , 'q=1.3'  $
    , 'q=1.5'  $
    , 'q=1.7'  $
    , 'q=1.9'  $
    ]

cl=[ $
    'red'  $
    , 'orange'  $
    , 'yellow'  $
    , 'green'  $
    , 'blue'  $
    , 'violet'  $
    , 'black'  $
    , 'black'  $
    ]

ls=[0,1,2,3,4,5,6,7]

;tmax=max([t1,t2,t3 , $     
;    t4, t13, t15, t17,t19 ])/2/!DPI
;ymax=10*max( [ abs(bxy1) , abs(bxy2) , abs(bxy3) ] )

thick=2.
;cgplot, *tptr[0]/2./!DPI, abs(*bptr[0]), /ylog, yrange=[1e-6*ymax,ymax], color=cl[0], xrange=[0,tmax], lines=ls[0], $
;    xtitle='t, orbits', $
;    ytitle='BxBy '

 pos=cglayout([2,4] , OXMargin=[12,5], OYMargin=[9,5], XGap=12, YGap=11)
 cgdisplay, xs=800, ys=1250
 cgloadct,33

 kx=findgen(nx1)-nx1/2
 ky=findgen(nx2)-nx2/2
for i=0,7 do begin
;cgplot, *tptr[i]/2./!DPI, abs(*bptr[i]), /overplot, color=cl[i], lines=ls[i]
px=pos[*,i]
dat=*tptr[i]
dat=alog10( abs (fft (*tptr[i] , /center)+1e-6))
r=cgscalevector(dat,1,254)
imin=min(dat)
imax=max(dat)
print, 'q', qarr[i], imin, imax
cgimage, dat , pos=px, /noerase
cgcolorbar, range=[imin,imax], pos=[px[0] , px[1]-0.05, px[2],px[1]-0.04]
cgcontour, r, kx, ky, $
    /noerase, $
    /nodata, $
    pos=px, $
    xtitle='kx', $
    ytitle='ky', $
    title='q='+string(qarr[i],format='(F4.1)')
endfor


im=cgsnapshot(filename='qfft',/nodialog,/jpeg)
;al_legend, items, lines=ls, colors=cl, /right, charsize=cgdefcharsize()*1.5, linsize=.25

end
