
nx=960
ny=nx
kx=dindgen(nx)-nx/2
ky=kx

kx2d=rebin(reform(kx,nx,1),nx,ny)
ky2d=rebin(reform(ky,1,ny),nx,ny)

k= [[[ kx2d]] , [[ ky2d]] ]


help,k

th=!DPI/4.d
th=-1.37331
sy=6.70447
sx=3.07788

rotm=[  [cos(th) , -sin(th)] ,[sin(th), cos(th)] ]





help,rotm

g=dblarr(nx,ny)
cov= [ [sx^2, 0 ],  [0, sy^2] ]
icov=invert(cov)

for i=0,nx-1 do begin
for j=0,ny-1 do begin

km=reform(k[i,j,*] )

rot1=rotm#km
;g[i,j]= exp(-transpose(rot1)#icov#rot1)
g[i,j]= 1/(1+(transpose(rot1)#icov#rot1))

endfor
endfor

display,/hbar, ims=[800,800],x1=kx,x2=ky, alog10(g)



A=[0.000456099,0.768815,3.07788,6.70447,479.471,479.987,1.37331]
A[4]=0
A[5]=0
    u = ( (kx2d-A[4])/A[2] )^2 + ( (ky2d-A[5])/A[3] )^2 

    ;display, alog10(A[0] + A[1]/(u + 1) )

end
