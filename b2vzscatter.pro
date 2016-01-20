
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
vz=transpose(reform(dat.v(2,*,*,*)))

b2=bx1^2+bx2^2+bx3^2


c=b2(*,*,256:511)
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
fname="b2vz";+dirtag
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




cgcontour, alog10(transpose(velhist)+1e-1),x2,x1, $
    /ylog, yrange=[1e-3*mx1,mx1],$
    /fill, nlev=32, xrange=[-1,1], $
    xtitle='z-Velocity in upper half of box (z>0)', $
    ytitle='Magnetic Pressure', pos=pos(*,0)

cgplot, x2,total(velhist,1), /ylog, yrange=[1e1,1e6] , pos=pos[*,1], /noerase,$
    xtitle='z-Velocity in upper half of box  ',$
    ytitle='Sum of Magnetic pressure distribution'



if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100 ;, /nomessage
;cgps_close ;, /jpeg,  Width=1100 ;, /nomessage
endif else begin
fname2=fname
endelse

endfor



end

