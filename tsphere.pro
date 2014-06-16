


;pro radialave 

nx=200
ny=nx

vec=dist(nx,ny)

radave=fltarr(nx/2)
radave(*)=0.0

k1=findgen(nx)-nx/2
k2=findgen(ny)-ny/2

k11=rebin(reform(k1,nx,1),nx,ny)
k22=rebin(reform(k2,1,ny),nx,ny)
kr=sqrt(k11^2+k22^2)

ang=!DPI/4.
kpar=k11*cos(ang)+k22*sin(ang)
kperp= -k11*sin(ang)+k22*cos(ang)
kpar=k11
kperp=k22

vec=140-sqrt(k11^2+k22^2)
vec=1-((kpar/99.)^2+(kperp/99.)^2)+1e-6
;vec(*,*)=140
;vec=abs(k11+1e-6)^(-5./3.)+abs(k22+1e-6)^(-10./3.)+1e-6

for i=0,nx-1 do begin
for j=0,ny-1 do begin


disp=sqrt(k1(i)^1+k2(j)^2)
disp=kr(i,j)

if ( disp lt nx/2-1 ) then begin 
int_disp=round(disp)
int_disp=fix(disp)
print, int_disp, i,j, disp, int_disp, vec(i,j)

radave(int_disp)= radave(int_disp)+vec(i,j)/2/!DPI/kr(i,j)

endif

endfor
endfor



!p.position=0
!p.multi=[0,1,3]
;cgplot, vec(nx/2,*)
;cgplot, smooth(radave,3), linestyle=2
;cgplot, vec(nx/2,ny/2:ny-1), /overplot
;cgplot, vec(nx/2:nx-1, ny/2), /overplot
;cgloadct,33
;cgimage, vec
!p.multi=0


vec=1-((k22/13.)^2+(k11/23.)^2)
nxs=200
nps=200
rad=findgen(nxs)
phi=findgen(nps)/nps*2*!DPI
resamp=findgen(nxs,nps)

;svec=shift(vec, nx/2,ny/2)

for i=0,nxs-1 do begin
for j=0,nps-1 do begin

m1=rad[i]*cos(phi[j])+100
m2=rad[i]*sin(phi[j])+100
print, m1,m2
resamp(i,j) =interpolate( vec, m1, m2 )
endfor
endfor



pos = cglayout([1,2] , OXMargin=[4,12], OYMargin=[5,6], XGap=9, YGap=6)
cgloadct,33
cgimage, vec, pos=pos(*,0)
p=pos(*,0)
imin=min(vec)
imax=max(vec)
cgcolorbar, range=[imin, imax], pos=[p[0], p[1]-0.06, p[2], p[1]-0.05]
cgimage, resamp, pos=pos(*,1), /noerase
p=pos(*,1)
imin=min(resamp)
imax=max(resamp)
cgcolorbar, range=[imin, imax], pos=[p[0], p[1]-0.06, p[2], p[1]-0.05]



end
