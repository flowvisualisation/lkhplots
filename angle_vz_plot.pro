
mydat=anglevz
mydat2=mydat


for i=0,nx3-1 do begin
angle=mydat[i]
if ( (angle gt  !DPI/2.) and (angle lt  !DPI)) then angle = angle-!DPI/2.0d
if ( (angle lt   0) and (angle gt  -!DPI/2)) then angle = angle+!DPI/2.0d
if ( (angle lt -!DPI/2.) and (angle gt -!DPI)) then angle = angle+!DPI
angle=!PI/2-angle
mydat2[i]=angle*!RADEG
;; correct bad data
;if ( (mydat2[i] gt 20 ) or (mydat2[i] lt 3) ) then begin
;mydat2[i]=mydat2[i-1]
;endif

endfor




spawn, 'basename $PWD', a
dirname=a
fname="angle_vs_z"+dirname
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
charsize=cgdefcharsize()*0.9
pi_str='!9p!X'
endif else  begin
set_plot, 'x'
charsize=cgdefcharsize()*1.1
pi_str='!7p!X'
endelse




cgplot, x3, mydat2, yrange=[0,15], $
        xtitle='z/H',$
        ytitle='angle (degrees)',$
        title='Principal stress angle vs height '
    



if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



end
