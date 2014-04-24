
pro histlumley, invii,inviii, nfile,  tag, tag2, time

;device, decomposed=0, true=24, retain=2
fname=tag+string(nfile, format='(I04)')







sz=size(invii, /dimensions)

var1=reform(-invii, sz(0)*sz(1))
var2=reform(inviii, sz(0)*sz(1))
mnv1= min(var1)
;mnv1=-0.01
mxv1= max(var1)
;mxv1=0.34

mnv2= min(var2)
;mnv2=-0.01
mxv2= max(var2)
;mxv2=0.07

nsize=250
bn1=(mxv1-mnv1)/nsize
bn2=(mxv2-mnv2)/nsize

cx=findgen(nsize+1)*bn1+mnv1
cy=findgen(nsize+1)*bn2+mnv2


lumleyhist=hist_2d(var1, var2, min1=mnv1, max1=mxv1, min2=mnv2, max2=mxv2, bin1=bn1, bin2=bn2)
;help,lumleyhist
print, max(lumleyhist)
lumleyhist[0,0]=2e3

;cgcontour, alog10(transpose(lumleyhist)+1e-6),cy,cx
cgloadct,33
d=congrid(lumleyhist,800,800)
x1=congrid(cy,800)
x2=congrid(cx,800)
d=lumleyhist
x1=cy
x2=cx

pos=[0.1,0.1,0.9,0.9]
dat=alog10(transpose(d)+1e-1)
r=cgscalevector(dat,0,254 )


for usingps=0,1 do begin
if (usingps eq 1) then begin
Set_Plot, 'PS'
Device, DECOMPOSED=0, COLOR=1, BITS_PER_PIXEL=8
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse

tvlct,255,255,255,0
;cgimage, r, pos=pos
imin=min(dat)
imax=max(dat)
 cgColorBar, position=[pos[2]+0.03, pos[1], pos[2]+0.05, pos[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5, /vertical
cgcontour, dat,x1,x2,  pos=pos, $ 
   ; /nodata,$
   ; /noerase,$
   ; nlev=10,$
;    xrange=[0.2,0.3],$
;    yrange=[0.2,0.3],$
    /fill, $
    color='black', $
    title='II,III invariants of '+tag2+' stress anisotropy, t='+string(time, format='(F6.2)'),$
    xtitle='III',$
    ytitle='II',$
Charsize=cgDefCharsize()*0.5
    
    cgText, 0.06, 0.3,   '1D turbulence', Alignment=0.5, Charsize=cgDefCharsize()*.5
    cgText, 0.02, 0.2,   '2D turbulence', Alignment=0.5, Charsize=cgDefCharsize()*.5
    cgText, 0.0, 0.15,   '2D isotropic', Alignment=0.9, Charsize=cgDefCharsize()*.5
    cgText, 0.0, 0.0,   '3D isotropic turbulence', Alignment=0.0, Charsize=cgDefCharsize()*.5


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


;im=cgsnapshot(filename=fname, /jpeg, /nodialog)

end
