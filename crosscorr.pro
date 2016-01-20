cgdisplay, xs=800,ys=1100

if ( firstcall eq !NULL ) then begin
dat=h5_read(712000, /b,/v,/rho,/p, /remap) 
grd_ctl, model=712000, g,c
nx=g.nx
ny=g.ny
nz=g.nz
firstcall=1

bx=transpose(reform(dat.b(0,*,*,*)))
by=transpose(reform(dat.b(1,*,*,*)))
bz=transpose(reform(dat.b(2,*,*,*)))
vx=transpose(reform(dat.v(0,*,*,*)))
vy=transpose(reform(dat.v(1,*,*,*)))
vz=transpose(reform(dat.v(2,*,*,*)))
endif


print, 'Cross-correlation of vz and by'

v2=vx^2+ vy^2+ vz^2
b2=bx^2+ by^2+ bz^2

vzs=reform(v2(*,*,256))
by2=reform(b2(*,*,256))
fvz=fft(vzs, /center)
fby=fft(by2, /center)
cc1= conj(fvz) * fby

vzs=reform(v2(*,*,448))
by2=reform(b2(*,*,448))
fvz=fft(vzs, /center)
fby=fft(by2, /center)
cc2= conj(fvz) * fby

datptr=ptrarr(2)
datptr[0]=ptr_new(cc1)
datptr[1]=ptr_new(cc2)


titstr=strarr(2)
titstr[0]="FFT(vz)*FFT(by) z=0"
titstr[1]="FFT(vz)*FFT(by) z=3H"

pos=cglayout([1,2])
cgloadct,33
;cgcontour, alog10( abs(cc1) ), pos=pos[*,0], /fill, nlev=16
for i=0,1 do begin
dat=*datptr[i]
cgcontour, alog10( abs(dat) ), pos=pos[*,i], /fill, nlev=16, /noerase, title=titstr[i]
endfor


;; fft by

end
