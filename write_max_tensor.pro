


nfile=1
nend=2000
nstart=1100
nend=nstart
nend=1170
nstart=1
nend=152
nstart=0
nend=68
inviiarr=fltarr(nend)
inviiiarr=fltarr(nend)

vshear=1.0
for nfile=nstart,nend do begin


code='pluto'
;code='snoopy'
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

ndown=4
invii=fltarr(nx/ndown,ny/ndown,nz/ndown)
inviii=fltarr(nx/ndown,ny/ndown,nz/ndown)

invii(*,*,*)=0
rey1=invii
rey2=invii
rey3=invii
rey4=invii
rey5=invii
rey6=invii
reyaveten=fltarr(nx/ndown,ny/ndown,nz/ndown,6)



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
    u1=u1+bx(ii,jj,kk)
    u2=u2+by(ii,jj,kk)
    u3=u3+bz(ii,jj,kk)
    a=[u1,u2,u3]
    rey=a#a
 reyave=reyave+rey
    endfor
    endfor
    endfor


 reystressanisotropytensor,  reyave,reyanis


rey1(i/ndown,j/ndown,k/ndown)=reyanis(0,0)
rey2(i/ndown,j/ndown,k/ndown)=reyanis(0,1)
rey3(i/ndown,j/ndown,k/ndown)=reyanis(0,2)
rey4(i/ndown,j/ndown,k/ndown)=reyanis(1,1)
rey5(i/ndown,j/ndown,k/ndown)=reyanis(1,2)
rey6(i/ndown,j/ndown,k/ndown)=reyanis(2,2)

reyaveten(i/ndown,j/ndown,k/ndown,0)=reyave(0,0)
reyaveten(i/ndown,j/ndown,k/ndown,1)=reyave(0,1)
reyaveten(i/ndown,j/ndown,k/ndown,2)=reyave(0,2)
reyaveten(i/ndown,j/ndown,k/ndown,3)=reyave(1,1)
reyaveten(i/ndown,j/ndown,k/ndown,4)=reyave(1,2)
reyaveten(i/ndown,j/ndown,k/ndown,5)=reyave(2,2)
  


;invariants, reyanis, traa, det
;invii(i/ndown,j/ndown,k/ndown)=traa
;inviii(i/ndown,j/ndown,k/ndown)=determ(reyanis)

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
;histlumley2, invii,inviii, nfile, tag, tag2, time


    tag="maxanis"
 write_rey, nfile,tag,rey1, rey2, rey3, rey4, rey5, rey6
 ;write_rey, nfile,tag,reyaveten[*,*,*,0], reyaveten[*,*,*,1], reyaveten[*,*,*,2], reyaveten[*,*,*,3], reyaveten[*,*,*,4], reyaveten[*,*,*,5]


endfor


r=rey

detr= r(0,0)*(r(1,1)*r(2,2)-r(1,2)*r(2,1))- r(0,1)*(r(1,0)*r(2,2)-r(1,2)*r(2,0))+ r(0,2)*(r(1,0)*r(2,1)-r(1,1)*r(2,0))

end
