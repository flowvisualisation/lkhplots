pload, 0, /nodata

nfile=10
nbeg=0
;nbeg=max([nlast-5,0])
nend=nlast
for nfile=nbeg,nend,1 do begin
pload, nfile, /silent
print, nfile
fname='stardisk'+string(nfile, format='(I04)')
cgloadct,33
vec=alog10(rho)
;vec=vx1
display, vec, x1=x1,x2=!PI/2-x2,/polar,  $
    xrange=[0,6], $
    yrange=[0,5],$
    title='SDI, t='+string(t(nfile)/2./!DPI, format='(F5.2)'), $
    ims=[800,800], /hbar, charsize=2

if ( nfile > 0) then begin
VECFIELD,vx1,-vx2,x1,!PI/2-x2,/POLAR,/OVERPLOT, spacing=3.5
endif

;vecfield, -bx1, -bx2, x1, !PI/2-x2, /polar, /overplot, color=cgcolor('white')  , thick=2, len=1
;vecfield, vx1, -vx2, x1, !PI/2-x2, /polar, /overplot, color=cgcolor('white')  , thick=2, len=1

x2d=rebin(reform(x1,nx1,1),nx1,nx2)
y2d=rebin(reform(x2,1,nx2),nx1,nx2)
   r  = x2d;
   r2 = r*r;
   r3 = r2*r;
     
     betap=1.25e-2
     kappa=1.
     Bmag = sqrt(2.0*kappa/betap);

bxback= 2.0*Bmag*cos(y2d)/r3;
byback=   Bmag*sin(y2d)/r3;

bx1=bx1+bxback
bx2=bx2+byback

x=x1*cos(x2)
y=x1*sin(x2)

bpres=bx1^2+bx2^2+bx3^2
bet=pres/bpres
;for i=1.1, 9.2,0.3 do begin
;field_line, bx1, bx2,0., x,y,0.,  seed=[i,0.1], rr,zz ;, /quiet

 for qq=0.36,6,0.1 do begin
seed=[qq,!PI*9.9/20.]
myxq=x1
myyq=x2
br=bx1
bth=bx2/sqrt(xpos^2+ypos^2)
pl=0
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('black')
pl=0
seed=0
endfor

;oplot, rr,zz,color=255
;endfor

im=cgsnapshot(filename=fname, /jpeg, /nodialog)

endfor
end
