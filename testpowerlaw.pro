

nx=1000
x=findgen(nx)/nx*3.0+1

alpha=2.1
alpha=3.1
x2=x^(-alpha)
xmin=min(x)
px=((alpha-1)/xmin)*(x/xmin)^(-alpha)

cgplot, x, px, /xlog, /ylog
alphahat= 1+ nx * ( total( alog(px[0:nx-1]/xmin) ) )^(-1.0)
sig=(alphahat-1)/sqrt(nx)
print, 'alpha', alpha 
print, 'index', alphahat, ',  std dev', sig

end
