
pro histbaner, invii,inviii, nfile, tag, tag2, time, tag3
;device, decomposed=0, true=24, retain=2
;cgwindow, xs=1600,ys=800
fname=tag+string(nfile, format='(I07)')
fname=tag;+string(nfile, format='(I07)')




;invii_sqrt=sqrt(abs(invii)/3)
;inviii=sign(inviii)*(abs(inviii)/2)^(1./3.)


sz=size(invii, /dimensions)

if ( n_elements(sz) eq 2) then begin 
var1=reform(invii, sz(0)*sz(1))
var2=reform(inviii, sz(0)*sz(1))
endif else begin
var1=reform(invii, sz(0)*sz(1)*sz(2))
var2=reform(inviii, sz(0)*sz(1)*sz(2))
endelse

mnv1=-1.0
mxv1=1.0
mnv2=0
mxv2=1.74
nsize=250
bn1=(mxv1-mnv1)/nsize
bn2=(mxv2-mnv2)/nsize
lumleyhist=hist_2d(var1, var2, min1=mnv1, max1=mxv1, min2=mnv2, max2=mxv2, bin1=bn1, bin2=bn2)
lumleyhist[*,0]=0

cx=findgen(nsize+1)*bn1+mnv1
cy=findgen(nsize+1)*bn2+mnv2

idstr=['lumley','spare']
arr2=fltarr(2,2)
 h5_2darr, lumleyhist, arr2, tag+string(nfile, format='(I08)'), idstr

;help,lumleyhist
;print, max(lumleyhist)
;lumleyhist[0,0]=1e3

cgloadct,33
resamp=1024
resamp=nsize
d=congrid(lumleyhist,resamp,resamp)
x1=congrid(cx,resamp)
x2=congrid(cy,resamp)
;d=lumleyhist
;x1=cx
;x2=cy

pos=[0.1,0.15,0.9,0.9]
dat=smooth(d,1)
r=cgscalevector(dat,0,254 )
rad=r



xs=1000
ys=860
cgdisplay, xs=xs,ys=ys
for usingps=0,1 do begin
if (usingps eq 1) then begin
;Set_Plot, 'PS'
;Device, DECOMPOSED=0, COLOR=1, BITS_PER_PIXEL=8
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
chi_str='!9c!X'
charsize=cgdefcharsize()*0.9
endif else  begin
set_plot, 'x'
chi_str='!7v!X'
charsize=cgdefcharsize()*1.3
endelse

tvlct,255,255,255,0
r=cgscalevector(dat,0,254)
cgimage, r , pos=pos, $
    title=tag2+' barycentric map, t='+string(time, format='(F6.2)')
imin=min(dat)
imax=max(dat)
;cgcontour, dat,x1,x2,$
cgcontour, dat,x1,x2,$
    /nodata, /noerase,$
    pos=pos, $ 
    axiscolor='white',$
;;    Charsize=charsize,  $
;    /fill, $
    xticklayout=1, $
    yticklayout=1, $
    xtickname=REPLICATE(' ', 2),$
    ytickname=REPLICATE(' ', 2),$
    xticks=1,$
    yticks=1
;    nlev=50, $
;    color='black', $
    
 cgColorBar, position=[pos[2]+0.03, pos[1], pos[2]+0.05, pos[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5, /vertical


l1=2./3.
l2=-1./3.
l3=l2
qme=barycentric ( l1, l2, l3, x1a, y1a)
l1=0.5-1./3.
l2=l1
l3=-1./3.
qme=barycentric ( l1, l2, l3, x2a, y2a)

l1=0
l2=0
l3=0
qme=barycentric ( l1, l2, l3, x3, y3)

x4=1./3.
y4=0.

cgplots, x1a,y1a, psym=4, color='black'
cgtext, x1a-.1, y1a-.1, 'One component'

cgplots, x2a,y2a, psym=4
cgtext, x2a-0.3, y2a-0.1, 'Two component'

cgplots, x3,y3, psym=4
cgtext, x3-.2, y3+0.1, 'Three component'

cgtext, x3-.95, y3+0.1, tag3

cx2=cx ( where ( cx le 0))
cx3=cx ( where ( cx ge 0))

cgplot, cx2,  1.74*cx2+1.74, /overplot,pos=pos
cgplot, cx3,  -1.74*cx3+1.74, /overplot, pos=pos
cgplot, cx,  0*cx, /overplot, pos=pos, color='red'


m=(1.74-0)/(0-x4)
c=1.74
print, 'm=',m
print, 'c=',c
;cgplot, cx3,  m*cx3+c, /overplot, pos=pos, color='green'


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
;cgps_open, "test.eps"
;cgimage,rad
;cgps_close, /jpeg
set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


;im=cgsnapshot(filename=fname, /jpeg, /nodialog)

end
