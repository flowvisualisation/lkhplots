
pload,0
vx0=vx1
vz0=vx2

pload,10
vx=vx1
vz=vx2

;window,xs=800,ys=1100

vort=getvort(vx-vx0,vz-vz0,x1,x2,nx1,nx2)
vortnow=getvort(vx,vz,x1,x2,nx1,nx2)
vort0=getvort(vx0,vz0,x1,x2,nx1,nx2)

slice=50
pos1=nx2*0.74
pos2=nx2*0.76
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
set_plot,'ps'
device, filename='vort.eps'
device, /times
device, /encapsulated
device, xsize=4, ysize=8, /inches
!p.charsize=1.5
!x.style=1
!p.multi=[0,1,6]
cgplot, zdist,vx0cut, title='Vx0'
cgplot, zdist,vxcut, title='Vx', yrange=[-1.001,-.998]
cgplot, zdist,vx0cut, /overplot, linestyle=2
cgplot, zdist,vxfluctcut, title='Vx-Vx0'
cgplot, zdist,vzcut, title='Vz-Vz0'
cgplot, zdist,vortcut, title='VortCut'
cgplot, zdist,vortaltcut, title='VortCut'
!p.multi=0


device, /close
set_plot,'x'

end
