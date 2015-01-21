pro jetplotx2, var=var, field=field, n=nfile, mfield=mfield, current=current


 COMMON PLUTO_GRID
 COMMON PLUTO_VAR
 COMMON PLUTO_RUN


;cgdisplay, xs=450,ys=750
;cgdisplay, xs=550,ys=1200
pload,0, /nodata, /silent
;nfile=nlast
pload,nfile, /silent
fname='jetplot'+string(nfile, format='(I05)')


r=rho
r[0,0]=6.3e-10
xx=x1
yy=x2
polar,r,xx,yy,sample=10
rr=transpose(r)
data=alog10(rr)
myd=cgscalevector(data,1,254)
pos=[.2,.1,.9,.9]


br=bx1
bz=bx2
bth=bx3
vr=vx1
vz=vx2
d=rho
p=prs
 alf2, br,bz,bth,vr,vz,d,p,mf,ma,ms

for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
rhotext='!9r!X'
endif else  begin
set_plot, 'x'
rhotext='!7q!X'
endelse


cgloadct,33
cgimage, myd,pos=pos
sz=size(myd,/dimensions)
xp1=congrid(xpos, sz(0),sz(1))
xp2=congrid(ypos, sz(0),sz(1))
print, 'before cgcontour'
cgcontour, rr, xp1, xp2, pos=pos,  /nodata,/noerase, color='black', $
   title='log!D10!N '+rhotext+','+' t='+string(t(nfile), format='(F4.1)'),$
   xtitle='R',$
   ytitle='Z'
imin=min(data)
imax=max(data)

print, min(rr)

cgcolorbar, range=[imin,imax], pos=[pos[0], pos[1]-0.06, pos[2], pos[1]-0.05 ]


print, 'before ma cgcontour'
	 cgcontour, ma, xpos,ypos, levels=1, color='red', /overplot, c_thick=2.0, label=0
	 cgcontour, mf, xpos,ypos, levels=1, color='yellow', /overplot, c_thick=2.0, label=0


;if ( keyword_set(current) ) then begin
cur=rebin(reform(x1,nx1,1),nx1,nx2) * rebin(reform(sin(x2),1,nx2),nx1,nx2)*bx3
	 cgcontour, cur, xpos,ypos, levels=30,  /overplot,  label=0
;endif else begin
;endelse

if ( keyword_set(mfield) ) then begin
endif else begin
for qq=0,15 do begin
seed=[1.1+qq/4.,!PI*9.9/20.]
myxq=x1
myyq=x2
br=bx1
bth=bx2/sqrt(xpos^2+ypos^2)
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('black')
pl=0
seed=0
endfor
endelse


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse


endfor ; usingps
end
