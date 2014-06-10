
cgdisplay, xs=1200,ys=1200


nfile=2
nstart=1070
nend=1140
nstart=10
nend=50
;nstart=1
;nend=7
cgloadct,33
for nfile=nstart,nend,2 do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time


vec=vz
cfft1=fft(vec,dimension=2)
jimag=complex(0,1)
;cfft1shift=cfft1*exp ( -jimag * ky3d * xx3d *2 *!PI *qomegat_Ly ) 
cfft2=fft(cfft1, dimension=1)
a=fft(cfft2, dimension=3)
a=fft(vec)

a=abs(a)
;a=a^2
a=alog10(a+1e-15)
slice=a(*,*,0)
slice=shift(slice, nx/2,ny/2)
slice=slice[nx/3:2*nx/3, ny/3:2*ny/3 ]

xslice=reform(a(0,*,*))
xslice=shift(xslice,ny/2,nz/2)
yslice=reform(a(*,0,*))
yslice=shift(yslice,nx/2,nz/2)

sz=size(slice, /dimensions)
xs=sz(0)
ys=sz(1)
xcut=slice(xs/2:xs-1,ys/2)
ycut=slice(xs/2,ys/2:ys-1)

cut45=findgen(xs/2)
cut135=findgen(xs/2)

for i=0,xs/2-1 do begin

cut45[i]=slice[xs/2+i,ys/2+i]
cut135[i]=slice[xs/2+i,ys/2-i]

endfor


   k1=findgen(xs)-xs/2
    k2=findgen(ys)-ys/2
    k11=rebin(reform(k1,xs,1),xs,ys)
    k22=rebin(reform(k2,1,ys),xs,ys)
    kr=sqrt(k11^2+k22^2)
    radave=fltarr(xs/2)
    radave(*)=0.0

    for i=0, xs-1 do begin
    for j=0, ys-1 do begin
    disp=kr(i,j) 
    if ( disp lt xs/2-1 ) then begin 
int_disp=round(disp)
int_disp=fix(disp)
;print, int_disp, i,j, disp, int_disp, vec(i,j)

radave(int_disp)= radave(int_disp)+slice(i,j)/2/!DPI/kr(i,j)

    endif
    endfor
    endfor



fname="myfft"+string(nfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse

x1=findgen(nx)-nx/2
x2=findgen(ny)-ny/2

imin=min(slice)
imax=max(slice)
d=cgscalevector(slice,1,254)
  pos = cglayout([2,2] , OXMargin=[4,7], OYMargin=[5,5], XGap=5, YGap=7)
 
 p1=pos(*,0)
cgimage, d, pos=p1
print, max(d), min(d)
cgcontour,d ,k1,k2, /nodata, /noerase, pos=p1, title=string(time)
cgcolorbar, range=[imin,imax], pos=[p1[0], p1[1]-0.04, p1[2], p1[1]-0.03]


d=cgscalevector(xslice,1,254)
cgimage, d, pos=pos(*,1), /noerase
cgcontour,d,  /nodata, /noerase, pos=pos(*,1), title=string(time)
d=cgscalevector(yslice,1,254)
cgimage, d, pos=pos(*,2), /noerase


cgplot, cut45 , pos=pos(*,3), /noerase, xstyle=1, /xlog, xrange=[1,40], color='blue'
cgplot, cut135 , /noerase, /overplot, color='red'
cgplot, radave , /noerase, /overplot

if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse


endfor




endfor
end
