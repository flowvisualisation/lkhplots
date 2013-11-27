
pro plot9 , ax,ay,az, tag, num
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


  !X.OMargin = [2, 6]
   !Y.OMargin = [2, 6]
!p.multi=[0,3,3]
!p.position=0
!p.charsize=2
cgloadct,33
for i=0,8 do begin
rd= *var(i)
rr= scale_vector (*var(i),1,255)
sz=size(rr, /dimensions)
dummyarr=findgen( sz)
pos=[0.1,0.2,0.9,.9]
cgimage,rr, pos=pos
imin=min(rd)
imax=max(rd)
cgcontour, dummyarr, /noerase, pos=pos, /nodata, title=titlstr(i)
cbarchar=2.
if (abs( imin - imax) gt  1e-8 ) then begin
cgcolorbar, Position=[pos[0], pos[1]-0.04, pos[2], pos[1]-0.03], range=[imin,imax], format='(G8.2)', charsize=cbarchar
endif
endfor
  cgText, 0.5, 0.95, ALIGNMENT=0.5, CHARSIZE=2.25, /NORMAL, $
      tag, color='black'

fname=tag+string(num, format='(I04)')
im=cgsnapshot(filename=fname, /jpeg, /nodialog)
!p.multi=0


  !Y.OMargin = [0, 0]
   !X.OMargin = [0, 0]
end
