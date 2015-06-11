cgdisplay, xs=1600, ys=800


nstart=1
nend=639
nstep=1

sfile = 0
pfile = 0
sfile = FILE_TEST('v0000.vtk')
pfile = FILE_TEST('data.0000.dbl')
print, sfile, pfile
code='snoopy'
if (pfile eq 1 ) then begin
code='pluto'
endif
nfile = FILE_TEST('usr000000.h5')
if (nfile eq 1 ) then begin
code='nirvana'
nstart=10000
nend=20000
nstep=2000
endif



vshear=1.0
for nfile=nstart,nend,nstep do begin



case code OF 
'nirvana': begin
nirvanaread, rho, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
sbq=1.5
sbomega=1
sba=-0.5*sbq*sbomega
vsh=2*sba
vshear=vsh*xx3d
vy=vy-vshear
end
'pluto': begin
pload,0,/silent
plutoread, dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
sbq=1.5
sbomega=1
sba=-0.5*sbq*sbomega
vsh=2*sba
vshear=vsh*xx3d
vy=vy-vshear
end
'snoopy':begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
sbq=1.5
sbomega=1
sba=-0.5*sbq*sbomega
vsh=2*sba
vshear=vsh*xx3d
;vy=vy+vshear
rho=vshear
rho(*,*,*)=1.0
end
end

kstart=nz*0.75
kend=nz-1
invii=fltarr(nx,nz)
inviii=fltarr(nx,nz)



for i=0,nx-1 do begin
for k=kstart,kend do begin

u1=0.0d
u2=0.0d
u3=0.0d
reyave=dblarr(3,3)
reyave(*,*)=0.0d

for j=0,ny-1 do begin
    dens=rho(i,j,k)
    u1=vx(i,j,k)
    u2=vy(i,j,k)
    u3=vz(i,j,k)
    a=[u1,u2,u3]
    rey=dens*(a#a)
 reyave=reyave+rey
    endfor

 reystressanisotropytensor,  reyave,reyanis


invariants, reyanis, traa, det
invii(i,k)=traa
inviii(i,k)=determ(reyanis)

;print, trace(rey)^2-trace(rey^2), det

;print, invii(i,j,k)
;print, rey(0,0), trace(rey^2), determ(rey)

endfor
endfor

;print, mean(-invii, /double), mean(inviii, /double), format='(F27.24,  F27.24)'


find2nd=-invii

index = where(find2nd eq min(find2nd))
minimum_first=find2nd[index]

find2nd[index]=1e6

print, min(find2nd)



;print, min(-invii), min(inviii)

;pdf=histogram(invii, locations=xbin,binsize=0.001) 
;cgplot, xbin, pdf    

;print, min(abs(invii))
;cgplot, inviii, -invii, psym=2
tag="lumley2dy_h1"
tag2="Reynolds h1"
histlumley3, invii, inviii, nfile, tag, tag2, time


idstr=['invii','inviii']
;h5_2darr, invii, inviii, tag+string(nfile, format='(I04)'), idstr 


endfor


r=rey

detr= r(0,0)*(r(1,1)*r(2,2)-r(1,2)*r(2,1))- r(0,1)*(r(1,0)*r(2,2)-r(1,2)*r(2,0))+ r(0,2)*(r(1,0)*r(2,1)-r(1,1)*r(2,0))

end
