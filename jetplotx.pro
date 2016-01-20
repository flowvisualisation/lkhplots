
cgdisplay, xs=450,ys=750
cgdisplay, xs=550,ys=550
pload,0, /nodata
;nfile=nlast
pload,nfile
fname='jetplot'+string(nfile, format='(I05)')
r=rho
xx=x1
yy=x2
polar,r,xx,yy,sample=10
rr=transpose(r)
d=alog10(rr)
myd=cgscalevector(d,1,254)
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
   title='log!D10!N '+rhotext+','+' t='+string(t(nfile)),$
   xtitle='R',$
   ytitle='Z'



print, 'before ma cgcontour'
	 cgcontour, ma, xpos,ypos, levels=1, color='red', /overplot, c_thick=2.0, label=0
	 cgcontour, mf, xpos,ypos, levels=1, color='yellow', /overplot, c_thick=2.0, label=0



for qq=0,15 do begin
seed=[1.1+qq/4.,!PI*9.9/20.]
myxq=x1
myyq=x2
br=bx1
bth=bx2/sqrt(xpos^2+ypos^2)
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('white')
pl=0
seed=0
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


endfor ; usingps
end
