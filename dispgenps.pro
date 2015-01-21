pro dispgenps, n, varname, data, n1,n2,x1,x2

dt=1.139e-6
wp=sqrt(2e10)
massratio=250.

simtime=n*dt*wp/sqrt(massratio)

suffix=string(n,format='(I07)')
data=data+1
loadct,33
tvlct,0,0,0,0
tvlct,255,255,255,1

;!p.font=1

erase,1


fname="ionxpx"+suffix
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse



pos=[0.1,0.2,0.9,0.9]
r=alog10(data)
imin=min(r)
imax=max(r)
d=cgscalevector(r,1,255)
cgimage,d, position=pos
!x.style=1
!y.style=1
cgcontour, d, x1,x2,/nodata,/noerase, position=pos,color=0, $
        xtitle="X/!7m!3!Dion,s!N"
        title=varname+' t='+string(simtime, format='(f5.1)')+'!7x!3!Dp,ion!N'
pos=[0.1,0.05,0.9,0.1]
colorbar, range=[imin,imax], position=pos, format='(F4.1)'
;im=tvread(filename='2d'+varname+suffix, /png, /nodialog)




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


print, max(data)
loadct,0



end
