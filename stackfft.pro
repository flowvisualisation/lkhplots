
cgdisplay, xs=1200, ys=600
pos=[0.1,0.2,0.9,0.9]
sz=size(vxmax, /dimensions)
varr=vxmax(sz/3:sz-1)

sz=size(varr, /dimensions)

int1=varr(0:sz*.25)^2
int2=varr(sz*.25:sz*.5)^2
int3=varr(sz*.5:sz*.75)^2
int4=varr(sz*.75:sz-1)^2



f1=abs(fft(int1))
f2=abs(fft(int2))
f3=abs(fft(int3))
f4=abs(fft(int4))




sz=size(f1, /dimensions)

f1=f1(0:sz/2)
f2=f2(0:sz/2)
f3=f3(0:sz/2)
f4=f4(0:sz/2)
help, varr


fname="stackfft"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse

help,f1,f2,f3,f4

sz=size(f1,/dimensions)

nu=dindgen(sz)

power=nu*(abs(f1+f2+f3+f4))^2

cgplot, nu,power, /xlog,  xrange=[1,3e3], $
    pos=pos,$
    ;, yrange=[1e-2,4],$
     xtitle="!9n!X",$
     ytitle="!9n!X F "


if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
;cgplot, f2, /overplot
;cgplot, f3, /overplot
;cgplot, f4, /overplot





end
