;pro dotraj, model
spawn,'ls usr??????.h5 | tail -1', listing
spawn,'ls usr???????.h5 | tail -1', listing2

nbeg  =1000000L
nbeg  =100000L
nstep =100000L
getlast, nend
;nbeg=nend

xs=380
ys=720
xs=800
ys=800
cgdisplay, xs=xs,ys=ys

for nfile= nbeg, nend, nstep do begin
model=nfile
;xs=550
;ys=1100
mydat=h5_read( model, /b,/v,/rho,/p) 
grd_ctl, model=model, p ,c
dat=reform(mydat.rho)
var='rho'
titstr=' log!D10!N density'
dat2=transpose(dat)
xx=p.x
yy=!PI/2-p.y

b1=transpose(reform(mydat.b(0,*,*)))
b2=transpose(reform(mydat.b(1,*,*)))
b3=transpose(reform(mydat.b(2,*,*)))
v1=transpose(reform(mydat.v(0,*,*)))
v2=transpose(reform(mydat.v(1,*,*)))
v3=transpose(reform(mydat.v(2,*,*)))
pres=transpose(reform(mydat.p(*,*)))


lrho=alog10(dat2)
x1=xx & x2=yy
polar, lrho , x1,x2, sample=5
x1=xx & x2=yy
polar, dat2, x1,x2, sample=5
x1=xx & x2=yy
polar, b1, x1,x2, sample=5
x1=xx & x2=yy
polar, b2, x1,x2, sample=5
x1=xx & x2=yy
polar, b3, x1,x2, sample=5
x1=xx & x2=yy
polar, v1, x1,x2, sample=5
x1=xx & x2=yy
polar, v2, x1,x2, sample=5
x1=xx & x2=yy
polar, v3, x1,x2, sample=5
x1=xx & x2=yy
polar, pres, x1,x2, sample=5


alf2, b1,b2,b3,v1,v2,dat2,pres,mf,ma,ms


fname="traj"+string(model, format='(I07)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse


pos=[0.1,0.1,0.9,.96]
pos=cglayout ( [1,1] ,OXMargin=[9,4], OYMargin=[9,9], XGap=5, YGap=3   )
scl=cgscalevector(lrho,1,255)
cgloadct,33

;cgimage, scl, pos=pos;, /noerase
cgcontour, scl,x1,x2, $
   ; /noerase, $
  ; /nodata, $
    /fill, $
    nlev=128, $
    xrange=[0,5],$
    yrange=[0,5],$
    pos=pos[*,0], title=titstr+', t='+string(c.time, format='(F5.2)')
imin=min(lrho)
imax=max(lrho)
cgcolorbar, range=[imin,imax], pos=[pos[0],pos[1]-0.08,pos[2],pos[1]-0.07 ]


;cgcontour, ma, pos=pos[*,0], /overplot, lev=1

q=h5_parse("particles.h5", /read)   
sz=size(q.time._DATA, /dimensions)

ptime=q.time._DATA 
aa=where ( ptime gt c.time)
tn=aa(0)
print, tn, ptime(tn), c.time
;tn=1800

symsize=0.5
psym=16
for i=0,3000-1,10 do begin
ppar=i
rad=reform( q.position._DATA[0,0:tn,ppar])
th=reform ( q.position._DATA[1,0:tn,ppar])
;if (  ((th[sz-1] ge 11./20*!DPI) || ( th[sz-1] le 9./20*!DPI ) ) && ( rad[0] le 5 ) ) then begin
if (  rad[0] le 5  ) then begin
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='green', $
	psym=psym, $ 
	symsize=symsize
   endif
   endfor

for i=3000,6000-1,7 do begin
ppar=i
; rad=reform (q.position._DATA[0,*,ppar])
;th=reform(q.position._DATA[1,*,ppar])
; rad=reform (q.position._DATA[0,ppar,0:tn])
;th=reform(q.position._DATA[1,ppar,0:tn])
rad=reform( q.position._DATA[0,0:tn,ppar])
th=reform ( q.position._DATA[1,0:tn,ppar])
if (  ((th[sz-1] ge 11./20*!DPI) || ( th[sz-1] le 9./20*!DPI ) ) && ( rad[0] le 5 ) ) then begin
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='white', $
	psym=psym, $ 
	symsize=symsize
   endif
   endfor




plotparts_3=0
if ( plotparts_3 eq 1 ) then begin
for i=9000,12000-1,77 do begin
ppar=i
;rad=reform (q.position._DATA[0,ppar,0:tn])
;th=reform(q.position._DATA[1,ppar,0:tn])
rad=reform( q.position._DATA[0,0:tn,ppar])
th=reform ( q.position._DATA[1,0:tn,ppar])
if (  ((th[sz-1] ge 11./20*!DPI) || ( th[sz-1] le 9./20*!DPI ) ) && ( rad[0] le 5 ) ) then begin
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='green', $
	psym=psym, $ 
	symsize=symsize
   endif
   endfor
   endif

nx1=p.nx
nx2=p.ny
rr=rebin(reform(p.x,nx1,1),nx1,nx2)
theta=rebin(reform(p.y,1,nx2),nx1,nx2)

xpos=rr*sin(theta)
ypos=rr*cos(theta)

plotfield=1
if ( plotfield eq 1 ) then begin 
for qq=1.5,4.5,.4 do begin
seed=[qq,!PI*9.9/20.]
myxq=p.x
myyq=p.y
br=transpose(reform(mydat.b(0,*,*)))
bth=transpose(reform(mydat.b(1,*,*)))/sqrt(xpos^2+ypos^2)
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('black')
pl=0
seed=0
endfor
endif



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

end
