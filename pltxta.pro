

dataptr=ptrarr(18)

dataptr[ 0]=ptr_new(zt[*,*,0])
dataptr[ 1]=ptr_new(zt[*,*,1])
dataptr[ 2]=ptr_new(zt[*,*,2])
dataptr[ 3]=ptr_new(zt[*,*,3])
dataptr[ 4]=ptr_new(zt[*,*,4])
dataptr[ 5]=ptr_new(zt[*,*,5])
dataptr[ 6]=ptr_new(xt[*,*,0])
dataptr[ 7]=ptr_new(xt[*,*,1])
dataptr[ 8]=ptr_new(xt[*,*,2])
dataptr[ 9]=ptr_new(xt[*,*,3])
dataptr[10]=ptr_new(xt[*,*,4])
dataptr[11]=ptr_new(xt[*,*,5])
dataptr[12]=ptr_new(yt[*,*,0])
dataptr[13]=ptr_new(yt[*,*,1])
dataptr[14]=ptr_new(yt[*,*,2])
dataptr[15]=ptr_new(yt[*,*,3])
dataptr[16]=ptr_new(yt[*,*,4])
dataptr[17]=ptr_new(yt[*,*,5])

pos=[0.2,0.1,0.9,0.9]

titlestr=strarr(18,30)
titlestr[ 0,*]='vx(z,t)'
titlestr[ 1,*]='vy(z,t)'
titlestr[ 2,*]='vz(z,t)'
titlestr[ 3,*]='bx(z,t)'
titlestr[ 4,*]='by(z,t)'
titlestr[ 5,*]='bz(z,t)'
titlestr[ 6,*]='vx(x,t)'
titlestr[ 7,*]='vy(x,t)'
titlestr[ 8,*]='vz(x,t)'
titlestr[ 9,*]='bx(x,t)'
titlestr[10,*]='by(x,t)'
titlestr[11,*]='bz(x,t)'
titlestr[12,*]='vx(y,t)'
titlestr[13,*]='vy(y,t)'
titlestr[14,*]='vz(y,t)'
titlestr[15,*]='bx(y,t)'
titlestr[16,*]='by(y,t)'
titlestr[17,*]='bz(y,t)'

xx=findgen(370)
yy=findgen(10)/10


time=0



   cgDisplay, WID=1,xs=1800, ys=1200
fname="timeaverages_integrated"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times'
endif else  begin
set_plot, 'x'
endelse




   cgLoadCT, 33
   pos = cglayout([1,6] , OXMargin=[5,12], OYMargin=[5,5], XGap=7, YGap=2)
   FOR j=6,11 DO BEGIN
     p = pos[*,j-6]
     d= *dataptr(j)
	r=cgscalevector(d[30:200,*], 1,254)
	imin=min(*dataptr[j])
	imax=max(*dataptr[j])
     cgImage, r, NoErase=j NE 0, Position=p
  cgcontour,xx#yy, xx,yy , /nodata, /noerase, xtitle='x', pos=p, title=titlestr(j), Charsize=cgDefCharsize()*0.5
     cgColorBar, position=[p[2]+0.06, p[1], p[2]+0.07, p[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5, /vertical
   ENDFOR
   cgText, 0.5, 0.96, /Normal,  'Time average height integrated v!Dxyz!N,b!Dxyz!N', Alignment=0.5, Charsize=cgDefCharsize()*1.25


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



