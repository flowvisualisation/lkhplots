
cgdisplay, xs=1800, ys=500
posarr = cglayout([4,1] , OXMargin=[9,1], OYMargin=[6,1], XGap=0, YGap=6)
nbeg=1
nend=15

tq=posarr[*,0]
print, (tq[3]-tq[1])*600, (tq[2]-tq[0])*1800
fname="snoopyhistvxvybxby";+string(i, format='(I04)')
for usingps=0,1 do begin
if ( usingps ) then begin
set_plot,'ps'
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /nomatch, xsize=12, ysize=3.5;, /quiet
!p.charsize=1.2
endif else begin
!p.font=-1
!p.color=0
!p.charsize=1.8
set_plot, 'x'
legchar=0.6
endelse
;plotlist=findgen(12)
plotlist=[2,6,12,30]
for i=0,3 do begin
sload,plotlist[i] ;, /silent
sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba

;xx=rebin(reform(x1,nx1,  1,  1),nx1,nx2,nx3) 
;yy=rebin(reform(x2,  1,nx2,  1),nx1,nx2,nx3) 
;zz=rebin(reform(x3,  1,  1,nx3),nx1,nx2,nx3) 
vshear=vsh*xx

;vx=vx1
;vy=vx2-vshear
;bx=bx1
;by=bx2

vec1=bx
vec2=by
qtag='histvxvybxby'

a=reform(vec1, long(nx)*long(ny)*long(nz))
b=reform(vec2, long(nx)*long(ny)*long(nz))
mn1a=min(vec1)
mx1a=max(vec1)
mn2a=min(vec2)
mx2a=max(vec2)
nsize=512
bn1a=(mx1a-mn1a)/(nsize)
bn2a=(mx2a-mn2a)/(nsize)

vec1=vx
vec2=vy
c=reform(vec1, long(nx)*long(ny)*long(nz))
d=reform(vec2, long(nx)*long(ny)*long(nz))


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

maxx=max([max(bx),max(vx)]) 
maxy=max([max(by),max(vy)]) 
minx=min([min(bx),min(vx)]) 
miny=min([min(by),min(vy)]) 


sz=size(magnetic_hist, /dimensions)
cx=findgen(sz(0))*bn1a+mn1a
cy=findgen(sz(1))*bn2a+mn2a




smax=max([maxx,maxy])
smax=30


ytickf="(a1)"
ytit=''
pos=[0.01,0.1,0.98,0.98]
if ( i eq 0 ) then begin
pos=[0.13,0.1,0.98,0.98]
ytickf="(I3)"
		ytit="B!Dy!N, V!Dy!N"
endif





pos=posarr[*,i]
cgcontour, alog10(magnetic_hist+1e-3),cx/10,cy/10,  color='green',  $
		;title="Scatter plots of B!Dr,!9f!X!N and V!Dr,!9f!X!N at t="+string(time, format='(F4.1)')+" orbits", $
		xtitle="B!Dx!N, V!Dx!N",$
	   xrange=[-smax,smax]/10, $
		yrange=[-smax,smax]/10, $
                     ytitle=ytit, $
         ;Ytickinterval=ytick,$
            label=0,$
         xticks=5,$
         yticks=5,$
    xTICKv = [-2,-1,0,1,2],$
    yTICKv = [-2,-1,0,1,2],$
            /noerase,$
         yTICKFORMAT=ytickf,$
        pos=pos,$
		xstyle=1,$
		ystyle=1

sz=size(velocity_hist, /dimensions)
c1x=findgen(sz(0))*bn1+mn1
c1y=findgen(sz(1))*bn2+mn2
cgcontour, alog10(velocity_hist+1e-3), c1x/10,c1y/10, axiscolor='black' , /overplot, color='blue',$
            label=0

items=['V','B']
lines=[0,0]
color=[cgcolor('blue'),cgcolor('green')]

if ( i eq 0) then begin
al_legend, items,linestyle=lines, colors=color, /left, charsize=1.2,linsize=0.25
endif
;cgplot, a,b, psym=1, $
;		title="Scatter plots of B!DX,Y!N and V!DX,Y!N at t="+string(i)+" orbits", $
;		xtitle="B!DX!N, V!DX!N",$
;		ytitle="B!DY!N, V!DY!N"
;cgplot,c,d,psym=1,/overplot, color='red'

;stop






endfor

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048
print, 'in ps'
set_plot, 'x'
endif else begin
print, 'in x'
endelse
endfor
end


;Result = HIST_2D(reform(vec1,128L*128L*64L),reform(vec2,128L*128L*64L), MIN1=-6e-7, MAX1=6e-7,  MIN2=-6e-7, MAX2=6e-7, BIN1=4e-9, BIN2=4e-9)      
;Result = HIST_2D(reform(vec1,128L*128L*64L),reform(vec2,128L*128L*64L), MIN1=-6e-7, MAX1=6e-7,  MIN2=-6e-7, MAX2=6e-7, BIN1=4e-9, BIN2=4e-9)      


