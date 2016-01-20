

nr=64
nth=nr
nph=nr
rmax=5.0
rmin=0.35
r1d=findgen(nr)/nr*(rmax-rmin)+rmin
th1d=findgen(nth)/nth*(!DPI*.999)+0.001*!DPI
ph1d=findgen(nth)/nth*(2*!DPI)-!DPI

r2d =rebin(reform(r1d, nr, 1),nr,nth)
th2d=rebin(reform(th1d,  1,nth),nr,nth)

r3d =rebin(reform(r1d , nr,  1,  1),nr,nth,nph)
th3d=rebin(reform(th1d,  1,nth,  1),nr,nth,nph)
ph3d=rebin(reform(ph1d,  1,  1,nph),nr,nth,nph)

x=r3d*sin(th3d)*cos(ph3d)
y=r3d*sin(th3d)*sin(ph3d)
z=r3d*cos(th3d)

;alp=!PI/4.
alp=0

xd=x 
yd=y*cos(alp) - z*sin(alp)
zd=y*sin(alp) + z*cos(alp)

rd =r3d
thd=acos(zd/rd)
phd=atan(yd,xd)



bmag=0.1
br = 2*bmag*cos(th3d)/r3d^3 
bth=   bmag*sin(th3d)/r3d^3 

x3d=r3d*sin(th3d)*cos(ph3d)+cos (th3d) * cos (ph3d)*th3d - sin(ph3d) *ph3d
y3d=r3d*sin(th3d)*sin(ph3d)+cos (th3d) * sin (ph3d)*th3d + cos(ph3d) *ph3d
z3d=r3d*cos(th3d)-sin(th3d)*ph3d

cgloadct,33


rho=fltarr(nr,nth, nph)
vx1=fltarr(nr,nth, nph)
vx2=fltarr(nr,nth, nph)
vx3=fltarr(nr,nth, nph)
bph=fltarr(nr,nth, nph)
prs=fltarr(nr,nth, nph)

vx1(*,*,*)=0
vx2(*,*,*)=0
vx3(*,*,*)=0

rc3d=r3d*sin(th3d)
rcd=rd*sin(thd)
prs=rd
vphi=rc3d^(-1./2.)

;vphi [ where( vphi gt 1 )] =1


vx= - sin(ph3d)*vphi
vy=   cos(ph3d)*vphi
vz=0 

rd=sqrt(xd^2+yd^2+zd^2)
vx= rd^(-0.5) * sin(phd)
vy= rd^(-0.5) * cos(phd)
vz= 0 

vxd=vx
vyd=vy*cos(alp) - vz*sin(alp)
vzd=vy*sin(alp) + vz*cos(alp)
;vxd=vx
;vyd=vy
;vzd=vz


xy2=xd^2+yd^2
sxy2=sqrt(xy2)
vrd= (xd*vxd + yd*vyd + zd*vzd)/rd
vthd= (xd*zd*vxd + yd*zd*vyd - xy2*vzd)/rd/sxy2
vphd= (-yd*vxd+ xd*vyd)/sxy2

vx1=vrd
vx2=vthd
vx3=vphd
;xxx

bph(*,*,*)=0

d0a=1e-1
rho=d0a*r3d^(-3./2.)


for i=0,nr-1 do begin
for j=0,nth-1 do begin
for k=0,nph-1 do begin
 if ( rc3d[i,j,k] le 1 ) then begin
 vx3[i,j,k]=1.
 endif

if (( thd[i,j,k] ge !DPI*9./20. ) and (thd[i,j,k] le !DPI*11./20.) ) then begin
p0d=0.1
d0d=1.
eps=0.1
gmm=5./3.
rs=r1d[i]
rc=rs*sin(thd[i,j,k])
    subk=1-eps*eps*gmm/(gmm-1);
    scrh=(1/rs-subk/rc)*(gmm-1)/gmm/p0d;
    ddisk=d0d*max([scrh,0.])^(1.5)
rho[i,j,k]=ddisk
endif

endfor
endfor
endfor

nx1=nr
nx2=nth
nx3=nph
x1=r1d
x2=th1d
x3=ph1d
bx1=br
bx2=bth
bx3=bph

cartconv, rho, bx1,bx2,bx3,vx1,vx2,vx3,prs, x1,x2,x3, nx1,nx2,nx3, b1,b2,b3, den, v1,v2,v3, pr, rmax, rmin, nx


;v1r=v1
;v2r=v2*cos(alp)-v3*sin(alp)
;v3r=v2*sin(alp)+v3*cos(alp)

;v1[50,50,*]=0
;v2[50,50,*]=0
ke=v1^2+v2^2+v3^2

xs=1300
ys=xs
cgdisplay, xs=xs, ys=ys
datarr=ptrarr(9)
datarr[0]=ptr_new(reform(alog10(den(*,*,nx/2))))
datarr[1]=ptr_new(reform(alog10(den(*,nx/2,*))))
datarr[2]=ptr_new(reform(alog10(den( nx/2,*,*))))
datarr[0]=ptr_new(reform(v3(*,*, nx/2)))
datarr[1]=ptr_new(reform(v3(*,nx/2,*)))
datarr[2]=ptr_new(reform(v3(nx/2,*,*)))
datarr[3]=ptr_new(reform(v1(*,*, nx/2)))
datarr[4]=ptr_new(reform(v1(*,nx/2,*)))
datarr[5]=ptr_new(reform(v1(nx/2,*,*)))
datarr[6]=ptr_new(reform(v2(*,*, nx/2)))
datarr[7]=ptr_new(reform(v2(*,nx/2,*)))
datarr[8]=ptr_new(reform(v2(nx/2,*,*)))

titstr=strarr(9)
titstr[0]='den'
titstr[1]='den'
titstr[2]='den'
titstr[3]='v1'
titstr[4]='v1'
titstr[5]='v1'
titstr[6]='v2'
titstr[7]='v2'
titstr[8]='v2'

xtitstr=strarr(9)
xtitstr[0]='x'
xtitstr[1]='x'
xtitstr[2]='y'
xtitstr[3]='x'
xtitstr[4]='x'
xtitstr[5]='y'
xtitstr[6]='x'
xtitstr[7]='x'
xtitstr[8]='y'
ytitstr=strarr(9)
ytitstr[0]='y'
ytitstr[1]='z'
ytitstr[2]='z'
ytitstr[3]='y'
ytitstr[4]='z'
ytitstr[5]='z'
ytitstr[6]='y'
ytitstr[7]='z'
ytitstr[8]='z'

pos=cglayout([3,3])
for i=0,8 do begin
dat=*datarr[i]
r=cgscalevector(dat,1,254)
cgimage, r, pos=pos[*,i], /noerase
cgcontour, r, /nodata, /noerase, pos=pos[*,i], $
    title=titstr[i], $
    xtitle=xtitstr[i], $
    ytitle=ytitstr[i]
endfor


tag="idltst"
nfile=0
g=plutovtk( tag, nfile, alog10(den), v1,v2,v3,b1,b2,b3,pr)


im=cgsnapshot(filename='tiltdisk', /jpg, /nodialog)

end

