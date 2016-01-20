
pload,0
ns=200

rmax=x1[nx1-1]
rmin=x1[0]
cartconv, rho, bx1,bx2,bx3,vx1,vx2,vx3,prs, x1,x2,x3, nx1,nx2,nx3, b1,b2,b3, den, v1,v2,v3, pr, rmax, rmin , ns   

tag="convplutdat"
nfile=0
g=plutovtk( tag, nfile, alog10(den), v1,v2,v3,b1,b2,b3,pr)


end
