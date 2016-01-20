
fname='mbv'
r=h5_parse("profile.h5", /read_data)

rho=r.rho._DATA
sz=size(rho, /dimensions)

bx=r.bx._DATA
by=r.by._DATA
bz=r.bz._DATA
b2=bx^2+by^2+bz^2
b2=b2/4.d/1e-7/!DPI
bperp2=bx^2+by^2
bperp2=bperp2/4.d/1e-7/!DPI

emag=r.emag._DATA
pres=r.p._DATA
z=r.z._DATA
drho=r.drho._DATA*1.d
gradrho=r.drho._DATA*1.d
for i=0,sz(0)-1 do begin
gradrho(i,*)=deriv(z,rho(i,*))
endfor

;; sanity check
pbeta=pres*2/b2
print, 'Sanity check, beta=1600, beta=',pbeta(0,0)

gam=5.d/3.d
cs2=gam*pres/rho

drho=r.drho._DATA*1.d
drho=r.drho._DATA*1.d
ca2=b2/rho
caperp2=bperp2/rho


grav= -1.d*z
;grav[246:266]=0

grav=rebin(reform(grav,1,sz(1)),sz(0), sz(1))
geff=grav-caperp2

mbv= -grav /4/!DPI/1e-7 *( gradrho/rho + grav/(ca2+cs2)  )
;mbv= -geff /4/!DPI/1e-7 *( gradrho/rho + geff/(caperp2+cs2)  )

yb=70
ye=210
cgloadct,33
time=r.time._DATA
ntime=time;/2/!DPI
cgdisplay, xs=800,ys=600
vaisala='V'+string(228b)+'is'+string(228b)+'l'+string(228b)
pos=[.1,.1,.9,.9]
cgcontour, by, ntime, z, pos=pos , /fill, nlev=32, xrange=[0,140], xtitle='Time (orbits)', ytitle='Altitude (Z/H)', title='Azimuthal Field (B!Dy!N) and Magnetic Brunt '+vaisala+' Frequency'
cgcontour, mbv, ntime, z, pos=[.1,.1,.9,.9],  /noerase, levels=0, xrange=[0,140]
items=['N!U2!N']
al_legend, items, linestyle=0, /right
im=cgsnapshot(filename=fname, /jpeg, /nodialog)

end
