
; mass in g
mstar=2.8e33
; r in cm
rstar=1e6
r0=2.86*rstar
v0=8.1e9 


t0=r0/v0

bsurf=1e8

Rconst=8.314e7
b0=bsurf*(rstar/r0)^3
rho0=b0^2/v0^2
p0=rho0*v0^2
temp0=p0/Rconst/rho0
mdot=rho0*v0*r0^2
eflux=rho0*v0^3*r0^2

print, 'r0', r0
print, 'v0', v0
print, 't0', t0
print, 'b0', b0
print, 'rho0', rho0
print, 'p0', p0
print, 'temp0', temp0
print, 'mdot', mdot
print, 'eflux', eflux
mdot=1
eflux=1


end
