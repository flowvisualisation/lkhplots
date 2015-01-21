pro dispgenps3, n, varname, data, n1,n2,x1,x2, title, xtit1, ytit1

dt=4.e-5
wp=sqrt(2e10)
wp=1e4
wpi=1/wp
massratio=250.

simtime=n*dt ;*wpi ;*wp/sqrt(massratio)

suffix=string(n,format='(I07)')
cgloadct,20
cgloadct,33
tvlct,255,255,255,1


cgerase,1


fname="ionxpx"+suffix
for usingps=0,1 do begin
if (usingps eq 1) then begin
!p.font=0
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
!p.font=-1
endelse



pos=[0.15,0.15,0.98,0.95]
;data(0,0)=1
;data(0,1)=1e2
;data(0,1)=1e2
r=data
imin=min(r)
imax=max(r)
print,  max(data)
d=cgscalevector(r,1,255)
cgimage,d, position=pos
!x.style=1
!y.style=1
help,d,x1,x2
cgcontour, d, x1,x2,/nodata,/noerase, position=pos, $
        xtitle=xtit1,$
        ytitle=ytit1,$
        charsize=cgdefcharsize()*0.7,$
        title=title
cbpos=[ pos[0],pos[1]-0.09, pos[2], pos[1]-0.08]
cgcolorbar, range=[imin,imax], position=cbpos, format='(F4.1)', charsize=cgdefcharsize()*.5
fname='2d'+varname+suffix
print, fname

if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage
endif else begin
fname2=fname
endelse

endfor




print, max(data)

loadct,0
end
