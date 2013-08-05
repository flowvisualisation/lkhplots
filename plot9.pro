
pro plot9 , ax,ay,az
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

titlstr[0]="Ax(x,y)"
titlstr[1]="Atheta(x,y)"
titlstr[2]="Az(x,y)"
titlstr[3]="Ax(x,z)"
titlstr[4]="Atheta(x,z)"
titlstr[5]="Az(x,z)"
titlstr[6]="Ax(y,z)"
titlstr[7]="Atheta(y,z)"
titlstr[8]="Az(y,z)"
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
