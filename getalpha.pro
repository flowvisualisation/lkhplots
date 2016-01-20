
getlast, nlast
alphaave=0
samp=50
nstep=2000L
for nfile=nlast-samp*nstep, nlast, nstep  do begin
d=h5_read(nfile, /rho, /B, /v, /remap)
grd_ctl,model=nfile, mydat
print, nfile
bx=transpose(reform(d.b(0,*,*,*)))
by=transpose(reform(d.b(1,*,*,*)))
ux=transpose(reform(d.v(0,*,*,*)))
uy=transpose(reform(d.v(1,*,*,*)))
rho=transpose(reform(d.rho(*,*,*)))

mx=bx*by
ry=rho*ux*uy
p=rho

alpha=(ry-mx)/p
alphamean=mean(alpha)
alphaave=alphaave+alphamean
print, alphamean
endfor
alphaave=alphaave/samp

spawn, 'basename $PWD', dirtag
qtag=strmid(dirtag,1,2)
qq=fix(qtag)
q=qq[0]/10.
qstr="q="+string(q, format='(F4.1)')

print,q,  alphaave
OPENw, 1, 'alpha.dat'
printf,1,q,  alphaave
close, 1
end
