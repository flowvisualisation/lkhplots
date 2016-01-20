nx=100
;x2=findgen(nx)/nx*12-6


cs=1.0
h=sqrt(2.)


rho=exp(-x2^2/h^2/2)
by=sqrt(exp(-x2^2/h^2/2))

g=-x2
pr=cs^2*rho

cgplot,x2,  g*rho, color='blue'
cgplot,x2,   -(1+1)*rho *(-x2), /overplot



end
