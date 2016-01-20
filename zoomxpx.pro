pro zoomxpx, nfile
readgenps, nfile,"ionxpx", data, n1,n2

cgloadct,33
tvlct,255,255,255,1
tvlct,255,255,255,2
tvlct,255,255,255,3
d=alog10(data[400:500,200:800] +0.1)
r=cgscalevector(d,1,254)
print, r[2,2]
display,r, ims=[900,900], /hbar
end
