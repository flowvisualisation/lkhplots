
nx=400
ny=400
bmag=1
x=findgen(nx)/nx*10-5
y=findgen(ny)/ny*10-5


r=rebin(reform(x,nx,1),nx,ny)
z=rebin(reform(y,1,ny),nx,ny)


rc=r
rs=sqrt(r^2+z^2)

r2=rs^2
r3=rs^3

  ; R  = x1; z = x2; r = sqrt(x1*x1 + x2*x2);
  ; r2 = r*r;
  ; r3 = r2*r;
  ; *Bx1 = 3.0*Bmag*z*R/(r2*r3);
   ;*Bx2 =    -Bmag*(R*R - 3.0*z*z)/(r2*r3);
br=  3*bmag*z*rc/(r2*r3)
bz=   -bmag*(rc*rc -3*z*z)/(r2*r3)

for i=0,nx-1 do begin
for j=0,ny-1 do begin
if (rs[i,j] le 0.35) then begin
;print, i,j, rs[i,j]
br[i,j]=0
bz[i,j]=0
endif
endfor
endfor

vec=br
data=cgscalevector(vec,1,254)
display, data, x1=x,x2=y, ims=[800,800]

pl=0
 for qq=1.,2.,0.1 do begin
seed=[qq,0.2]
myxq=x &  myyq=y & bqx=br & bqy=bz
field_line, bqx,bqy,0,myxq,myyq,0,seed=seed ,pl, method="RK2"
oplot, pl[0,*], pl[1,*], color=cgcolor('black')
pl=0
seed=0
endfor




end



