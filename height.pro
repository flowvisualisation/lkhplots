!EXCEPT=0

pistr='!9p!X'
;cgdisplay, xs=1500,ys=600
cgdisplay, xs=800,ys=300

nbeg=58000L
nend=322000L
nstep=2000
;nfile=322000L

nslice=225
grd_ctl,g,c, model=1000L*(nslice-3)
x1=findgen(nslice)/nslice*c.time/2./!DPI

h1=fltarr(nslice)
h2=fltarr(nslice)
spawn, 'basename $PWD', dirname
dirtag=strmid(dirname,18,6) & print, dirtag

for myq=38, nslice-2, 1 do begin
nfile=myq*2000L
;if ( firstcall eq !NULL ) then begin 


varfile='usr'+string(nfile, format='(I06)')+'.h5'
if (  file_test(varfile)  ne 1 ) then begin
print , "File does not exist! You fiend!  ... exiting"
break
endif
d=h5_read(nfile,/rho,  /B, /remap)
grd_ctl,g,c, model=nfile
bx1=transpose(reform(d.b[2,*,*,*]))
bx2=transpose(reform(d.b[1,*,*,*]))
bx3=transpose(reform(d.b[0,*,*,*]))
;d=h5_read(0,/rho)
rho=transpose(reform(d.rho[*,*,*]))
;firstcall=1
;endif

b2=bx1^2+bx2^2+bx3^2

pmag=b2/8e-7/!DPI
pres=rho^(5./3.)
pbeta=pres/pmag
betaave=total(pbeta,1)/g.nx
betaave=total(betaave,1)/g.ny

a=where( betaave[0:g.nz/2]  gt 1)
b=where( betaave[g.nz/2:g.nz-1]  lt 1)

print, a(0), g.nz/2+b(0)
db=a(0)
dt=g.nz/2+b(0)
;print, 

fdge=+0
dqb=(db)-fdge

dqt=(dt)+fdge

print, dqb,dqt
print, g.z(dqb), g.z(dqt)
h1(myq)=g.z(dqb)
h2(myq)=g.z(dqt)

cgplot,x1, h1, yrange=[-4,4]
cgplot, x1, h2, /overplot

endfor



ttag=string(nfile, format='(I08)')
fname="${HOME}/Documents/results/"+dirname+"/"+"height"+dirtag+ttag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
omega_str='!9W!X'
pistr='!9p!X'
!p.charsize=1.0
charsize=cgdefcharsize()
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
pistr='!7q!X'
!p.charsize=1.5
charsize=cgdefcharsize()
endelse


cgplot,x1, h1, yrange=[-4,4]
cgplot,x1, h2, /overplot



if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1900, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor

h5name="${HOME}/Documents/results/"+dirname+"/"+"mydata"
h5_2darr, h1, h2, h5name, ["h1","h2"]


end
