
pro njet, var, nfile
	
cgdisplay, xs=600,ys=1100
for n=nfile,2000000L,1000 do begin   

;cgerase


 cgloadct,33 
print, n
if ( file_test('usr'+String(n,format='(I06)')+'.h5' ) ne 1) then begin
print, 'File does not exist ... exiting'
break
endif


 r=h5_read(n,/p,/v,/B,/rho) 

 grd_ctl,model=n,p  

switch var of
'rho':begin	
dat=alog10(r.rho)
dat(0,0)=-8.3
break;
end
'p':begin	
dat=alog10(r.p)
break;
end
'v1':begin	
dat=r.v(0,*,*)
break;
end
'v2':begin	
dat=r.v(1,*,*)
break;
end
'v3':begin	
dat=r.v(2,*,*)
break;
end
'bsq':begin	
dat= alog10(r.b(0, *,*)^2 +r.b(1, *,*)^2+  r.b(2, *,*)^2)
break;
end
'b1':begin	
dat=r.b(0,*,*)
break;
end
'b2':begin	
dat=r.b(1,*,*)
break;
end
'b3':begin	
dat=r.b(2,*,*)
break;
end
end

dat2=transpose(dat)
xx=p.x
yy=!PI/2-p.y
polar, dat2, xx,yy, sample=5

 ;display,/polar,x1=p.x,x2=!PI/2-p.y,/hbar,ims=[800,1200], transpose(dat)
pos=[0.1,0.1,0.9,.9]
scl=cgscalevector(dat2,1,255)
cgimage, scl, pos=pos;, /noerase
cgcontour, dat2,xx,yy, /noerase,/nodata, pos=pos, title=var+', t='+string(n)
imin=min(dat2)
imax=max(dat2)
cgcolorbar, range=[imin,imax], pos=[pos[0],pos[1]-0.04,pos[2],pos[1]-0.03 ]

nx1=p.nx
nx2=p.ny
rr=rebin(reform(p.x,nx1,1),nx1,nx2)
theta=rebin(reform(p.y,1,nx2),nx1,nx2)

xpos=rr*sin(theta)
ypos=rr*cos(theta)

for qq=0,15 do begin
seed=[1.1+qq/2,!PI*9.9/20.]
myxq=p.x
myyq=p.y
br=transpose(reform(r.b(0,*,*)))
bth=transpose(reform(r.b(1,*,*)))/sqrt(xpos^2+ypos^2)
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('white')
pl=0
seed=0
endfor


endfor
end
