
pro s2u, d,p,vr,vz,vth, br,bz,bth , rho, pr, v1,v2,v3, b1,b2,b3,x1,x2,xa,xb, n1,n2

d=rho(0)
p=pr(0)
vr=v1(0)
vz=v2(0)
vth=v3(0)
br=b1(0)
bz=b2(0)
bth=b3(0)

xa=x1
xb=x2
regrid, d,xa,xb , n1=512,n2=1536
xa=x1
xb=x2
regrid, p,xa,xb, n1=512,n2=1536
xa=x1
xb=x2
regrid, vr,xa,xb, n1=512,n2=1536
xa=x1
xb=x2
regrid, vz,xa,xb, n1=512,n2=1536
xa=x1
xb=x2
regrid, vth,xa,xb , n1=512,n2=1536
xa=x1
xb=x2
regrid, br,xa,xb , n1=512,n2=1536
xa=x1
xb=x2
regrid, bz,xa,xb , n1=512,n2=1536
xa=x1
xb=x2
regrid, bth,xa,xb , n1=512,n2=1536

xa=findgen(512)/512 * x1(n1-1)
xb=findgen(1536)/1536 * x2(n2-1)


end
