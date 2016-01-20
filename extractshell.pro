
xs=1600
ys=xs/2
cgdisplay, xs=xs, ys=ys
;function extractshell, r, x,y,z, mydat, nazi, nelev

nfile=712000L
nfile=000L
dat=h5_read(nfile,/b,/rho,  /remap) 
grd_ctl, model=nfile, g,c



r=64
nx=g.nx
ny=g.ny
nz=g.nz
nazi=210
nelev=180
x=g.x
y=g.y
z=g.z
bx= reform (transpose(dat.b(0,*,*,*)))
by= reform (transpose(dat.b(1,*,*,*)))
bz= reform (transpose(dat.b(2,*,*,*)))
rho= reform (transpose(dat.rho(*,*,*)))
b2=bx^2+by^2+bz^2

x3d=rebin(reform(x,nx,1,1),nx,ny,nz)
y3d=rebin(reform(y,1,ny,1),nx,ny,nz)
z3d=rebin(reform(z,1,1,nz),nx,ny,nz)


mydat= z3d
mydat= alog10(rho)
mydat= (rho)
;mydat= by
;mydat= alog10(b2)

;; for a given r
;; extract eleve data on a azii, eleveta grid
;; input a cube of data and x,y,z coords
;; and a given r

arr=fltarr(nelev,nazi)

; eleveta is elevation
elev=findgen(nelev)/(1.*nelev)*180-90
; azii is  azimuelev
azi=findgen(nazi)/(1.*nazi)*360

for i=0,nelev-1 do begin
for j=0,nazi-1 do begin

azi2=azi[j]*!DTOR
elev2=elev[i]*!DTOR

xco=r*cos(elev2)*cos(azi2)+nx/2
yco=r*cos(elev2)*sin(azi2)+ny/2
zco=r*sin(elev2)+nz/2


arr[i,j]=interpolate ( mydat, xco, yco, zco)

endfor
endfor

;return, arr
;cgloadct,33 & display, arr, /hbar, ims=[800,800]
; eleveta is elevation
;elev=findgen(nelev)/(1.*nelev)*180-90
; azii is  azimuelev
; lat is  elev
lat2=rebin(reform(elev, nelev, 1), nelev, nazi)
; lon is azi
lon2=rebin(reform(azi, 1, nazi), nelev, nazi)
     cgMAP_SET, /MOLLWEIDE, 0, 180, /ISOTROPIC, $
   /HORIZON, /GRID,  $
;   /CONTINENTS, $
   TITLE='Mollweide Projection of Spherical Shell'
   cgloadct,33
;   arr=transpose(arr)
cgCONTOUR, arr, lon2, lat2, NLEVELS=32, $
/fill,$
background='white', $
   /OVERPLOT
end
