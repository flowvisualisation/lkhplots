
layerno=2
window, xs=1200,ys=1200
usingps=0
pluto=0
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
if ( (pluto eq 0 )  and (file_test(path+varfile)  ne 1 )) then begin
print, varfile+' does not exist, exiting gm'
endif
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
rho=f0.rho[*,*]
v1=f0.uu[*,*,0]
v2=f0.uu[*,*,1]
v3=f0.uu[*,*,2]
b1=f0.bb[*,*,0]
b2=f0.bb[*,*,1]
b3=f0.bb[*,*,2]
a1=f0.aa[*,*,0]
a2=f0.aa[*,*,1]
a3=f0.aa[*,*,2]
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
scrh=max(v1)
xx3d=rebin(reform(x1,mx,  1,  1),mx,my,mz) 
zz3d=rebin(reform(x3,1,mz ), mx, mz )
vmri=scrh*sin(layerno*2*!PI*zz3d)
bmri=scrh*sqrt(5./3.)*cos(layerno*2*!PI*zz3d)
sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba
eps=1e-3
lx=2.0

vshear=vsh*xx3d
v2=v2-vshear
nend=nlast
endif else  begin

path='data/proc0/'
varfile='VAR'+str(nfile)
; if file doesn't exzists exit

if (file_test(path+varfile)  ne 1  ) then begin
print, varfile+' does not exist, exiting gm 2'
break
endif

pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
rho=f0.rho[*,*]
v1=f0.uu[*,*,0]
v2=f0.uu[*,*,1]
v3=f0.uu[*,*,2]
b1=f0.bb[*,*,0]
b2=f0.bb[*,*,1]
b3=f0.bb[*,*,2]
a1=f0.aa[*,*,0]
a2=f0.aa[*,*,1]
a3=f0.aa[*,*,2]
scrh=max(v1)
zz3d=rebin(reform(z[3:mz-4],1,mz-6 ), mx-6, mz-6 )
vmri=scrh*sin(layerno*2*!PI*zz3d)
bmri=scrh*sqrt(5./3.)*cos(layerno*2*!PI*zz3d)
endelse


v1arr(0)=max(v1)
v2arr(0)=max(v2)
v3arr(0)=max(v3)
b1arr(0)=max(b1)
b2arr(0)=max(b2)
b3arr(0)=max(b3)

dataptr=ptrarr(18)
titlestr=strarr(30,18)

titlestr(0)='V!DMRI!N'
titlestr(1)='V!DX!N(x,z)'
titlestr(2)='V!D1,ORIG!N'
titlestr(3)='DENSITY'
titlestr(4)='V!DY!N(x,z)'
titlestr(5)='V!DY!N(y,z)'
titlestr(6)='V!DZ!N(x,y)'
titlestr(7)='V!DZ!N(x,z)'
titlestr(8)='V!DZ!N(y,z)'


titlestr(9)='B!DMRI!N(x,y)'
titlestr(10)='B!DX!N(x,z)'
titlestr(11)='B!DX!N(y,z)'
titlestr(12)='B!DMRI!N(x,y)'
titlestr(13)='B!DY!N(x,z)'
titlestr(14)='B!DY!N(y,z)'
titlestr(15)='B!DZ!N(x,y)'
titlestr(16)='B!DZ!N(x,z)'
titlestr(17)='B!DZ!N(y,z)'


vx0=v1
vy0=v2
v1=v1-vmri
v2=v2-vmri
bx0=b1
by0=b2
b1=b1-bmri
b2=b2+bmri

;dataptr(0)=ptr_new(reform(v1(*,*,mz/2)))
dataptr(0)=ptr_new(reform(vmri(*,*)))
dataptr(1)=ptr_new(reform(v1(*,*)))
;dataptr(2)=ptr_new(reform(v1(mx/2,*,*)))
dataptr(2)=ptr_new(reform(vx0(*,*)))
dataptr(3)=ptr_new(reform(rho(*,*)))
dataptr(4)=ptr_new(reform(v2(*,*)))
dataptr(5)=ptr_new(reform(v2(*,*)))
dataptr(6)=ptr_new(reform(v3(*,*)))
dataptr(7)=ptr_new(reform(v3(*,*)))
dataptr(8)=ptr_new(reform(v3(*,*)))

dataptr(9)=ptr_new(reform(bmri(*,*)))
dataptr(10)=ptr_new(reform(b1(*,*)))
dataptr(11)=ptr_new(reform(a1(*,*)))
dataptr(12)=ptr_new(reform(-bmri(*,*)))
dataptr(13)=ptr_new(reform(b2(*,*)))
dataptr(14)=ptr_new(reform(a2(*,*)))
dataptr(15)=ptr_new(reform(b3(*,*)))
dataptr(16)=ptr_new(reform(b3(*,*)))
dataptr(17)=ptr_new(reform(a3(*,*)))

!p.position=0
!p.multi=[0,3,7]

v1arr=[v1arr, max(v1)]
v2arr=[v2arr, max(v2)]
v3arr=[v3arr, max(v3)]
b1arr=[b1arr, max(b1)]
b2arr=[b2arr, max(b2)]
b3arr=[b3arr, max(b3)]

maxall=max([ [v1arr], [v2arr], [v3arr], [b1arr], [b2arr], [b3arr]])
dt=0.1
tarr=[tarr, nfile*dt]
for i=0,17 do begin
r=*dataptr(i)
d=cgscalevector(r,1,254)
cgloadct,33
tag=string(max(r), format='(G9.2)')+" "+string(min(r), format='(G9.2)')
cgimage, d
 XYOUTS, !X.Window[0] + 0.2 * (!X.Window[1]-!X.Window[0]), $
           !Y.Window[1] - 0.2 * (!Y.Window[1]-!Y.Window[0]), $
           titlestr(i)+tag, /Normal, charsize=2, color=cgcolor('white')
endfor
cgplot, tarr,  v1arr, color=colors[0], linestyle=linestyles[0],  yrange=[1e-2*max(maxall), max(maxall)], /ylog
cgplot, tarr,  v2arr, /overplot,color=colors[1], linestyle=linestyles[1]
cgplot, tarr,  v3arr, /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, tarr,  b1arr, /overplot,color=colors[3], linestyle=linestyles[3]
cgplot, tarr,  b2arr, /overplot,color=colors[4], linestyle=linestyles[4]
cgplot, tarr,  b3arr, /overplot,color=colors[5], linestyle=linestyles[5]
cgplot, tarr,  v1arr[1]*exp(0.75*tarr), /overplot

	al_legend, items, colors=colors, linestyle=linestyles
cgplot,  v2arr
cgplot,  b1arr


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
