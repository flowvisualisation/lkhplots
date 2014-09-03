cgdisplay, xs=800,ys=1200
pos = cglayout([3,4] , OXMargin=[5,5], OYMargin=[5,12], XGap=3, YGap=7)

;extract_slice (vz, 543,250, nx/2,ny/2,nz/2, [1,0,0], [1,1,0] )
for nfile=0,30 do begin
fname='allvars'+String(nfile, format='(I04)')

plutoread,dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time;, vx1,vx2,vx3, bx1,bx2,bx3,x1,x2,x3,nx1,nx2,nx3,t
datptr=ptrarr(12)
datptr(0)=ptr_new(reform(vx(*,0,*)))
datptr(1)=ptr_new(reform(vy(*,0,*)))
datptr(2)=ptr_new(reform(vz(*,0,*)))
datptr(3)=ptr_new(reform(bx(*,0,*)))
datptr(4)=ptr_new(reform(by(*,0,*)))
datptr(5)=ptr_new(reform(bz(*,0,*)))

datptr(6) =ptr_new(reform(vx(*,*,0)))
datptr(7) =ptr_new(reform(vy(*,*,0)))
datptr(8) =ptr_new(reform(vz(*,*,0)))
datptr(9) =ptr_new(reform(bx(*,*,0)))
datptr(10)=ptr_new(reform(by(*,*,0)))
datptr(11)=ptr_new(reform(bz(*,*,0)))

titlestr=strarr(12)
titlestr(0)='vx'
titlestr(1)='vy'
titlestr(2)='vz'
titlestr(3)='bx'
titlestr(4)='by'
titlestr(5)='bz'
titlestr(6)='vx'
titlestr(7)='vy'
titlestr(8)='vz'
titlestr(9)='bx'
titlestr(10)='by'
titlestr(11)='bz'

cgloadct,33
cgerase
for i=0,11 do begin
d=*datptr(i)
sz=size(d,/dimensions)
r=cgscalevector(d,1,254)
x=findgen(sz(0))/sz(0)*!PI
y=findgen(sz(1))/sz(1)*!PI
cgimage, r, pos=pos[*,i], /noerase
cgcontour, dist(sz(0),sz(1)) ,x,y, pos=pos[*,i] ,/noerase, /nodata,  title=titlestr[i]
endfor

cgtext, 0.5,0.92,/normal, 'time= '+string(nfile/10., format='(F5.2)')+' !7X!X!U-1!N' , color='black'

im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endfor
end
