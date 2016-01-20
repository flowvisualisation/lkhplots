nbeg=300000L
nend=322000L
nstep=2000L
for nfile=nbeg, nend, nstep do begin
d=h5_read(nfile,/rho,  /B, /remap)
grd_ctl, model=nfile, g,c

b2=reform(d.b(0,*,*,*)^2 +  d.b(1,*,*,*)^2 +d.b(2,*,*,*)^2  )

rho=d.rho

cgplot,g.z, total(total(b2,2),2), xtitle='z', ytitle='B!U2!N', pos=[.2,.2,.9,.9], title='t='+string(c.time)
cgplot, g.z, total(total(rho^1.67,2),2), /overplot

endfor
end
