
cgdisplay, xs=1600, ys=800

titlarr=strarr(6)
titlarr(0)='vx'
titlarr(1)='vy'
titlarr(2)='vz'
titlarr(3)='bx'
titlarr(4)='by'
titlarr(5)='bz'
sizesp=32
spec=fltarr(6,sizesp)
wns=fltarr(6,sizesp)

pos = cglayout([3,2] , OXMargin=[7,5], OYMargin=[5,7], XGap=7, YGap=7)
for nfile=1090,1170 do begin



code='pluto'
code='snoopy'
switch code OF 
'pluto': begin
pload,nfile
plutoread, dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
break;
end
'snoopy':begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
end
end
datptr=ptrarr(6)
datptr[0]=ptr_new(vx)
datptr[1]=ptr_new(vy)
datptr[2]=ptr_new(vz)
datptr[3]=ptr_new(bx)
datptr[4]=ptr_new(by)
datptr[5]=ptr_new(bz)
fname="psd_"+string(nfile, format='(I04)')

for usingps=0,1 do begin
if (usingps eq 1) then begin
Set_Plot, 'PS'
Device, DECOMPOSED=0, COLOR=1, BITS_PER_PIXEL=8
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse


for i=0,5 do begin
r=*datptr[i]
power3d, r, wavenumbers=wns_t, spectrum=spec_t, /noplot
spec(i,*)=spec_t
wns(i,*)=wns_t
endfor
cgerase
cgText, 0.5, 0.96, /Normal,  'PSD testing, t='+string(time), Alignment=0.5, Charsize=cgDefCharsize()*1.25
for i=0,5 do begin
cgplot, wns(i,*),spec(i,*), /xlog, /ylog, xrange=[1,100], title=titlarr(i), pos=pos(*,i), /noerase, Charsize=cgDefCharsize()*0.7
endfor



if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048
set_plot,'x'
endif else begin
;im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endelse
endfor


endfor




end
