
nbeg=0
nend=0
 ppgetlast, nend
 nbeg=max( [0, nend-2])


cgdisplay,xs=1200, ys=1250
pos=cglayout([1,4] , OXMargin=[9,9], OYMargin=[5,6], XGap=9, YGap=12)

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
dptr[2]=ptr_new(p.p(*,2,1))
dptr[3]=ptr_new(p.p(*,2,3))
dptr[4]=ptr_new(p.p(*,2,0))
dptr[5]=ptr_new(p.p(*,2,2))
dptr[6]=ptr_new(f.ey(0,0,*))
dptr[7]=ptr_new(f.bx(0,0,*))


xptr[0]=ptr_new(x3)
xptr[1]=ptr_new(x3)
xptr[2]=ptr_new(p.r(*,2,1))
xptr[3]=ptr_new(p.r(*,2,3))
xptr[4]=ptr_new(p.r(*,2,0))
xptr[5]=ptr_new(p.r(*,2,2))
xptr[6]=ptr_new(x3)
xptr[7]=ptr_new(x3)



fname="fermi"+String(nfile, format='(I06)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.7
omega_str='!9W!X'
gamstr='!9g!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
gamstr='!7c!X'
charsize=cgdefcharsize()*.6
endelse

xb=0
xe=f.s.gn[2]


tistr[0]='t='+string(nfile, format='(I4)')+ ', dens'
tistr[1]='ey'
tistr[2]='ion phase space, '+gamstr+'v!DZ!N-z'
tistr[3]='electron phase space, '+gamstr+'v!DZ!N-z'


cgerase
i=0
dat=*dptr(2*i)
xdat=*xptr(2*i)
cgplot,xdat, dat , pos=pos[*,i], /noerase, title=tistr[i], charsize=charsize
cgplot,*xptr(2*i+1), *dptr(2*i+1) , pos=pos[*,i],/overplot,  /noerase, color='blue'
i=1
dat=*dptr(6)
xdat=*xptr(6)
cgplot,xdat, dat , pos=pos[*,i], /noerase, title=tistr(i), charsize=charsize
for i=2,2 do begin
dat=*dptr(i)
xdat=*xptr(i)
ymax= max( dat )
ymin= min(  *dptr(i+1))
cgplot,xdat, dat , pos=pos[*,i], /noerase, psym=3, xrange=[xb,xe], yrange=[ymin,ymax], title=tistr(i), charsize=charsize
cgplot,*xptr(i+1), *dptr(i+1) , pos=pos[*,i], /overplot, psym=3, color='blue'
endfor
i=3
dat=*dptr(4)
xdat=*xptr(4)
ymax=max(dat)
dat2=*dptr(5)
ymin= min( dat2 )
cgplot,xdat, dat , pos=pos[*,i], /noerase, psym=3, xrange=[xb,xe], yrange=[ymin,ymax], title=tistr(i), charsize=charsize
cgplot,*xptr(4+1), *dptr(4+1) , pos=pos[*,i], /overplot, psym=3, color='blue'



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
