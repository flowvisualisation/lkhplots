
alphaave=0
samp=50
nstep=2000L
nbeg=36
nend=44
nstep=2
OPENw, 1, 'alpha.dat'
for nfile=nbeg, nend, nstep  do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
print, nfile

mx=bx*by
ry=vx*vy
vxbar=total(total(vx,2),2)/ny/nz
vybar=total(total(vy,2),2)/ny/nz
vxbar=rebin(reform(vxbar,nx,1,1),nx,ny,nz)
vybar=rebin(reform(vybar,nx,1,1),nx,ny,nz)


;ry=rho*vx1*(vx2-vshear)
ry=(vx-vxbar)*(vy-vybar)

alpha=(ry-mx)
alphamean=mean(alpha)
alphaave=alphaave+alphamean
printf,1,nfile,  alphamean
print, alphamean
endfor
alphaave=alphaave/samp

spawn, 'cd .. && basename ${PWD} && cd  data', dirtag
qtag=strmid(dirtag,3,1)
qq=fix(qtag)
q=1.0+qq[0]/10.
qstr="q="+string(q, format='(F4.1)')

print,q,  alphaave
close, 1
end
