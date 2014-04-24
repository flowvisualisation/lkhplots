

t=findgen(800)/100.

mri=2.5e-1 * exp(0.75 *t)

tnorm=t(*)-6
parasite=2.5e-1* exp(mri*tnorm)

cgplot, t, mri, /ylog
cgplot, t, parasite, /overplot

end
