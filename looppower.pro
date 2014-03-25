
cgdisplay, xs=1600, ys=800

titlarr=strarr(6)
titlarr(0)='vx'
titlarr(1)='vy'
titlarr(2)='vz'
titlarr(3)='bx'
titlarr(4)='by'
titlarr(5)='bz'
spec=fltarr(6,32)
wns=fltarr(6,32)

pos = cglayout([3,2] , OXMargin=[5,5], OYMargin=[5,7], XGap=3, YGap=7)
for nfile=1,150 do begin



code='pluto'
;code='snoopy'
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

for i=0,5 do begin
r=*datptr[i]
power3d, r, wavenumbers=wns_t, spectrum=spec_t, /noplot
spec(i,*)=spec_t
wns(i,*)=wns_t
endfor
cgerase
cgText, 0.5, 0.96, /Normal,  'PSD testing, t='+string(nfile), Alignment=0.5, Charsize=cgDefCharsize()*1.25
for i=0,5 do begin
cgplot, wns(i,*),spec(i,*), /xlog, /ylog, xrange=[1,100], title=titlarr(i), pos=pos(*,i), /noerase
endfor
fname="psd_"+string(nfile, format='(I04)')
im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endfor




end
