pro vizflow3d, vx,vy,vz
vx = RANDOMU(seed, 5, 5, 5) 
vy = RANDOMU(seed, 5, 5, 5) 
vz = RANDOMU(seed, 5, 5, 5) 

; Set up the 3D scaling system: 
cgSurf, dist(30), xr=[-1,5], yr=[-1,5], zr = [-1,5], $ 
   /nodata, xst=1, yst=1 

; Plot the vector field: 
!P.Color=cgColor('black') 
FLOW3, vx, vy, vz 
end
