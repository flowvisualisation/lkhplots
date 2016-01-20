
pload,0
cgdisplay, xs=800,ys=800
nbeg=0
nend=0
nend=nlast
for i=nbeg,nend do begin

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

bx=bx1
by=bx2
bx=bx1+bxback
by=bx2+byback

b2=bx^2+by^2+bx3^2
betap=2.0*prs/b2
sl=nx2-1
sl=nx2/2
arg=betap(*,sl)
pos=cglayout([1,2])
cgplot, x1, vx3(*,sl) , yrange=[0,4.5], linestyle=2, pos=pos[*,0]
cgplot, x1, arg, /overplot
items=['!7b!X','!7X!X']
linestyle=[0,2]
al_legend, items, linestyle=linestyle, charsize=2, /right
cgplot, x1, arg ,  linestyle=0, pos=pos[*,1], /noerase, yrange=[0,10*min(arg)]
endfor

end
