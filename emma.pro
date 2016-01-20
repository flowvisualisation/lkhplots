
vjet=4e6
tlookback=3e8*110
distance=vjet*tlookback
au=1.49e13


dsource=59
arc=1*dsource
ljetarc=17
ljet=ljetarc*arc*au
year=3.15569e7

print, 'speed', vjet
print, 'dist', distance
print, 'distance[AU]', distance/au

print, 'distance to Upper Sco in parsec' , dsource
print, '1 arcsec subtends, ',arc, ' au at ' , dsource , ' parsec='
print, 'jet length [AU]', ljetarc*arc

print, 'jet length [cm]',ljet
print, 'jet lookback time [s]', ljet/vjet
print, 'jet lookback time [years]', ljet/vjet/year

lu=10*au
vu=1e5
tu=lu/vu
mp=1.6e-24
du=1e3*mp
print, ' LU', lu
print, ' VU', vu
print, ' TU', tu
print, ' TU [years]', tu/year
print, ' DU ' , du
print, ' rho' , 1e-3





end
