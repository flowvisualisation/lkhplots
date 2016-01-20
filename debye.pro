



eps=8.85e-12
kb=1.38e-23
te=0.7e3
de=1.e6
qe=1.6e-19
me=9.1e-31
mp=1836*me
b0=1e-4*1e-4
mu0=4*!DPI*1e-7

vth=sqrt(kb*te/me)
vj=10*vth
va=b0/sqrt(mu0*de*mp)


debye=sqrt(eps*kb*te/qe^2/de)
wp=sqrt(de*qe^2/me/eps)
print, 'wp  =' , wp  , ' s'
print, 'n0  =' , de  , ' m^-3'
print, 'vth =' , vth , ' m/s'
print, 'Debye length = ', vth/wp, 'm'

print, 'Magnetic field = ', b0, ' Tesla'
print, 'Alfven speed', va, ' m/s'
print, 'Jet speed', vj, ' m/s'

print, 'sonic mach', vj/vth
print, 'alfven mach', vj/va
end
