
pro plot9 , ax,ay,az, tag
nx=10
var=ptrarr(9)
titlstr=strarr(9,30)
slicex=nx/2

var[0]=ptr_new(reform(ax[*,*,slicex]))
var[1]=ptr_new(reform(ay[*,*,slicex]))
var[2]=ptr_new(reform(az[*,*,slicex]))
var[3]=ptr_new(reform(ax[*,slicex,*]))
var[4]=ptr_new(reform(ay[*,slicex,*]))
var[5]=ptr_new(reform(az[*,slicex,*]))
var[6]=ptr_new(reform(ax[slicex,*,*]))
var[7]=ptr_new(reform(ay[slicex,*,*]))
var[8]=ptr_new(reform(az[slicex,*,*]))


titlstr[0]=tag+"x(x,y)"
titlstr[1]=tag+"theta(x,y)"
titlstr[2]=tag+"z(x,y)"
titlstr[3]=tag+"x(x,z)"
titlstr[4]=tag+"theta(x,z)"
titlstr[5]=tag+"z(x,z)"
titlstr[6]=tag+"x(y,z)"
titlstr[7]=tag+"theta(y,z)"
titlstr[8]=tag+"z(y,z)"


window, xs=800,ys=800
!p.multi=[0,3,3]
!p.position=0
!p.charsize=2
cgloadct,33
for i=0,8 do begin
rr= scale_vector (*var(i),1,255)
sz=size(rr, /dimensions)
dummyarr=findgen( sz)
pos=[0.1,0.1,0.9,.9]
cgimage,rr, pos=pos
cgcontour, dummyarr, /noerase, pos=pos, /nodata, title=titlstr(i)
endfor
!p.multi=0
end
