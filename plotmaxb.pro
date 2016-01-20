
nbeg=0
nend=490
nstep=50

bxm=0
bym=bxm
bzm=bxm
vxm=bxm
vym=bxm
vzm=bxm
time=bxm

for nfile=nbeg,nend, nstep do begin

r=h5_read( nfile, /b,/v, /rho  ) 
grd_ctl, model=nfile, g,c

bx=max(r.b[0,*,*,*])
by=max(r.b[1,*,*,*])
bz=max(r.b[2,*,*,*])
vx=max(r.v[0,*,*,*])
vy=max(r.v[1,*,*,*])
vz=max(r.v[2,*,*,*])

bxm=[bxm, bx]
bym=[bym, by]
bzm=[bzm, bz]
vxm=[vxm, vx]
vym=[vym, vy]
vzm=[vzm, vz]
time=[time, c.time]

tn=time/2./!DPI

endfor

ymax= max ( [bxm, bym, bzm, vxm, vym, vzm])
cl=[ 'green' ,'red' ,'blue' ,'pink' ,'brown' ,'purple']
cgplot, tn, bym, color=cl[0], yrange=[1e-5*ymax, ymax], /ylog
cgplot, tn, bxm, /overplot, color=cl[1]
cgplot, tn, bzm, /overplot, color=cl[2]
cgplot, tn, vxm, /overplot, color=cl[3]
cgplot, tn, vym, /overplot, color=cl[4]
cgplot, tn, vzm, /overplot, color=cl[5]

end
