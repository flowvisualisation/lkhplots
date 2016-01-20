
;pro phasespace, x,p,arr
getpplast, nend
p=rp(nend)
typepar=0
x=p.r(*,2,typepar)
p=p.p(*,2,typepar)

ns1=size(x, /dimensions)
ns=ns1(0)


maxx=max(x)
minx=min(x)


maxp=max(p)
minp=min(p)
;minp=-max(p)


np=1024
nx=1024


arr=fltarr(nx,np)
arr(*,*)=0.0

for i=0,ns-1 do begin
posx=(x(i)-minx) /(maxx-minx)*nx
posp=(p(i)-minp) /(maxp-minp)*np

px=long (posx)
pp=long (posp)

if ( px gt nx-1) then begin
px=nx-1
endif
if ( pp gt np-1) then begin
pp=np-1
endif
if ( pp lt 0) then begin
pp=0
endif
arr[px,pp] +=  1
endfor

cgloadct,33
tvlct,255,255,255,0

xx=findgen(nx)/nx*(maxx-minx)+minx
yy=findgen(np)/np*(maxp-minp)+minp

display, arr,x1=xx,x2=yy, ims=[1600,600]

end
