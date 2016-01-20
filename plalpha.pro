
alphaave=0
samp=50
nstep=2000L
nbeg=2
nend=nlast
nstep=1
for nfile=nbeg, nend, nstep  do begin

plutoread, rho, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
print, nfile

mx=bx*by
ry=rho*vx*vy

alpha=(ry-mx)/rho^1.6666667
alphamean=mean(alpha)
alphaave=alphaave+alphamean
print, alphamean
endfor
alphaave=alphaave/samp

spawn, 'basename ${PWD}', dirtag
qtag=strmid(dirtag,1,2)
qq=fix(qtag)
q=qq[0]/10.
qstr="q="+string(q, format='(F4.1)')

print,q,  alphaave
OPENw, 1, 'alpha.dat'
printf,1,q,  alphaave
close, 1
end
