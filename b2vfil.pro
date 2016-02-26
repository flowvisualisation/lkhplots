
ys=1200
xs=600
cgdisplay, xs=xs, ys=ys

spawn "mkdir -p oldpoy"
spawn "mv poy*h5 oldpoy"
count=0
nbeg=790000
nend=nbeg
nstep=2000
spawn, "uname", listing
if ( listing ne 'Darwin') then begin
nbeg=320000
nend=788000
nstep=2000
endif


nfile=nbeg
grd_ctl, model=nfile, g,c 
ave=dblarr(g.nz)

poy=ave
poyl=ave
poyh=ave
tarr=dblarr(1)
tarr(*)=c.time/2/!DPI
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

nx=g.nx
ny=g.ny
nz=g.nz

filterhp = 1-BUTTERWORTH(nx,ny, cutoff=10, order=11)
filterlp = BUTTERWORTH(nx,ny, cutoff=10, order=11)
filterhp3d=rebin(reform(filterhp,nx,ny,1 ), nx,ny,nz)
filterlp3d=rebin(reform(filterlp,nx,ny,1 ), nx,ny,nz)
ifftx=FFT(b2v,dimension=1, -1)* nx
iffty=FFT(ifftx,dimension=2, -1)*ny
hfil=iffty*filterhp3d
lfil=iffty*filterlp3d

ffty=FFT(lfil,dimension=2 )
b2vlp=real_part(FFT(ffty,dimension=1 ))

ffty=FFT(hfil,dimension=2 )
b2vhp=real_part(FFT(ffty,dimension=1 ))

dat=total(total(b2v, 1),1)
poy=[[poy],[dat]]

hdat=total(total(b2vhp, 1),1)
poyh=[[poyh],[hdat]]


ldat=total(total(b2vlp, 1),1)
poyl=[[poyl],[ldat]]

ave=ave+dat
tarr=[tarr, c.time/2.0/!DPI]

rainbow_colors
count=count+1
    print, count
 if ( (count  mod 10)  eq 0) then begin
 ;if ( (count  mod 1)  eq 0) then begin
pos=cglayout([1,2], oxmargin=[12,12])
trapoy=transpose(poy)
trapoyl=transpose(poyl)
trapoyh=transpose(poyh)
r=cgscalevector(trapoyl, 1,254)

cgimage, r, pos=pos[*,0] , Stretch='Clip', Clip=1




ave=mean(dat,dimension=1)
px=pos[*,0]
imin=min(dat)
imax=max(dat)
cgcontour, r, tarr,g.z , /noerase, /nodata, pos=px, title='Mag. Energy Flux, t='+string(c.time/2.0/!DPI, format='(I5)')+' orbits', $
    xtitle="t [orbits]",$
    ytitle="z/H"
cgcolorbar, range=[imin,imax], /vertical, pos=[px[2]+0.0, px[1],px[2]+0.03, px[3]], /right
px=pos[*,1]
    sig=stddev(dat, dimension=1)
    top= ave+sig
    bot= ave-sig
cgplot, g.z, ave, title="Magnetic Energy Flux , B!U2!Nv!Dz!N", pos=px, /noerase,$
    ytitle="B!U2!Nv!Dz!N",$
    xtitle="z/H", yrange=[min(bot),max(top)]
    zh=g.z
cgcolorfill,[zh,reverse(zh)],[bot,reverse(top)],/data, color='grey'
cgplot, g.z, ave, pos=px, /overplot




fname="poyntingave"+string(nfile, format='(I07)')
fname2=fname

;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endif
endfor

ex_create_hdf5, trapoy, "poyntingfil", "spacetimeb2v"
ex_create_hdf5, trapoyl, "poyntingfil_l", "spacetimeb2v_l"
ex_create_hdf5, trapoyh, "poyntingfil_h", "spacetimeb2v_h"


end
