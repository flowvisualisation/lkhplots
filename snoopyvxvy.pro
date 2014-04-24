
window, xs=1200, ys=1200
for i=0,20 do begin
sload,i;, /silent
sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba

;xx=rebin(reform(x1,nx1,  1,  1),nx1,nx2,nx3) 
;yy=rebin(reform(x2,  1,nx2,  1),nx1,nx2,nx3) 
;zz=rebin(reform(x3,  1,  1,nx3),nx1,nx2,nx3) 
vshear=vsh*xx

vec1=bx
vec2=by
qtag='bxby'

a=reform(vec1, 128L*128L*64L)
b=reform(vec2, 128L*128L*64L)
mn1a=min(vec1)
mx1a=max(vec1)
mn2a=min(vec2)
mx2a=max(vec2)
nsize=25
bn1a=(mx1a-mn1a)/(nsize)
bn2a=(mx2a-mn2a)/(nsize)

vec1=vx
vec2=vy
qtag='vxvy'
c=reform(vec1, 128L*128L*64L)
d=reform(vec2, 128L*128L*64L)


mn1=double(-6e-7)	
mx1=double( 6e-7)	
mn2=double(-6e-7)	
mx2=double( 6e-7)	
;print, min(vec1)
mn1=min(vec1)
mx1=max(vec1)
mn2=min(vec2)
mx2=max(vec2)
bn1=(mx1-mn1)/nsize
bn2=(mx2-mn2)/nsize

cx=findgen(nsize+1)*bn1+mn1
cy=findgen(nsize+1)*bn2+mn2

velocity_hist = HIST_2D(c,d,MIN1=mn1, MAX1=mx1,  MIN2=mn2, MAX2=mx2, BIN1=bn1, BIN2=bn2)
magnetic_hist = HIST_2D(a,b,MIN1=mn1a, MAX1=mx1a,  MIN2=mn2a, MAX2=mx2a, BIN1=bn1a, BIN2=bn2a)
;Result = HIST_2D(reform(vec1,128L*128L*64L),reform(vec2,128L*128L*64L), MIN1=-6e-7, MAX1=6e-7,  MIN2=-6e-7, MAX2=6e-7, BIN1=4e-9, BIN2=4e-9)      
cgloadct,0, /reverse
;cgimage, alog10(result+1e-1)
print, i
print, size(result), size(cx), size(cy)



sz=size(magnetic_hist, /dimensions)
cx=findgen(sz(0))*bn1a+mn1a
cy=findgen(sz(1))*bn2a+mn2a
;cgcontour, magnetic_hist,cx,cy,  color='red',  $
;		title="Scatter plots of B!DX,Y!N and V!DX,Y!N at t="+string(i)+" orbits", $
;		xtitle="B!DX!N, V!DX!N",$
;		ytitle="B!DY!N, V!DY!N"

sz=size(velocity_hist, /dimensions)
cx=findgen(sz(0))*bn1+mn1
cy=findgen(sz(1))*bn2+mn2
;cgcontour, velocity_hist, cx,cy, axiscolor='black' , /overplot

cgplot, a,b, psym=1, $
		title="Scatter plots of B!DX,Y!N and V!DX,Y!N at t="+string(i)+" orbits", $
		xtitle="B!DX!N, V!DX!N",$
		ytitle="B!DY!N, V!DY!N"
cgplot,c,d,psym=1,/overplot, color='red'

;stop

ll=6
zero=''
nts=strcompress(string(i),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname=qtag+zero+nts
im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endfor



end


;Result = HIST_2D(reform(vec1,128L*128L*64L),reform(vec2,128L*128L*64L), MIN1=-6e-7, MAX1=6e-7,  MIN2=-6e-7, MAX2=6e-7, BIN1=4e-9, BIN2=4e-9)      
;Result = HIST_2D(reform(vec1,128L*128L*64L),reform(vec2,128L*128L*64L), MIN1=-6e-7, MAX1=6e-7,  MIN2=-6e-7, MAX2=6e-7, BIN1=4e-9, BIN2=4e-9)      


