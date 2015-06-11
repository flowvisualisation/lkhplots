
usingps=0
items=['v1','v2', 'v3', 'b1', 'b2', 'b3','growth=0.75' ]
linestyles=[0,0,0,3,2,2,1]
psym=[0,1,2,3,4,5,6]
colors=['red', 'blue', 'green', 'orange', 'turquoise', 'purple', 'black']

fname="growthrates"

v1arr=fltarr(1)
v2arr=fltarr(1)
v3arr=fltarr(1)
b1arr=fltarr(1)
b2arr=fltarr(1)
b3arr=fltarr(1)
tarr=fltarr(1)

nfile=0
pluto=0
if  ( pluto eq 1 ) then begin
pload,nfile
mx=nx1
my=nx2
mz=nx3
v1=vx1
v2=vx2
v3=vx3
b1=bx1
b2=bx2
b3=bx3
endif else  begin
path='data/proc0/'
varfile='VAR'+str(nfile)
if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
endif
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
v1=f0.uu[*,*,*,0]
v2=f0.uu[*,*,*,1]
v3=f0.uu[*,*,*,2]
b1=f0.bb[*,*,*,0]
b2=f0.bb[*,*,*,1]
b3=f0.bb[*,*,*,2]
endelse
v1arr(0)=max(abs(v1))
v2arr(0)=max(abs(v2))
v3arr(0)=max(abs(v3))
b1arr(0)=max(abs(b1))
b2arr(0)=max(abs(b2))
b3arr(0)=max(abs(b3))
cgloadct,33
nlast=99
nstep=1
for nfile=0,nlast,nstep do begin


ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
    fname="growthrates"+zero+nts
print, 'plot',nfile


pluto=0
if  ( pluto eq 1 ) then begin
pload,nfile
mx=nx1
my=nx2
mz=nx3
v1=vx1
v2=vx2
v3=vx3
b1=bx1
b2=bx2
b3=bx3
endif else  begin
path='data/proc0/'
varfile='VAR'+str(nfile)
if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
break
endif
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
v1=f0.uu[*,*,*,0]
v2=f0.uu[*,*,*,1]
v3=f0.uu[*,*,*,2]
b1=f0.bb[*,*,*,0]
b2=f0.bb[*,*,*,1]
b3=f0.bb[*,*,*,2]
endelse


dataptr=ptrarr(18)
titlestr=strarr(30,18)

titlestr(0)='V!DX!N(x,y)'
titlestr(1)='V!DX!N(x,z)'
titlestr(2)='V!DX!N(y,z)'
titlestr(3)='V!DY!N(x,y)'
titlestr(4)='V!DY!N(x,z)'
titlestr(5)='V!DY!N(y,z)'
titlestr(6)='V!DZ!N(x,y)'
titlestr(7)='V!DZ!N(x,z)'
titlestr(8)='V!DZ!N(y,z)'


titlestr(9)='B!DX!N(x,y)'
titlestr(10)='B!DX!N(x,z)'
titlestr(11)='B!DX!N(y,z)'
titlestr(12)='B!DY!N(x,y)'
titlestr(13)='B!DY!N(x,z)'
titlestr(14)='B!DY!N(y,z)'
titlestr(15)='B!DZ!N(x,y)'
titlestr(16)='B!DZ!N(x,z)'
titlestr(17)='B!DZ!N(y,z)'

dataptr(0)=ptr_new(reform(v1(*,*,mz/2)))
dataptr(1)=ptr_new(reform(v1(*,my/2,*)))
dataptr(2)=ptr_new(reform(v1(mx/2,*,*)))
dataptr(3)=ptr_new(reform(v2(*,*,mz/2)))
dataptr(4)=ptr_new(reform(v2(*,my/2,*)))
dataptr(5)=ptr_new(reform(v2(mx/2,*,*)))
dataptr(6)=ptr_new(reform(v3(*,*,mz/2)))
dataptr(7)=ptr_new(reform(v3(*,my/2,*)))
dataptr(8)=ptr_new(reform(v3(mx/2,*,*)))

dataptr(9)=ptr_new(reform(b1(*,*,mz/2)))
dataptr(10)=ptr_new(reform(b1(*,my/2,*)))
dataptr(11)=ptr_new(reform(b1(mx/2,*,*)))
dataptr(12)=ptr_new(reform(b2(*,*,mz/2)))
dataptr(13)=ptr_new(reform(b2(*,my/2,*)))
dataptr(14)=ptr_new(reform(b2(mx/2,*,*)))
dataptr(15)=ptr_new(reform(b3(*,*,mz/2)))
dataptr(16)=ptr_new(reform(b3(*,my/2,*)))
dataptr(17)=ptr_new(reform(b3(mx/2,*,*)))

!p.position=0

v1arr=[v1arr, max(abs(v1))]
v2arr=[v2arr, max(abs(v2))]
v3arr=[v3arr, max(abs(v3))]
b1arr=[b1arr, max(abs(b1))]
b2arr=[b2arr, max(abs(b2))]
b3arr=[b3arr, max(abs(b3))]

maxall=max([ [v1arr], [v2arr], [v3arr], [b1arr], [b2arr], [b3arr]])
dt=1
tarr=[tarr, nfile*dt]

cgplot, tarr,  v1arr, color=colors[0], linestyle=linestyles[0],  yrange=[1e-4*max(maxall), max(maxall)], /ylog
cgplot, tarr,  v2arr, /overplot,color=colors[1], linestyle=linestyles[1]
cgplot, tarr,  v3arr, /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, tarr,  b1arr, /overplot,color=colors[3], linestyle=linestyles[3]
cgplot, tarr,  b2arr, /overplot,color=colors[4], linestyle=linestyles[4]
cgplot, tarr,  b3arr, /overplot,color=colors[5], linestyle=linestyles[5]
cgplot, tarr,  v1arr[0]*exp(0.75*tarr), /overplot
fit=v1arr[0]*exp(0.75*tarr)

	al_legend, items, colors=colors, linestyle=linestyles

if ( nfile gt 20) then begin
print, (alog(fit[20])- alog(fit[10]) )/(tarr[20]-tarr[10])
print, (alog(v1arr[20])- alog(v1arr[10]) )/(tarr[20]-tarr[10])

endif

if ( usingps ) then begin
device,/close
set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse




endfor
!p.multi=0
end
