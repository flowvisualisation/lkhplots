
ramp=prs+rho*(vx1^2+ vx2^2 + vx3^2)
ramp=rho*(vx1^2+ vx2^2 + vx3^2)
b2=(bx1^2+ bx2^2 + bx3^2)/2.0;/8.0/!DPI

rat=ramp/b2
cgplot, x1, rat[*,nx2-1], xrange=[min(x1),1.1]




end
