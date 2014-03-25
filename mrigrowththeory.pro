

omega=1e-3

va=1./2./!DPI*sqrt(15./16.)*omega

lx=sqrt(16./15.) *2*!DPI* va/omega

print, va
print, 1./lx
print, lx
nx=100
time=findgen(nx)/nx*10.

nx=100

time=findgen(nx)/nx*10.
nrads=10
for i=1,nrads do begin

r=i
omega=1/sqrt(r)
mrigrowth=0.75*omega
vxgr= exp(mrigrowth*time)
cgplot, time, vxgr, /ylog, /overplot
endfor

end
