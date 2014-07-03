
nx=100
ny=100
nz=100

x=dindgen(nx)*1.6+.4
phi=dindgen(ny)/ny*2*!DPI
z=dindgen(nz)


x1=rebin(reform(x,nx,1,1),nx,ny,nz)
x2=rebin(reform(phi,1,ny,1),nx,ny,nz)
x3=rebin(reform(z,1,1,nz),nx,ny,nz)

x1=rebin(reform(x,nx,1),nx,nz)
;x2=rebin(reform(phi,1,1),nx,nz)
x3=rebin(reform(z,1,nz),nx,nz)
g_gamma=5./3.

  eps=0.1;

  gmm  = g_gamma;
 rad = sqrt(x1*x1+x3*x3);
   subk = 1. - eps*eps*gmm/(gmm-1.);

    d0d=1.0;
    p0d=eps*eps;
    scrh = (1./rad-subk/x1)*(gmm-1.)/gmm/p0d;
  ddisk = d0d*(scrh^(3./2.));
  pdisk = p0d*(scrh^(5./2.));
  vdisk = sqrt(subk/x1);
  d0a=1e-4;
  p0a=d0a^((gmm-1)/gmm);
  datmo=    d0a*(rad^(-3./2.));
  patmo = p0a*(rad^(5./2.));

end

