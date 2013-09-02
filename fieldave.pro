
readcol, "averages.dat", t,dt, rhoe, vx2, vy2, vz2, rhovx2, bxbx, byby , bzbz
omega=1.0
torbit=2*!PI/omega
tnorm=t/torbit

cgplot, tnorm,bzbz, /ylog, yrange=[1e-8,1e0], $
		title="growth of Bx By Bz", $
		xtitle="Time / T_orbit"
cgplot, tnorm,bxbx, /overplot
cgplot, tnorm,byby, /overplot
end
