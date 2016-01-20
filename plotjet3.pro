

au=1.49e13
lu=10*au
vu=1e5
tu=lu/vu
year=3.15569e7
tuyear=tu/year
distsource=59.0

cgdisplay, xs=1400,ys=700
cgloadct,33
pload,0, /nodata
nend=nlast
nbeg=max([5, nlast-20])
nbeg=5
nbeg=90
nbeg=5



for nfile=nbeg,nend do begin
nbef=nfile-1
pload,nbef, /silent
print, nfile


sl=nx1/2
u=reform(vx2(sl,*,*))
v=reform(vx3(sl,*,*))
d=reform(rho(sl,*,*))
d=reform(total(rho^2,1))


pload,nfile, /silent
u2=reform(vx2(sl,*,*))
v2=reform(vx3(sl,*,*))
d2=reform(rho(sl,*,*))
d2=reform(total(rho,1))


rescale=distsource/10
x1=x1/rescale
x2=x2/rescale
x3=x3/rescale
x3d=rebin(reform(x1,nx1,1,1),nx1,nx2,nx3)
y3d=rebin(reform(x2,1,nx2,1),nx1,nx2,nx3)
z3d=rebin(reform(x3,1,1,nx3),nx1,nx2,nx3)
posx=reform(y3d(sl,*,*) )
posy=reform(z3d(sl,*,*) )

datptr=ptrarr(4)
uptr=ptrarr(4)
uptr[0]=ptr_new(reform( u) )
uptr[1]=ptr_new(reform( u2) )
vptr=ptrarr(4)
vptr[0]=ptr_new(reform( v) )
vptr[1]=ptr_new(reform( v2) )
titstr=strarr(4)
datptr[0]=ptr_new(reform((    d )   ) )
titstr[0]='log!D10!N density, t='+string(t(nfile)*tuyear, format='(F6.1)')+' '
datptr[1]=ptr_new(reform((    d2 )   ) )
titstr[1]='t='+string(t(nfile), format='(F6.1)')+' '
datptr[2]=ptr_new(reform(           vx2(sl,*,*)     ) )
titstr[2]='vy'
datptr[2]=ptr_new(reform(           total(rho,1)     ) )
titstr[2]='Column density'
datptr[3]=ptr_new(reform(alog10(    prs(sl,*,*)     ) ) )

titstr[3]='log !D10!N Pressure'
colarr=strarr(2)
colarr[0]='GRN6'
colarr[1]='blue'

spawn, 'basename $PWD', a
dirname=a
dirtag=a
fname="contplot"+dirtag+string(nfile, format='(I05)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
!p.font=1
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
omega_str='!9W!X'
charsize=cgdefcharsize()*0.5
endif else  begin
set_plot, 'x'
;!p.font=-1
omega_str='!7X!X'
charsize=cgdefcharsize()*1.2
endelse



cgerase
for i=0,0 do begin
pos=cglayout( [1,1])
dat=*datptr[0]
dat2=*datptr[1]
r=cgscalevector(dat,1,254)
r2=cgscalevector(dat2,1,254)
cgloadct,33
plotim=1
if (plotim eq 1) then begin
if ( i eq 0) then begin
;cgimage, r, pos=pos[*,i]
endif else begin
;cgimage, r, pos=pos[*,i], /noerase
endelse
endif
cgcontour,r,x2,x3, /noerase, $
   ;/nodata, $
    color=colarr[i],thick=2,  $
    label=0,$
    pos=pos[*,i], $
    charsize=charsize,$
    title=titstr[i],$
    xtitle='X Offset (arcsec)',$
    ytitle='Y Offset (arcsec)'
   ; if ( i eq 0)  then begin
cgcontour,r2,x2,x3, $
    label=0,$
    /overplot, color=colarr[1]
t1='t = '+string(t(nbef)*tuyear, format='(F6.0)') ;+ ' years'
t2='t = '+string(t(nfile  )*tuyear, format='(F6.0)') ;+ ' years'
items=[t1,t2]
al_legend, items, lines=[0,0], colors=colarr[0:1], /right,charsize=charsize
u=*uptr[i]
v=*vptr[i]
qx=23
qy=15
uq=congrid(u,qx,qy)
vq=congrid(v,qx,qy)
px=congrid(x2,qx)
py=congrid(x3,qy)
;velovect, uq,vq,px,py, pos=pos[*,i], /overplot, $ 
    ;color=cgcolor('black')
;    color=cgcolor('white')
;endif
endfor


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


endfor

cgloadct,33
end
