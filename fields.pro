
nbeg=0
nend=0
 ppgetlast, nend
; nend=1
nbeg=0
nend=0
 ppgetlast, nend
 nbeg=max( [0, nend-2])




cgdisplay,xs=1200, ys=1250
pos=cglayout([1,8] , OXMargin=[9,9], OYMargin=[5,6], XGap=9, YGap=1)

nel=12
dptr  =ptrarr(nel)
xptr  =ptrarr(nel)
tistr =strarr(nel)

for nfile=nbeg,nend do begin
f=rf(nfile)
p=rp(nfile)
nz = f.s.gn[2]
x3=findgen(nz)

dptr[0]=ptr_new(f.d(0,0,*,0))
dptr[1]=ptr_new(f.d(0,0,*,2))
dptr[2]=ptr_new(f.bx(0,0,*))
dptr[3]=ptr_new(f.by(0,0,*))
dptr[4]=ptr_new(f.bz(0,0,*))
dptr[5]=ptr_new(f.ex(0,0,*))
dptr[6]=ptr_new(f.ey(0,0,*))
dptr[7]=ptr_new(f.ez(0,0,*))


xptr[0]=ptr_new(x3)
xptr[1]=ptr_new(x3)
xptr[2]=ptr_new(x3)
xptr[3]=ptr_new(x3)
xptr[4]=ptr_new(x3)
xptr[5]=ptr_new(x3)
xptr[6]=ptr_new(x3)
xptr[7]=ptr_new(x3)


tistr[0]='t='+string(nfile, format='(I4)')+ ', dens'
tistr[1]='dens'
tistr[2]='bx'
tistr[3]='by'
tistr[4]='bz'
tistr[5]='ex'
tistr[6]='ey'
tistr[7]='ez'


fname="fields"+String(nfile, format='(I06)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*.6
endelse

xb=0
xe=f.s.gn[2]



cgerase

for i=0,7 do begin
dat=*dptr(i)
xdat=*xptr(i)
cgplot,xdat, dat , pos=pos[*,i], /noerase,  xrange=[xb,xe], ytitle=tistr(i)
endfor



if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



endfor

end
