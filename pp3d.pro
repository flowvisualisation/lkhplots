cgloadct,33
!p.charsize=2
!p.multi=[0,3,3]

sx1=f.s.gn[0]
sx2=f.s.gn[1]

;xx=findgen(sx1)
;yy=findgen(sx2)

var=ptrarr(9)

slice=25
spec=1
v0=reform( f.v[slice,*,*,0,spec] )
v1=reform( f.v[*,slice,*,0,spec]  )
v2=reform( f.v[*,*,slice,0,spec] )
v3=reform( f.v[slice,*,*,1,spec] )
v4=reform( f.v[*,slice,*,1,spec] )
v5=reform( f.v[*,*,slice,1,spec] )
v6=reform( f.v[slice,*,*,2,spec] )
v7=reform( f.v[*,slice,*,2,spec] )
v8=reform( f.v[*,*,slice,2,spec] )

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




for i=0,8 do begin
   pos = [0.06, 0.35, 0.98, 0.91]
r=*var(i)
filter= chebyfil(size( r, /dimensions), order=6, cutoff=2)
localimagecopy=applyfilt(reform(r), filter)
   sz=size(localimagecopy, /dimensions)
  xx=findgen(sz(0))
  yy=findgen(sz(1))
 cgIMAGE, localimagecopy, POSITION=pos, background='white', scale=1
 cgcontour, localimagecopy, xx,yy,POSITION=pos, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=titlstr(i), $
       axiscolor='black',$
      xtitle='x ', ytitle='y'
imin=min(localimagecopy)-1e-6
imax=max(localimagecopy)+1e-6
cgcolorbar, Position=[pos[0], pos[1]-0.04, pos[2], pos[1]-0.03], range=[imin,imax], format='(G12.1)', annotatecolor='black'

endfor




end

