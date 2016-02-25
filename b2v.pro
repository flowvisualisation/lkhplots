
ys=1200
xs=600
cgdisplay, xs=xs, ys=ys

count=0
nbeg=790000
nend=nbeg
nstep=2000
spawn, "uname", listing
if ( listing ne 'Darwin') then begin
nbeg=100000
nend=790000
nstep=2000
endif


nfile=nbeg
grd_ctl, model=nfile, g,c 
ave=dblarr(g.nz)

poy=ave
tarr=dblarr(1)
tarr(*)=c.time
ave(*)=0.0

for nfile=nbeg, nend, nstep do begin
r=h5_read(nfile, /v,/b)
grd_ctl, model=nfile, g,c 

bx=transpose( reform (r.b[0,*,*,*])  )
by=transpose( reform (r.b[1,*,*,*])  )
bz=transpose( reform (r.b[2,*,*,*])  )
vz=transpose( reform (r.v[2,*,*,*])  )


b2=bx^2+by^2+bz^2
b2v=b2*vz
dat=total(total(b2v, 1),1)
ave=ave+dat
poy=[[poy],[dat]]
tarr=[tarr, c.time/2.0/!DPI]
;cgloadct,33

rainbow_colors
count=count+1
    print, count
 if ( (count  mod 10)  eq 0) then begin
pos=cglayout([1,2])
trapoy=transpose(poy)
r=cgscalevector(trapoy, 1,254)
cgimage, trapoy, pos=pos[*,0]
sz=size(trapoy, /dimensions)
cgcontour, trapoy, tarr,g.z , /noerase, /nodata, pos=pos[*,0], title='t='+string(c.time/2.0/!DPI)
cgplot, g.z, ave, title="Poynting Flux , B!U2!Nv!Dz!N", pos=pos[*,1], /noerase

fname="poyntingave"+string(nfile, format='(I07)')
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endif
endfor

ex_create_hdf5, trapoy, fname, "spacetimeb2v"


end
