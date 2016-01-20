
if ( firstcall eq !NULL ) then begin
dat=h5_read(712000, /v,/rho) 
grd_ctl, model=712000, g,c
nx=g.nx
ny=g.ny
nz=g.nz
firstcall=1
endif

rho=transpose(reform(dat.rho(*,*,*)))
vz=transpose(reform(dat.v(2,*,*,*)))



c=rho(*,*,256:511)
d=vz(*,*,256:511)
sz=size(d, /dimensions)

c=reform(c,sz(0)*sz(1)*sz(2))
d=reform(d,sz(0)*sz(1)*sz(2))
nsize=256

mn1=min(c)
mx1=max(c)
mn2=min(d)
mn2=-max(d)
mx2=max(d)
bn1=(mx1-mn1)/nsize
;bn1=5e-9
bn2=(mx2-mn2)/nsize
;bn2=0.01

velhist = HIST_2D(c,d,MIN1=mn1, MAX1=mx1,  MIN2=mn2, MAX2=mx2, BIN1=bn1, BIN2=bn2)

sz=size(velhist, /dimensions)
x1=findgen(sz(0))*bn1
x2=findgen(sz(1))*bn2+mn2
print, sz
;cgplot, c,d, psym=3, yrange=[-1,1]
;cgcontour, alog10(velhist+1e-1),x1,x2, /fill, nlev=32, yrange=[-1,1]
!p.position=0
pos=cglayout([1,2] , OXMargin=[11,4], OYMargin=[8,4], XGap=3, YGap=12)
cgdisplay,xs=800,ys=1100

spawn, 'basename $PWD', dirtag
fname="rhovz";+dirtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times' , font=1;, /quiet
omega_str='!9W!X'
charsize=cgdefcharsize()*0.9
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse

cgloadct,33
cgcontour, alog10(transpose(velhist)+1e-1),x2,x1, $
charsize=charsize,$
    /ylog, yrange=[1e-4*mx2,mx2],$
    /fill, nlev=32, xrange=[-1,1], $
    xtitle='z-Velocity in upper half of box (z>0)', $
    ytitle='Gas Density, !9r!X  ', pos=pos(*,0)

cgplot, x2,total(velhist,1), /ylog, yrange=[1e1,1e6] , pos=pos[*,1], /noerase,$
charsize=charsize,$
    xtitle='z-Velocity in upper half of box  ',$
    ytitle='Sum of density distribution'


if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100 ;, /nomessage
;cgps_close ;, /jpeg,  Width=1100 ;, /nomessage
endif else begin
fname2=fname
endelse

endfor



end

