
nfile=0
for nfile=0,4 do begin
d=h5_read( nfile, /rho, /B,/T, /v)


grd_ctl,model=nfile, s

cgloadct,33

display,/hbar, ims=[800,800] , alog10(transpose(d.rho)), /polar, x1=s.x,x2=!PI/2-s.y, title=string(nfile)


endfor

end


