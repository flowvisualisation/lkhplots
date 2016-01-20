
massrat=250.
c=1.
vb=0.63
vte=0.83*vb
vti=0.83*vb/sqrt(massrat)
wpe=1.
wpi=1./sqrt(massrat)
lsi=c/wpi
lse=c/wpe
print, 'c=',c
print, 'v_b=',vb
print, 'v_ti=',vti
print, 'v_te=',vte
print, 'w_pe=',wpe
print, 'w_pi=',wpi
print, 'electron skin depth', lse
print, 'ion skin depth', lsi
print, 'total skin depth', 1./sqrt(1./lsi^2 +1/lse^2)
print, 'electron debye length', vte/wpe
print, 'ion debye length', vti/wpi
print, 'L/ls,i', 3.2e4/lsi
end
