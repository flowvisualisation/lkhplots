
nx=1e4
rho=findgen(nx)/nx
rho0=exp(-3)
cw=.1
cs0=.1
cs1=.2

dpdrho= ((cs1-cs0)*(1-tanh( (alog10(rho)  -alog10(rho0 )) /cw )  ) +cs0)^2

cgplot, rho,dpdrho, /xlog, xrange=[1./nx,1]
end
