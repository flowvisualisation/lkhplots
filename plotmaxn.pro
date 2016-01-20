

readcol, 'box.dat', time , xmom, ymom, zmom, magx, magy, magz, inten, kinx, kiny, kinz, magenx, mageny, magenz, Rey, Maxw, rmsrho, rmsp, artvisc, shearymom, shearkinen, totkinene, comprwork, thermalfluxx, thermalfluxy, thermalfluxz, normtemptau, Phix, Phiy, Phiz



cgplot, time, maxw, title='Maxwell ', /ylog, xtitle='time (orbits)'
end
