
;readcol,'averages.dat',t,dt,b2,bxby,rhouxduy,alpha,bz2,by2,bx2
readcol,'averages.dat',step,t,b2,bxy,rhouxuy

omega=1
tnorm=t*omega/2/!DPI

!y.range=0
spawn, 'basename $PWD', tag
qtag=strmid(tag,1,2)
print, qtag
qq=fix(qtag)/10.
print, qq
q=qq[0]

det=string(nx1,format='(I2)')+':'+string(nx2,format='(I3)')+':'+string(nx3,format='(I3)')

pload,0
cgplot, tnorm, b2, /ylog, color='red', title='q=' + string( q, format='(F3.1)') +' , '+ det
cgplot, tnorm, 1.2e-2*b2(0)*exp(q*tnorm), /overplot, linestyle=2
cgplot, tnorm, abs(bxy), /overplot, color='blue'
cgplot, tnorm, abs(rhouxuy), /overplot


items=['B!U2!N','B!DX!NB!DY!N','!7q!Xv!Dx!Nv!Dy!N']
lines=[0,0,0]
colors=['red','blue','black']
al_legend, items, lines=lines, color=colors, charsize=1.3
end
