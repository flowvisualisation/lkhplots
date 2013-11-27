pro plot_theta, thetabarr,thetavarr,tnorm


fname="theta_b_v"
for usingps=0,1 do begin
if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
;xs=12.-ar*6
;ys=6+ar*4
xsize=9
aspect_ratio=1.5 ;rectangle
device, xsize=xsize, ysize=xsize/aspect_ratio


!p.charsize=0.6
cbarchar=0.9
alchar=0.9
xyout=0.9
endif else begin
if ( keyword_set (zbuf) ) then begin
set_plot,'z'
ys=1200
xs=1800
!p.charsize=1.8
cbarchar=1.8
xyout=1.8
device, set_resolution=[xs,ys]
endif else begin
set_plot,'x'
!p.font=-1
!p.charsize=1.8
cbarchar=1.8
xyout=1.8
endelse
;device, set_resolution=[1100,800]
endelse


sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba

items=['tan!U-1!N B!DX!N/B!DY!N','tan!U-1!N V!DX!N/V!DY!N']
linestyles=[0,0]
psym=[0,1]
colors=['red', 'blue']

!p.font=0
;device, set_font="-adobe-times-bold-r-normal--17-80-100-100-p-57-iso8859-14"
;device, set_font="
!p.thick=2

q2=5
q1=4

cgplot, tnorm, thetabarr,  $
		xstyle=1, $
		xtitle="Time,t [orbits]",$
		title="tan!U-1!N B!DX!N/B!DY!N and tan!U-1!N V!DX!N/V!DY!N",$
		color=colors[0], linestyle=linestyles[0]

	cgplot, tnorm, thetavarr, /overplot, color=colors[1], linestyle=linestyles[1]

	al_legend, items, colors=colors, linestyle=linestyles



if ( usingps ) then begin
device,/close
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse


endfor

	end
