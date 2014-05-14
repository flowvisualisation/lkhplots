cgdisplay, xs=1600, ys=800


nfile=1
nend=2000
nstart=10
nend=nstart+1
nend=152
nstart=63
nend=69
nstep=1
inviiarr=fltarr(nend)
inviiiarr=fltarr(nend)

vshear=1.0
for nfile=nstart,nend, nstep do begin


code='pluto'
code='snoopy'
switch code OF 
'pluto': begin
pload,1
plutoread, dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
break;
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

invii=fltarr(nx/2,ny/2,nz/2)
inviii=fltarr(nx/2,ny/2,nz/2)

ndown=4


for i=0,nx-1,ndown do begin
for j=0,ny-1,ndown do begin
for k=0,nz-1,ndown do begin

u1=0.0d
u2=0.0d
u3=0.0d
reyave=dblarr(3,3)
reyave(*,*)=0.0d

for ii=i,i+ndown-1 do begin
for jj=j,j+ndown-1 do begin
for kk=k,k+ndown-1 do begin
    dens=rho(ii,jj,kk)
    u1=u1+vx(ii,jj,kk)
    u2=u2+vy(ii,jj,kk)
    u3=u3+vz(ii,jj,kk)
    a=[u1,u2,u3]
    rey=a#a
 reyave=reyave+rey
    endfor
    endfor
    endfor

 reystressanisotropytensor,  reyave,reyanis


invariants, reyanis, traa, det
invii(i/ndown,j/ndown,k/ndown)=traa
inviii(i/ndown,j/ndown,k/ndown)=determ(reyanis)

;print, trace(rey)^2-trace(rey^2), det

;print, invii(i,j,k)
;print, rey(0,0), trace(rey^2), determ(rey)

endfor
endfor
endfor

print, mean(-invii, /double), mean(inviii, /double), format='(F27.24,  F27.24)'
;print, min(-invii), min(inviii)

a= mean(-invii, /double)
b=mean(inviii, /double)
;pdf=histogram(invii, locations=xbin,binsize=0.001) 
;cgplot, xbin, pdf    

;cgplot, inviii, -invii, psym=2
tag="lumleyglobal_"
tag2="Reynolds"
histlumley3, invii,inviii, nfile, tag, tag2, time



endfor


r=rey

detr= r(0,0)*(r(1,1)*r(2,2)-r(1,2)*r(2,1))- r(0,1)*(r(1,0)*r(2,2)-r(1,2)*r(2,0))+ r(0,2)*(r(1,0)*r(2,1)-r(1,1)*r(2,0))

end
