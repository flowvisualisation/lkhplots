pload,0, /nodata
cgdisplay, xs=800,ys=1200
pos = cglayout([3,4] , OXMargin=[5,5], OYMargin=[5,12], XGap=3, YGap=7)

;extract_slice (vz, 543,250, nx/2,ny/2,nz/2, [1,0,0], [1,1,0] )
for nfile=0,nlast do begin
fname='allvars'+String(nfile, format='(I04)')

path='./'
varfile='data.'+string(nfile,format='(I04)')+'.dbl'
if (  file_test(path+varfile)  ne 1 ) then begin
print, 'File does not exist, exiting'
break;
endif
plutoread,dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time;, vx1,vx2,vx3, bx1,bx2,bx3,x1,x2,x3,nx1,nx2,nx3,t
print, nfile
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

xptr=ptrarr(12)
xptr(0)=ptr_new(xx)
xptr(1)=ptr_new(xx)
xptr(2)=ptr_new(xx)
xptr(3)=ptr_new(xx)
xptr(4)=ptr_new(xx)
xptr(5)=ptr_new(xx)
xptr(6)=ptr_new(xx)
xptr(7)=ptr_new(xx)
xptr(8)=ptr_new(xx)
xptr(9)=ptr_new(xx)
xptr(10)=ptr_new(xx)
xptr(11)=ptr_new(xx)


yptr=ptrarr(12)
yptr(0)=ptr_new(zz)
yptr(1)=ptr_new(zz)
yptr(2)=ptr_new(zz)
yptr(3)=ptr_new(zz)
yptr(4)=ptr_new(zz)
yptr(5)=ptr_new(zz)
yptr(6)=ptr_new(yy)
yptr(7)=ptr_new(yy)
yptr(8)=ptr_new(yy)
yptr(9)=ptr_new(yy)
yptr(10)=ptr_new(yy)
yptr(11)=ptr_new(yy)


xstr=strarr(12)
xstr(0)='x'
xstr(1)='x'
xstr(2)='x'
xstr(3)='x'
xstr(4)='x'
xstr(5)='x'
xstr(6)='x'
xstr(7)='x'
xstr(8)='x'
xstr(9)='x'
xstr(10)='x'
xstr(11)='x'

ystr=strarr(12)
ystr(0)='z'
ystr(1)='z'
ystr(2)='z'
ystr(3)='z'
ystr(4)='z'
ystr(5)='z'
ystr(6)='y'
ystr(7)='y'
ystr(8)='y'
ystr(9)='y'
ystr(10)='y'
ystr(11)='y'

cgloadct,33
cgerase
for i=0,11 do begin
d=*datptr(i)
sz=size(d,/dimensions)
r=cgscalevector(d,1,254)
x=findgen(sz(0))/sz(0)*!PI
y=findgen(sz(1))/sz(1)*!PI
x=*xptr(i)
y=*yptr(i)
cgimage, r, pos=pos[*,i], /noerase
cgcontour, dist(sz(0),sz(1)) ,x,y, pos=pos[*,i] ,/noerase, /nodata,  title=titlestr[i], $
    xtitle=xstr(i),$
    ytitle=ystr(i)
endfor

cgtext, 0.5,0.92,/normal, 'time= '+string(nfile/10., format='(F5.2)')+' !7X!X!U-1!N' , color='black'

im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endfor
end
