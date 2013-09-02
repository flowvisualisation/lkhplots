usingps=1
if (pencil eq 1) then begin
fname='khpencilzoomerrors.eps'

varfile='VAR0'
pc_read_var, obj=f0, varfile=varfile, /trimall
vx0=f0.uu[*,*,0]
vz0=f0.uu[*,*,1]

varfile='VAR10'
pc_read_var, obj=f0, varfile=varfile, /trimall
vx=f0.uu[*,*,0]
vz=f0.uu[*,*,1]
x1=x[3:mx-4]
x2=y[3:my-4]
nx1=mx-6
nx2=my-6

endif else begin
fname='khplutozoomerrors.eps'
pload,0
vx0=vx1
vz0=vx2

pload,10
vx=vx1
vz=vx2

endelse
;window,xs=800,ys=1100

vort=getvort(vx-vx0,vz-vz0,x1,x2,nx1,nx2)
vortnow=getvort(vx,vz,x1,x2,nx1,nx2)
vort0=getvort(vx0,vz0,x1,x2,nx1,nx2)

slice=50
pos1=nx2*0.74
pos2=nx2*0.76
pos1=nx2*0.7
pos2=nx2*0.8
vx0cut=vx0(slice,pos1:pos2)
vxcut=vx(slice,pos1:pos2)
vxfluctcut= vx(slice,pos1:pos2)-vx0(slice,pos1:pos2)
vzcut= vz(slice,pos1:pos2)-vz0(slice,pos1:pos2)
vortcut= vort(slice,pos1:pos2)
vortalt=vortnow-vort0
vortaltcut=vortalt(slice,pos1:pos2)

zdist=x2(pos1:pos2)
!p.font=0
!p.position=0
!p.multi=[0,1,6]
if ( usingps eq 1) then begin
set_plot,'ps'
device, filename=fname
device, /times
device, /encapsulated
device, xsize=4, ysize=8, /inches
endif
!p.charsize=1.5
!x.style=1
!p.multi=[0,1,6]
cgplot, zdist,vx0cut, title='Vx0'
cgplot, zdist,vxcut, title='Vx' ;, yrange=[-1.001,-.998]
cgplot, zdist,vx0cut, /overplot, linestyle=2
cgplot, zdist,vxfluctcut, title='Vx-Vx0'
cgplot, zdist,vzcut, title='Vz-Vz0'
cgplot, zdist,vortcut, title='VortCut'
cgplot, zdist,vortaltcut, title='VortCut'
!p.multi=0


if ( usingps eq 1) then begin
device, /close
endif
set_plot,'x'

end
