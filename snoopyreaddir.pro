pro snoopyreaddir, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time, dir

fname= dir+'/v'+string(nfile,format='(I04)')+'.vtk'
;print,fname
openr, lun,fname, /get_lun
header1=strarr(1)
readf, lun, header1
header2=strarr(1)
;readf, lun, header2
junk=""
junk2=""
time=1.0d
readf, lun, junk, time, junk2,format='(A2,x,E21.15,x,A10)'
;print, time
;help, time
header3=strarr(1)
readf, lun, header3
header4=strarr(1)
readf, lun, header4
;print,header
junk=""
nx=0
ny=0
nz=0
readf, lun, junk, nx,ny,nz, format='(A10,x,I0,x,I0,x,I0)'
;print, junk, nx,ny,nz

header2=strarr(5)
readf, lun, header2
;print, header2

vx=fltarr(nx,ny,nz)
vy=vx
vz=vx
bx=vx
by=vx
bz=vx
readu, lun, vx
vx=swap_endian(vx)
;print, vx(0,0,0)
fieldhead=strarr(1)
field=""
f3=""
readf, lun,fieldhead
;print, fieldhead
;readf, lun,field, f3, num, format='(A5,x,A9,x,I0)' 
;print,field," ",f3, num
;print, "reading vy"
varname=""
scrh=0
nxnynz=0L
fltvar=""
readf, lun, varname, scrh, nxnynz, fltvar, format='(A2,x,I0,x,I0,x,A5)'
;print, varname, " " ,scrh," ",nxnynz," ", fltvar
readu, lun, vy
vy=swap_endian(vy)
readf, lun, varname, scrh, nxnynz, fltvar, format='(A2,x,I0,x,I0,x,A5)'
;print, varname, " " ,scrh," ",nxnynz," ", fltvar
readu, lun, vz
vz=swap_endian(vz)
readf, lun, varname, scrh, nxnynz, fltvar, format='(A2,x,I0,x,I0,x,A5)'
;print, varname, " " ,scrh," ",nxnynz," ", fltvar
readu, lun, bx
bx=swap_endian(bx)
readf, lun, varname, scrh, nxnynz, fltvar, format='(A2,x,I0,x,I0,x,A5)'
;print, varname, " " ,scrh," ",nxnynz," ", fltvar
readu, lun, by
by=swap_endian(by)
readf, lun, varname, scrh, nxnynz, fltvar, format='(A2,x,I0,x,I0,x,A5)'
;print, varname, " " ,scrh," ",nxnynz," ", fltvar
readu, lun, bz
bz=swap_endian(bz)




close, lun
free_lun, lun


Lx=2.d0
Ly=2.d0
Lz=1.d0
xx=dindgen(nx)/(nx)*Lx-Lx/2.d0+Lx/nx/2.d0
yy=dindgen(ny)/(ny)*Ly-Ly/2.d0+Ly/ny/2.d0
zz=dindgen(nz)/(nz)*Lz-Lz/2.d0+Lz/nz/2.d0
xx3d=rebin(reform(xx,nx,  1,  1),nx,ny,nz) 
yy3d=rebin(reform(yy,  1,ny,  1),nx,ny,nz) 
zz3d=rebin(reform(zz,  1,  1,nz),nx,ny,nz) 

end
