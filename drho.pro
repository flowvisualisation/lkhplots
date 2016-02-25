

nbeg=790000
nend=nbeg
nstep=2000


spawn, "uname", listing
if ( listing ne 'Darwin') then begin
nbeg=100000
nend=790000
nstep=2000
endif


for nfile=nbeg, nend, nstep do begin
r=h5_read(nfile,  /rho)
grd_ctl, model=model, g,c 

rho=transpose( reform (r.rho[*,*,*])  )

nx=g.nx
ny=g.ny
nz=g.nz
dat=reform(rho[nx/2,*,*])
meanrho=total(dat,1)/(1.0d*ny)
meanrho2=rebin(reform(meanrho,1,nz),ny, nz)
drho=dat-meanrho2


drho[0,0]=max(abs(drho))
drho[0,1]=-max(abs(drho))
cgloadct,33
print, max(drho), min(drho)
display, alog10(abs(drho))*signum(drho), /vbar, x1=g.y, x2=g.z
fname="drho"+string(nfile, format='(I07)')
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endfor
end
