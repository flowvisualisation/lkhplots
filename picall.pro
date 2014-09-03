
cgdisplay, xs=1400,ys=1200
!p.position=0
for nfile=1,100,1 do begin

tag2=string(nfile, format='(I06)')
tag=tag2+'.dat'
varfile='fields-'+tag
path='Data/'

if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
break
endif
f=rf(nfile)
pos1 = cglayout([5,3] , OXMargin=[4,2], OYMargin=[9,2], XGap=1, YGap=4)

cgloadct,33

datptr=ptrarr(15)
datptr(0)=ptr_new(reform(f.v[*,0,*,0,0]))
datptr(1)=ptr_new(reform(f.v[*,0,*,1,0]))
datptr(2)=ptr_new(reform(f.v[*,0,*,2,0]))
datptr(3)=ptr_new(reform(alog10(abs(f.d[*,0,*,0])+1e-6)))
datptr(4)=ptr_new(reform(f.vth[*,0,*,0]))
datptr(5)=ptr_new(reform(f.v[*,0,*,0,1]))
datptr(6)=ptr_new(reform(f.v[*,0,*,1,1]))
datptr(7)=ptr_new(reform(f.v[*,0,*,2,1]))
datptr(8)=ptr_new(reform(alog10(abs(f.d[*,0,*,1])+1e-6)))
datptr(9)=ptr_new(reform(f.vth[*,0,*,1]))
datptr(10)=ptr_new(reform(f.ex[*,0,*]))
datptr(11)=ptr_new(reform(f.ey[*,0,*]))
datptr(12)=ptr_new(reform(f.ez[*,0,*]))
datptr(13)=ptr_new(reform(f.bx[*,0,*]))
datptr(14)=ptr_new(reform(f.bz[*,0,*]))

titstr=strarr(15)
titstr[0]="V!DE,X!N"
titstr[1]="V!DE,y!N"
titstr[2]="V!DE,z!N"
titstr[3]="rho!DE!N"
titstr[4]="V!DTH,E!N"
titstr[5]="V!DI,X!N"
titstr[6]="V!DI,Y!N"
titstr[7]="V!DI,Z!N"
titstr[8]="rho!DI!N"
titstr[9]="V!DTH,I!N"
titstr[10]="E!DX!N"
titstr[11]="E!DY!N"
titstr[12]="E!DZ!N"
titstr[13]="B!DX!N"
titstr[14]="B!DZ!N"



cgerase
for i=0,14 do begin

d=*datptr(i)
sz=size(d,/dimensions)
nx=sz(0)
ny=sz(1)

dx=0.1
x1=(findgen(nx)-nx/2)*dx
x2=(findgen(ny)-ny/2)*dx

pos=pos1[*,i]
r=cgscalevector(d,1,254)
cgloadct,33
cgimage,r, pos=pos, /noerase
imin=min(d)
imax=max(d)

xtickf="(a1)"
ytickf="(a1)"
if ( (i mod 5) eq 0 ) then begin
ytickf="(I5)"
endif
p2=pos[1]-0.02
p4=pos[1]-0.01
if ( i gt 9  ) then begin
xtickf="(I5)"
p2=pos[1]-0.04
p4=pos[1]-0.03
endif

cgcontour,dist(nx,ny),x1,x2, pos=pos, /noerase, /nodata , xtickf=xtickf,ytickf=ytickf
cgcolorbar, Position=[pos[0],p2 , pos[2], p4], range=[imin,imax], format='(G8.1)', charsize=cbarchar



cgtext, 0.75*x1(nx-1),0.75*x2(ny-1), titstr[i], charsize=1.9

if ( i eq 2) then begin
qq=17
u=congrid(reform(f.v[*,0,*,0,0]),qq,qq) 
v=congrid(reform(f.v[*,0,*,2,0]),qq,qq)
qx=congrid(x1,qq)
qy=congrid(x2,qq)
velovect, u,v ,qx,qy, color=cgcolor('black'), /overplot, pos=pos
endif

if ( i eq 12) then begin
qq=17
u=congrid(reform(f.ex[*,0,*]),qq,qq) 
v=congrid(reform(f.ez[*,0,*]),qq,qq)
qx=congrid(x1,qq)
qy=congrid(x2,qq)
velovect, u,v ,qx,qy, color=cgcolor('black'), /overplot, pos=pos
endif


endfor

cgtext, 0.2,0.01, "PIC simulation of rotating disk, t="+String(f.s.time, format='(F6.2)'), /normal,charsize=1.8

fname='disk'+tag2
im=cgsnapshot(filename=fname,/jpeg,/nodialog)
wait,1
endfor
!p.multi=0
end
