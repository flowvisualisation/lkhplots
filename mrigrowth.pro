

readcol, "averages.dat", t,dt, b2, bxby, rhou, alpha, bz2,by2,bx2

omega=1e-3
tnorm=t*omega
;window, xs=900, ys=1100
!p.multi=[0]
!p.charsize=2
growth=.75
InitialAmplitude=1e-4
InitialTransient=10
InitialTransient=11
bnorm=sqrt(b2)

linearfit =InitialAmplitude*exp(growth*tnorm)

i1=105
i2=115
qxq=where( bnorm gt 1e-3) 
qxq2=where( linearfit gt 1e-3) 

tdrag=tnorm[qxq(0)]- tnorm[qxq2(0)]
print,'tdrag', tdrag

i2=qxq(0)
i1=i2-10
print,  (alog(linearfit[i2])-alog(linearfit[i1]))/(tnorm[i2]-tnorm[i1])
growth= (alog(bnorm[i2])-alog(bnorm[i1]))/(tnorm[i2]-tnorm[i1])
print, 'growth', growth
;print, bnorm[i2], linearfit[i2]

qq1=[bnorm[i1], bnorm[i2]]
qt1=[tnorm[i1], tnorm[i2]]

t2=tnorm(*)+tdrag
pload,0, /silent
cs=1.e-3
pr0=rho*(cs)^2
betap=2*pr0/max(bx3^2)
tag=' , growth='+string(growth, format='(F6.4)') +' , bmax='+string(max(bx3), format='(F8.6)')
print, tag
cgplot, tnorm, bnorm,  $
	title="b2"+tag, $
	xtitle="Time, (orbits)", xrange=[0,14], /ylog, xstyle=1
cgplot, t2 , linearfit , /overplot
cgplot, qt1 , qq1 , /overplot, psym=1
;cgplot, tnorm, abs(alpha), /ylog, title="alpha",xtitle="Time, (orbits)"
;cgplot, tnorm, abs(bxby), /ylog, title="bxby",xtitle="Time, (orbits)"
;cgplot, tnorm, abs(rhou),/ylog, title="rho ux",xtitle="Time, (orbits)"
!p.multi=0
print, max(bx3)
va=bx3/sqrt(rho)
print, 'max va', max(va)
print, 'omega', omega
print, 'fastest Lz', 2*!PI*sqrt(16./15.)* max(va)/omega
print, 'fastest Lz/2', 2*!PI*sqrt(16./15.)* max(va)/omega/2.
lz=(x3[nx3-1] - x3[0])+dx3[0]
print, 'lz' ,lz 
print, 'lz/2' , lz/2
print, 'dx1', dx1[0],'dx2', dx2[0],'dx3', dx3[0]


bpref=omega *sqrt(15./16.)/2/!PI*lz *sqrt(max(rho))
print, 'b',bpref 
print, 'beta', max(pr0)*2/bpref^2
bpref=omega *sqrt(15./16.)/2/!PI*sqrt(max(rho))
print, 'bunity',bpref 
print, 'betaunity', max(pr0)*2/bpref^2
;print, omega
end
