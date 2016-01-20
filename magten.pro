
if ( firstcall eq !NULL ) then begin
dat=h5_read(712000, /b,/v,/rho,/p) 
grd_ctl, model=712000, g,c
nx=g.nx
ny=g.ny
nz=g.nz
firstcall=1
endif

bx1=transpose(reform(dat.b(0,*,*,*)))
bx2=transpose(reform(dat.b(1,*,*,*)))
bx3=transpose(reform(dat.b(2,*,*,*)))
;vz=transpose(reform(dat.v(2,*,*,*)))


bx=reform(bx1(*,ny/2,*))
by=reform(bx2(*,ny/2,*))
bz=reform(bx3(*,ny/2,*))

x1=findgen(nx)
x2=findgen(ny)
x3=findgen(nz)
x1=g.x
x2=g.y
x3=g.z

dxbx=dblarr(nx,nz)
dxby=dblarr(nx,nz)
dxbz=dblarr(nx,nz)
dzbx=dblarr(nx,nz)
dzby=dblarr(nx,nz)
dzbz=dblarr(nx,nz)


for k=0,nz-1 do begin
dxbx(*,k)=deriv(x1, bx(*,k))
dxby(*,k)=deriv(x1, by(*,k))
dxbz(*,k)=deriv(x1, bz(*,k))
endfor

for i=0,nx-1 do begin
dzbx(i,*)=deriv(x3, bx(i,*))
dzby(i,*)=deriv(x3, by(i,*))
dzbz(i,*)=deriv(x3, bz(i,*))
endfor

magtenx=bx*dxbx+ 0 + bz*dzbx 
magtenz=bx*dxbz+ 0 + bz*dzbz 
magpres=0.5*(bx^2+by^2+bz^2)

!p.position=0
pos=cglayout([1,2] , OXMargin=[11,4], OYMargin=[8,4], XGap=3, YGap=12)
cgdisplay,xs=800,ys=1100

spawn, 'basename $PWD', dirtag
fname="magten";+dirtag
for usingps=0,1 do begin
set_plot, 'ps'
!p.font=0
device, /helvetica ; a classic sans-serif font
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times' , font=1;, /quiet
omega_str='!9W!X'
charsize=cgdefcharsize()*0.9
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse




data=alog10(abs(magtenz))
data=alog10(abs(magtenz))
cgloadct,33
cgcontour, data, x1,x3,$
    ;x2,x1, $
;    /ylog,  $
   ; yrange=[1e-3*mx1,mx1],$
    /fill, nlev=32, $
    ;xrange=[-1,1], $
    xtitle='x', $
    ytitle='z', $
    title='Magnetic Tension z-component', pos=pos(*,0)

curv=findgen(100)
curv=total(magtenz^2,1)
ncurv=curv/max(curv)
curv2=total(magpres^2,1)/max(curv)
cgplot, x3,ncurv, $
    /ylog, $ 
    pos=pos[*,1], /noerase,$
    xtitle='z  ',$
    ytitle='Magnetic Tension', $
    title='Magnetic Tension & Pressure'
cgplot, x3,curv2, $
    pos=pos[*,1], /overplot, linestyle=2
    items=['Tension','Pressure']
    al_legend, items, linestyle=[0,2], /right



if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100 ;, /nomessage
;cgps_close ;, /jpeg,  Width=1100 ;, /nomessage
endif else begin
fname2=fname
endelse

endfor


set_plot, 'x'

end

