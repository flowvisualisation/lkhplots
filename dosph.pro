
pload,nlast
cgloadct,11
display,  /polar, x1=x1,x2=!PI/2-x2, ims=[550,1100], /hbar, alog10(rho), $
	title="rho, t="+string(t(nlast))

br=bx1
bz=bx2
bth=bx3
vr=vx1
vz=vx2
d=rho
p=prs
 alf2, br,bz,bth,vr,vz,d,p,mf,ma,ms


	 cgcontour, ma, xpos,ypos, levels=1, color='red', /overplot, c_thick=2.0, label=0
	 cgcontour, mf, xpos,ypos, levels=1, color='yellow', /overplot, c_thick=2.0, label=0


for qq=0,15 do begin
seed=[1.6+qq/3.,!PI*9.9/20.]
myxq=x1
myyq=x2
br=bx1
bth=bx2/sqrt(xpos^2+ypos^2)
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
rr=pl[0,*]
zz=pl[1,*]
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('white')
pl=0
rr=0
zz=0
seed=0
endfor


for qq=0,4 do begin
seed=[4.,!PI/10*qq]
myxq=x1
myyq=x2
br=bx1
bth=bx2/sqrt(xpos^2+ypos^2)
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
rr=pl[0,*]
zz=pl[1,*]
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('white')
pl=0
rr=0
zz=0
seed=0
endfor



end
