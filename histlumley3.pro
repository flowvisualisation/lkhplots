
pro histlumley3, invii,inviii, nfile, tag, tag2, time
;device, decomposed=0, true=24, retain=2
;cgwindow, xs=1600,ys=800
fname=tag+string(nfile, format='(I07)')




;invii_sqrt=sqrt(abs(invii)/3)
;inviii=sign(inviii)*(abs(inviii)/2)^(1./3.)
invii_sqrt=-invii
inviii=inviii


sz=size(invii, /dimensions)

if ( n_elements(sz) eq 2) then begin 
var1=reform(invii_sqrt, sz(0)*sz(1))
var2=reform(inviii, sz(0)*sz(1))
endif else begin
var1=reform(invii_sqrt, sz(0)*sz(1)*sz(2))
var2=reform(inviii, sz(0)*sz(1)*sz(2))
endelse
mnv1= min(var1)
mnv1=0.0d
mxv1= max(var1)
mxv1=0.34d

mnv2= min(var2)
mnv2=-0.01d
mxv2= max(var2)
mxv2=0.07d

nsize=250
;nsize=500
;nsize=125
;nsize=50
bn1=(mxv1-mnv1)/nsize
bn2=(mxv2-mnv2)/nsize

cx=findgen(nsize+1)*bn1+mnv1
cy=findgen(nsize+1)*bn2+mnv2


lumleyhist=hist_2d(var1, var2, min1=mnv1, max1=mxv1, min2=mnv2, max2=mxv2, bin1=bn1, bin2=bn2)

idstr=['lumley','spare']
arr2=fltarr(2,2)
 h5_2darr, lumleyhist, arr2, tag+string(nfile, format='(I04)'), idstr

;help,lumleyhist
;print, max(lumleyhist)
;lumleyhist[0,0]=1e3

cgloadct,33
resamp=1024
resamp=nsize
d=congrid(lumleyhist,resamp,resamp)
x1=congrid(cy,resamp)
x2=congrid(cx,resamp)
;d=lumleyhist
;x1=cx
;x2=cy

pos=[0.1,0.15,0.9,0.9]
dat=alog(transpose(d)+1e-1)
dat=(transpose(d)+1e-1)
dat=alog10(transpose(d)+1e-1)
r=cgscalevector(dat,0,254 )
rad=r



for usingps=0,1 do begin
if (usingps eq 1) then begin
Set_Plot, 'PS'
Device, DECOMPOSED=0, COLOR=1, BITS_PER_PIXEL=8
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
chi_str='!9c!X'
charsize=cgdefcharsize()*0.9
endif else  begin
set_plot, 'x'
chi_str='!7v!X'
charsize=cgdefcharsize()*1.3
endelse

tvlct,255,255,255,0
;cgerase
;cgimage, r , pos=pos
imin=min(dat)
imax=max(dat)
cgcontour, dat,x1,x2,$
   ; /nodata,$
   ; /noerase,$
    pos=pos, $ 
    xtitle=chi_str+'!D3!N',$
    ytitle='|'+chi_str+'!D2!N|',$
    Charsize=charsize,  $
   ; nlev=10,$
   ; xrange=[0.05,0.07],$
   ; yrange=[0.25,0.33],$
    /fill, $
    nlev=50, $
    color='black', $
    title='Invariants of '+tag2+' stress anisotropy, t='+string(time, format='(F6.2)')
    
 cgColorBar, position=[pos[2]+0.03, pos[1], pos[2]+0.05, pos[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5, /vertical
    cgText, 0.06, 0.32,   '1D', Alignment=0.9, Charsize=charsize
    cgText, -0.008, 0.14,   '2D', Alignment=0.0, Charsize=Charsize
    cgText, 0.001, 0.01,   '3D', Alignment=0.0, Charsize=Charsize

;cgplot, x1, 3./2.*(4*x1/3.)^(2./3.), /overplot
;cgplot, x1,  3.d/2.d*(4.d*x1/3.d)^(2.d/3.d), /overplot
cgplot, x1,  3.d*(x1/2.d)^(2.d/3.d), /overplot
cgplot, -x1,  3.d*(x1/2.d)^(2.d/3.d), /overplot
;cgplot, x1, -x1, /overplot
cgplot, x1, 3*(1./27.+x1), /overplot

if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048, /nomessage

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
