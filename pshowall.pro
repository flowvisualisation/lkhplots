pload,0, /nodata
cgdisplay, xs=800,ys=1200
pos = cglayout([3,4] , oxmargin=[5,5], oymargin=[5,5], XGap=3, YGap=3)

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

datptr(6) =ptr_new(reform(vx(0,*,*)))
datptr(7) =ptr_new(reform(vy(0,*,*)))
datptr(8) =ptr_new(reform(vz(0,*,*)))
datptr(9) =ptr_new(reform(bx(0,*,*)))
datptr(10)=ptr_new(reform(by(0,*,*)))
datptr(11)=ptr_new(reform(bz(0,*,*)))

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
xptr(6)=ptr_new(yy)
xptr(7)=xptr(6)
xptr(8)=xptr(6)
xptr(9)=xptr(6)
xptr(10)=xptr(6)
xptr(11)=xptr(6)


yptr=ptrarr(12)
yptr(0)=ptr_new(zz)
yptr(1)=ptr_new(zz)
yptr(2)=ptr_new(zz)
yptr(3)=ptr_new(zz)
yptr(4)=ptr_new(zz)
yptr(5)=ptr_new(zz)
yptr(6)=yptr(0)
yptr(7)=yptr(0)
yptr(8)=yptr(0)
yptr(9)=yptr(0)
yptr(10)=yptr(0)
yptr(11)=yptr(0)


xstr=strarr(12)
xstr(0)=''
xstr(1)=''
xstr(2)=''
xstr(3)='x'
xstr(4)='x'
xstr(5)='x'
xstr(6)=''
xstr(7)=''
xstr(8)=''
xstr(9)='y'
xstr(10)='y'
xstr(11)='y'

ystr=strarr(12)
ystr(0)='z'
ystr(1)=''
ystr(2)=''
ystr(3)='z'
ystr(4)=''
ystr(5)=''
ystr(6)='z'
ystr(7)=''
ystr(8)=''
ystr(9)='z'
ystr(10)=''
ystr(11)=''

cgloadct,33
cgerase
for i=0,11 do begin

xtickf='(a1)'
ytickf='(a1)'
if ( i gt 8 ) then begin
xtickf='(I3)'
endif

if ( ( i mod 3 ) eq 0 ) then begin
ytickf='(I3)'
endif
d=*datptr(i)
sz=size(d,/dimensions)
r=cgscalevector(d,1,254)
x=findgen(sz(0))/sz(0)*!PI
y=findgen(sz(1))/sz(1)*!PI
x=*xptr(i)
y=*yptr(i)
cgimage, r, pos=pos[*,i], /noerase
cgcontour, dist(sz(0),sz(1)) ,x,y, pos=pos[*,i] ,/noerase, /nodata,  title=titlestr[i], $
    xtickformat=xtickf,$
    ytickformat=ytickf,$
    xtitle=xstr(i),$
    ytitle=ystr(i)
endfor

cgtext, 0.5,0.97,/normal, 'time= '+string(nfile/10., format='(F5.2)')+' !7X!X!U-1!N' , color='black'

im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endfor
end
