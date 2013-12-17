
cgloadct,33
nlast=99
nstep=1
for nfile=0,nlast,nstep do begin
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
; if file doesn't exzists exit

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
!p.multi=[0,3,6]

for i=0,17 do begin
r=*dataptr(i)
d=scale_vector(r,1,254)
cgloadct,33
cgimage, r
 XYOUTS, !X.Window[0] + 0.2 * (!X.Window[1]-!X.Window[0]), $
           !Y.Window[1] - 0.2 * (!Y.Window[1]-!Y.Window[0]), $
           titlestr(i), /Normal, charsize=2, color=cgcolor('white')
endfor


endfor
!p.multi=0
end
