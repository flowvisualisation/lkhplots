

nstart=44
nend=44
nstep=2

sfile = 0
pfile = 0
sfile = FILE_TEST('v0044.vtk')
pfile = FILE_TEST('data.0000.dbl')
print, sfile, pfile
code='snoopy'
if (pfile eq 1 ) then begin
code='pluto'
endif

vshear=1.0
for nfile=nstart,nend,nstep do begin



case code OF 
'pluto': begin
pload,0
plutoread, dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
time=time/2/!DPI
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

invii=fltarr(nx,nz)
inviii=fltarr(nx,nz)



for i=0,nx-1 do begin
for k=0,nz-1 do begin

u1=0.0d
u2=0.0d
u3=0.0d
reyave=dblarr(3,3)
reyave(*,*)=0.0d

for j=0,ny-1 do begin
    dens=rho(i,j,k)
    u1=bx(i,j,k)
    u2=by(i,j,k)
    u3=bz(i,j,k)
    a=[u1,u2,u3]
    rey=a#a
 reyave=reyave+rey
    endfor
    reyave=reyave/ny

 reystressanisotropytensor,  reyave,reyanis


eigenvalues = EIGENQL(reyanis)

l1=eigenvalues(0)
l2=eigenvalues(1)
l3=eigenvalues(2)
c1c=l1-l2
c2c=2*(l2-l3)
c3c=3*l3+1
x1c=0.0
y1c=1.734
x2c=1.0
y2c=0.0
x3c=-1.0
y3c=0.0
xn=c1c*x1c+ c2c*x2c +c3c*x3c
yn=c1c*y1c+ c2c*y2c +c3c*y3c


invii(i,k)=xn
inviii(i,k)=yn

;print, trace(rey)^2-trace(rey^2), det

;print, invii(i,j,k)
;print, rey(0,0), trace(rey^2), determ(rey)

endfor
endfor

print, mean(-invii, /double), mean(inviii, /double), format='(F27.24,  F27.24)'
;print, min(-invii), min(inviii)

;pdf=histogram(invii, locations=xbin,binsize=0.001) 
;cgplot, xbin, pdf    

;cgplot, inviii, -invii, psym=2
tag="banerjee"
tag2="y-ave Reynolds"
;histbaner3, invii, inviii, nfile, tag, tag2, time

 nx=201
 ny=100
 
 mx1=x2c*1.0
 mn1=x3c*1.0
 mx2=y1c
 mn2=x1c

 bn1=(mx1-mn1)/nx
 bn2=(mx2-mn2)/ny

    print, mn1,mx1,mn2,mx2, bn1, bn2
 r=hist_2d(reform(invii),reform(inviii), min1=mn1, max1=mx1, min2=mn2, max2=mx2, bin1=bn1, bin2=bn2 )
 xaxis=findgen(nx+1)/nx*2-1
 yaxis=findgen(ny+1)/ny* y1c
 help,r, xaxis, yaxis



l1=.66
l2=-.33
l3=-.33
qme=barycentric ( l1, l2, l3, x1a, y1a)
l1=0.5-0.33
l2=0.5-0.33
l3=-.33
qme=barycentric ( l1, l2, l3, x2a, y2a)
l1=0
l2=0
l3=0
qme=barycentric ( l1, l2, l3, x3, y3)

xs=1000
ys=867

cgdisplay, xs=xs,ys=ys
cgloadct,33


fname="bary"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet,font=1
charsize=cgdefcharsize()*0.9
pi_str='!9p!X'
endif else  begin
set_plot, 'x'
charsize=cgdefcharsize()*1.1
pi_str='!7p!X'
endelse


 ;display,/hbar, ims=[1000,850], smooth(r,10), x1=xaxis, x2=yaxis
posx=[.1,.1,.9,.9]
cgloadct,33
tvlct, 255,255,255,0
 cgimage, cgscalevector(smooth(r,10),0,254), pos=posx
 cgcontour, r, xaxis, yaxis,  /noerase, /nodata, pos=posx
 cgloadct,0
cgplots, x1a,y1a, psym=4, color='black'
cgtext, x1a+.1, y1a-.1, '1D'
cgplots, x2a,y2a, psym=4
cgtext, x2a-0.2, y2a+0.1, '2D'
cgplots, x3,y3, psym=4
cgtext, x3+0.1, y3+0.1, '3D'
x1=xaxis
x2=yaxis
cgplot, x1,  1.74*x1+1.74, /overplot
cgplot, x1,  -1.74*x1+1.74, /overplot





if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100
endif else begin
endelse

endfor





idstr=['invii','inviii']
h5_2darr, invii, inviii, tag+string(nfile, format='(I04)'), idstr 


endfor




end
