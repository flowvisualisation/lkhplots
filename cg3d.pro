
cgloadct,33
!p.multi=[0,3,3]

sx1=nx1
sx2=nx2


var=ptrarr(9)

slice=25
v0=reform( vx1[slice,*,*] )
v1=reform( vx1[*,slice,*]  )
v2=reform( vx1[*,*,slice] )
v3=reform( vx2[slice,*,*] )
v4=reform( vx2[*,slice,*] )
v5=reform( vx2[*,*,slice] )
v6=reform( vx3[slice,*,*] )
v7=reform( vx3[*,slice,*] )
v8=reform( vx3[*,*,slice] )

var(0)=ptr_new(v0)
var(1)=ptr_new(v1)
var(2)=ptr_new(v2)
var(3)=ptr_new(v3)
var(4)=ptr_new(v4)
var(5)=ptr_new(v5)
var(6)=ptr_new(v6)
var(7)=ptr_new(v7)
var(8)=ptr_new(v8)

titlstr=strarr(9)
titlstr(0)='vx'
titlstr(1)='vx'
titlstr(2)='vx'
titlstr(3)='vy'
titlstr(4)='vy'
titlstr(5)='vy'
titlstr(6)='vz'
titlstr(7)='vz'
titlstr(8)='vz'



for i=0,14 do begin
   pos = [0.02, 0.35, 0.98, 0.91]
localimagecopy=reform(*var(i))
 cgIMAGE, localimagecopy, POSITION=pos, /KEEP_ASPECT_RATIO ,background='white', scale=1
 cgcontour, localimagecopy, xx,yy,POSITION=pos, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=titlstr(i), $
       axiscolor='black',$
      xtitle='x ', ytitle='y'
imin=min(localimagecopy)-1e-6
imax=max(localimagecopy)+1e-6
cgcolorbar, Position=[pos[0], pos[1]-0.04, pos[2], pos[1]-0.03], range=[imin,imax], format='(G12.1)', annotatecolor='black'

endfor




end
