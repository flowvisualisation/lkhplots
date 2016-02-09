
lonint=1L
dumpver=lonint
nx=lonint
ny=lonint
nz=lonint
incf=lonint
nul=lonint
num=17
openr,lun, 'dump'+string(num, format='(I04)')+'.dmp' , /get_lun;, /swap_Endian
readu, lun, dumpver
;readu, lun, nul
readu, lun, nx
;readu, lun, nul
readu, lun, ny
;readu, lun, nul
readu, lun, nz
;readu, lun, nul
readu, lun, incf
;readu, lun, nul
print, dumpver, nx, ny,nz , incf

vx=dcomplexarr(nz/2+1,ny,nx)
vy=vx
vz=vx
bx=vx
by=vx
bz=vx

readu, lun, vx
print, vx[10,0,0]
;readu, lun, nul
readu, lun, vy
print, vy[10,0,0]
;readu, lun, nul
readu, lun, vz
print, vz[10,0,0]
;readu, lun, nul

readu, lun, bx
print, bx[10,0,0]
;readu, lun, nul
readu, lun, by
print, by[10,0,0]
;readu, lun, nul
readu, lun, bz
print, bz[10,0,0]
;readu, lun, nul

t=0.0d
nof=lonint
lot=t
lof=t
lod=t
mark=0
readu, lun, t
;readu, lun, nul
readu, lun, nof
;readu, lun, nul
;readu, lun, nul
readu, lun, lot
readu, lun, lof
;readu, lun, nul
readu, lun, lod
;readu, lun, nul
readu, lun, mark
;readu, lun, nul

print, t,nof,lot, lof, lod, mark
free_lun , lun

;display, alog10(abs(bx(0,*,*)))
cgloadct,33
display, /hbar, ims=[800,800], alog10(abs(fft( vy(0,*,*) , /inverse)))
end

