
for n=0,10 do begin

seed=n
  q=randomu(seed,10)
  theta=q[0]*2*!DPI;
  zarch=q[1]*2-1;
  kx=1.5*(1+0.1*q[2]);
  ky=1.5*(1+0.1*q[3]);
  kz=1.5*(1+0.1*q[4]);

  kk=1.5
  kx=kk*sqrt(1-zarch*zarch)*cos(theta);
  ky=kk*sqrt(1-zarch*zarch)*sin(theta);
  kz=kk*zarch;

  theta=q[5]*2*!DPI;
  zarch=q[6]*2-1;
  ex=sqrt(1-zarch*zarch)*cos(theta);
  ey=sqrt(1-zarch*zarch)*sin(theta);
  ez=zarch;

k2=kx^2+ky^2+kz^2
ke=kx*ex+ky*ey+kz*ez

ke2=ke*ke

scrh=sqrt(k2-ke2)
fkx=( ky*ez-kz*ey)/scrh
fky=(-kx*ez+kz*ex)/scrh
fkz=( kx*ey-ky*ex)/scrh


fk2=fkx^2 + fky^2 +fkz^2

print, kx,ky,kz, k2
print, fkx,fky,fkz, fk2

  endfor
end
