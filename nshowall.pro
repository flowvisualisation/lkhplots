nbeg=0
nend=130
nstep=10
cgdisplay, xs=2000,ys=1000
pos = cglayout([6,2] , OXMargin=[5,5], OYMargin=[5,12], XGap=3, YGap=7)

nfile=0
r=h5_read(nfile, /v)
vy0=reform(r.v(1,*,*,*))
;extract_slice (vz, 543,250, nx/2,ny/2,nz/2, [1,0,0], [1,1,0] )
for nfile=nbeg, nend, nstep do begin
fname='allvars'+String(nfile, format='(I07)')
;sload,nfile
r=h5_read(nfile, /v,/B)
grd_ctl,model=nfile, g,c
print, nfile, ' file ,' ,c.time/2/!DPI, ' orbits'
datptr=ptrarr(12)
datptr(0)=ptr_new(reform(transpose(r.v(0,*,0,*))))
datptr(1)=ptr_new(reform(transpose(reform(r.v(1,*,0,*))-vy0(*,0,*) )))
datptr(2)=ptr_new(reform(transpose(r.v(2,*,0,*))))
datptr(3)=ptr_new(reform(transpose(r.b(0,*,0,*))))
datptr(4)=ptr_new(reform(transpose(r.b(1,*,0,*))))
datptr(5)=ptr_new(reform(transpose(r.b(2,*,0,*))))

datptr(6) =ptr_new(reform(transpose(r.v(0,*,*,0))))
datptr(7) =ptr_new(reform(transpose(r.v(1,*,*,0))))
datptr(8) =ptr_new(reform(transpose(r.v(2,*,*,0))))
datptr(9) =ptr_new(reform(transpose(r.b(0,*,*,0))))
datptr(10)=ptr_new(reform(transpose(r.b(1,*,*,0))))
datptr(11)=ptr_new(reform(transpose(r.b(2,*,*,0))))

xptr=ptrarr(12)
xptr(0)=ptr_new(g.x)
xptr(1)=ptr_new(g.x)
xptr(2)=ptr_new(g.x)
xptr(3)=ptr_new(g.x)
xptr(4)=ptr_new(g.x)
xptr(5)=ptr_new(g.x)
xptr(6)=ptr_new(g.y)
xptr(7)=ptr_new(g.y)
xptr(8)=ptr_new(g.y)
xptr(9)=ptr_new(g.y)
xptr(10)=ptr_new(g.y)
xptr(11)=ptr_new(g.y)

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

xstr=strarr(12)
xstr(0)='x'
xstr(1)='x'
xstr(2)='x'
xstr(3)='x'
xstr(4)='x'
xstr(5)='x'
xstr(6)='y'
xstr(7)='y'
xstr(8)='y'
xstr(9)='y'
xstr(10)='y'
xstr(11)='y'

cgloadct,33
cgerase
for i=0,11 do begin
d=*datptr(i)
sz=size(d,/dimensions)
r=cgscalevector(d,1,254)
cgimage, r, pos=pos[*,i], /noerase
x1=*xptr(i)
x2=g.z
cgcontour, dist(sz(0),sz(1)) ,x1,x2, $  
    xtitle=xstr(i),$
    ytitle='z',$
    pos=pos[*,i] ,/noerase, /nodata,  title=titlestr[i]
endfor

cgtext, 0.5,0.92,/normal, 'time= '+string(c.time/2/!DPI, format='(F5.2)')+' orbits' , color='black'

im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endfor
end
