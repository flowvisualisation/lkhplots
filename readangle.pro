
cgdisplay, xs=800,ys=600
readcol, 'new.txt', num, angle
savangle=angle


a90= where( (angle gt 90) and (angle lt 180)) 
am45= where( (angle lt 0) and (angle gt -90 )) 
am90= where( (angle lt -90) and (angle gt -180)) 


;angle(a90)= angle(a90) -90
;angle(am45)= angle(am45) +90
;angle(am90)= angle(am90) +180
;angle=90-angle

na=size(angle, /dimensions)

; bad=where(angle eq max(angle))
; angle(bad)=0.5*(angle(bad+1)+angle(bad-1))




fname="angle_"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse


r= histogram( angle[0.25*na:na-1], locations=xbin)  
cgplot, xbin, r, xtitle='Angle !Uo!N', ytitle='Frequency'

;cgplot, findgen(100), pos=[0.5,0.5,0.9,.9], /noerase

;cgplot,num, angle, xtitle='time, !9W!X!U-1!N', ytitle='angle' , xstyle=1
meanangle=mean(angle[50:na-1])
print, meanangle, mean(angle)
;cgplot,num, angle-angle+meanangle, /overplot

if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor






end 

