nsim=12
 xs=1800
 ys=670
 cgdisplay,wid=4, xs=xs, ys=ys
 pos=cglayout([nsim/2,2] , OXMargin=[13,1], OYMargin=[14,1], XGap=0, YGap=0)
!p.position=0
!p.multi=0

;pload, 0, dir='q01', /nodata
tptr=ptrarr(14)

qarr=[ 0.1,0.3,0.5,0.7,  $
       0.9, 1.1,1.3,1.5, $
        1.6,1.7,1.8,1.9]
abarr=findgen(14)

closestshear=dblarr(14)
closestshear(*)=1.0

;nearshear, qarr, closestshear

for i=0,nsim-1 do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
print, dirtag
;PLOAD, 0, DIR = dirtag, var='vx2'
r=h5_read(0 ,/v, dir=dirtag)
grd_ctl,model=0, g,c, dir=dirtag 
vy3d0=reform(transpose(r.v(1,*,*,*)))
vy0=transpose(r.v(1,0,*,*))
getlast, nfile, dir=dirtag
get2last, nfile2, dir=dirtag
;nlast=40000
;nfile=closestshear[i]
;PLOAD, nfile, DIR = dirtag
r=h5_read(nfile ,/v, dir=dirtag, /remap)
grd_ctl,model=nfile, g,c, dir=dirtag
vx3d=reform(transpose(r.v(0,*,*,*)))
vy3d=reform(transpose(r.v(1,*,*,*)))-vy3d0
vz3d=reform(transpose(r.v(2,*,*,*)))
narr=reform( total( abs(vx3d),3) ) & tag="vx"
narr=reform( total( abs(vy3d),3) ) & tag="vy"
narr=reform( total( abs(vz3d),3) ) & tag="vz"
narr=reform( total( abs(vx3d*vy3d),3) ) & tag="vxvy"
narr=reform( total( sqrt(vx3d^2+vy3d^2+vz3d^2),3) ) & tag="vb2"

r=h5_read(nfile2 ,/v, dir=dirtag, /remap)
grd_ctl,model=nfile2, g,c, dir=dirtag
vx3d=reform(transpose(r.v(0,*,*,*)))
vy3d=reform(transpose(r.v(1,*,*,*)))-vy3d0
vz3d=reform(transpose(r.v(2,*,*,*)))
narr2=reform( total( sqrt(vx3d^2+vy3d^2+vz3d^2),3) ) & tag="vb2"
narr=narr2+narr

narr=narr-mean(narr)
;narr=reform(sqrt(bx^2+by^2+bz^2)) & tag="b2"
;narr=remapfunc (bx2(*,*,0) , t[nfile], nx1,nx2,qarr[i],  x1,x2,dx2)
;narr=congrid(narr, nx2,nx2)
tptr[i]=ptr_new(reform(narr))
endfor



items=[ $
    'q=0.1'  $
    , 'q=0.5'  $
    , 'q=0.7'  $
    , 'q=0.9'  $
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

 ;pos=cglayout([4,2] , OXMargin=[9,1], OYMargin=[13,2], XGap=1, YGap=4)
 cgerase
 cmap=57
 cgloadct,cmap


fname=tag+"qfft"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
charsize=cgdefcharsize()*.7
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*1.3
endelse


nx1=g.nx
nx2=g.ny
 kx=(findgen(nx1)/nx1-0.5d)*nx2
 ky=findgen(nx2)-nx2/2


qsm=10
for i=0,nsim-1 do begin
;cgplot, *tptr[i]/2./!DPI, abs(*bptr[i]), /overplot, color=cl[i], lines=ls[i]
px=pos[*,i]
dat=*tptr[i]
dat=alog10( abs (fft (*tptr[i] , /center)+1e-6))
dat=congrid(dat, nx2,nx2)
dgft=alog10 (abs (fft (*tptr[i] , /center)+1e-6))
dgft=congrid(dgft, nx2,nx2)
dgft=smooth(dgft ,qsm, /edge_wrap)
 kx=ky
r=cgscalevector(smooth(dat,qsm, /edge_wrap),1,254)
imin=min(dat)
imax=max(dat)
;print, 'q', qarr[i], imin, imax
cgimage, r , pos=px, /noerase , /keep_aspect_ratio


qe=0.01
xtickf="(a1)"
xtit=''
if ( i gt nsim/2-1 ) then begin
xtickf="(I4)"
    xtit="k!DX!N"
qe=0.07
endif
;cgcolorbar, range=[imin,imax], pos=[px[0] , px[1]-0.01-qe, px[2],px[1]-qe], charsize=charsize
ytickf="(a1)"
ytit=''
if ( (i mod (nsim/2) ) eq 0 ) then begin
ytickf="(I4)"
    ytit="k!DY!N"
endif
cgcontour, r, kx, ky, $
    /noerase, $
    /nodata, $
     xtickinterval=150,$
     ytickinterval=150,$
     xtickf=xtickf,$
     ytickf=ytickf,$
    pos=px, $
    charsize=charsize, $
    xtitle=xtit, $
    ytitle=ytit
    ;ytitle='q='+string(qarr[i],format='(F4.1)')+' ,  k!DY!N'
gft=gauss2dfit(dgft, aa,/tilt)
;print, 'a,b',aa[2], aa[3], aa[2]/aa[3]
;print, 'q=',qarr[i],' , a/b', aa[2]/aa[3]
a=max([aa[2],aa[3]])
b=min([aa[2],aa[3]])
print, qarr[i],a,b
abarr[i]=sqrt(1-(b/a)^2)
abarr[i]=a/b

cgloadct,cmap
    cgcontour, gft, kx,ky,  pos=px, color='white', label=0, /overplot ;, lev=[1e-5,1e-4, 1e-3]
    cgtext, -220,190 , 'q='+string(qarr[i],format='(F4.1)') ,color='white', charsize=charsize
endfor

print, 'q         , a/b'
for i=0,nsim-1 do begin
print, qarr[i], abarr[i]
endfor
if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 
cgimage, a
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
;al_legend, items, lines=ls, colors=cl, /right, charsize=cgdefcharsize()*1.5, linsize=.25

;READ_JPEG, 'qfft.jpg', a, TRUE=1 & cgimage, a
end
