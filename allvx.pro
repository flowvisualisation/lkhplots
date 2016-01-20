!p.position=0
!p.multi=0

pload, 0, dir='q01', /nodata
nfile=3
tptr=ptrarr(12)

nplots=2
qarr=[ 0.1,1.9,0.7,0.9,1.1,1.3,1.5,1.9,1.9]
for i=0,nplots-1 do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
print, dirtag
PLOAD, 0, DIR = dirtag, var='vx2'
vy0=vx2(*,*,0)
PLOAD, nfile, DIR = dirtag;, var='vx3'
vx=reform(vx1(0,*,*))
vy=vx2(*,*,0)-vy0
vz=vx3(*,*,0)
narr=reform(sqrt(vx^2+vy^2+vz^2))
narr=vx
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

 pos=cglayout([1,2] , OXMargin=[13,1], OYMargin=[14,1], xgap=0, YGap=1)
 ;pos=cglayout([4,2] , OXMargin=[9,1], OYMargin=[13,2], XGap=1, YGap=4)
 xs=1200
 ys=800
 cgdisplay,wid=4, xs=xs, ys=ys
 cgerase
 cgloadct,33


fname="vxyz"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
charsize=cgdefcharsize()*.7
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse


 kx=(findgen(nx1)/nx1-0.5d)*nx2
 ky=findgen(nx2)-nx2/2


qsm=1
for i=0,1 do begin
;cgplot, *tptr[i]/2./!DPI, abs(*bptr[i]), /overplot, color=cl[i], lines=ls[i]
px=pos[*,i]
dat=*tptr[i]
dat=alog10( abs (fft (*tptr[i] , /center)+1e-6))
dat= *tptr[i]
;dat=congrid(dat, nx2,nx2)
dgft= (abs (fft (*tptr[i] , /center)+1e-6))
dgft=congrid(dgft, nx2,nx2)
dgft=smooth(dgft ,qsm, /edge_wrap)
 kx=ky
;r=cgscalevector(smooth(dat,qsm, /edge_wrap),1,254)
dat=congrid(dat,nx2*4,nx3*4, /cubic)
xx=congrid(x2,nx2*4)
yy=congrid(x3,nx3*4)
r=cgscalevector(dat,1,254)
imin=min(dat)
imax=max(dat)
;print, 'q', qarr[i], imin, imax
cgimage, r , pos=px, /noerase , /keep_aspect_ratio


qe=0.01
xtickf="(a1)"
xtit=''
if ( i gt 0 ) then begin
xtickf="(I4)"
    xtit="y"
qe=0.07
endif
;cgcolorbar, range=[imin,imax], pos=[px[0] , px[1]-0.01-qe, px[2],px[1]-qe], charsize=charsize
ytickf="(a1)"
ytit=''
if ( (i mod 1) eq 0 ) then begin
ytickf="(I4)"
    ytit="z"
endif
help,r,x1,x2
cgcontour, r, xx, yy, $
    /noerase, $
    /nodata, $
     ;xtickinterval=100,$
     ;ytickinterval=100,$
     xtickf=xtickf,$
     ytickf=ytickf,$
    pos=px, $
    charsize=charsize, $
    xtitle=xtit, $
    ytitle=ytit
    ;ytitle='q='+string(qarr[i],format='(F4.1)')+' ,  k!DY!N'
;gft=gauss2dfit(dgft, aa,/tilt)
;print, 'a,b',aa[2], aa[3], aa[2]/aa[3]
;print, 'q=',qarr[i],' , a/b', aa[2]/aa[3]
 ;   cgcontour, gft, kx,ky,  pos=px, color='Black', label=0, /overplot ;, lev=[1e-5,1e-4, 1e-3]
    cgtext, -5,2 , 'q='+string(qarr[i],format='(F4.1)') ,color='black', charsize=charsize
endfor


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
;al_legend, items, lines=ls, colors=cl, /right, charsize=cgdefcharsize()*1.5, linsize=.25

READ_JPEG, 'qfft.jpg', a, TRUE=1 & cgimage, a
end
