

pt=nx2*3/4
pload,1, var="bx2"
byt=bx2[*,pt]

nbeg=2
nend=nlast
for nfile=nbeg, nend do begin
pload, nfile, var="bx2"

byt=[[byt],[bx2[*,pt]]]
endfor

cgloadct,33

;display, signum(byt)*alog10(abs(byt+1e-8)), ims=[800,800]

fftby=fft(byt, dim=1)

lft=alog10(abs(fftby))

xx=findgen(nx1)
sz=size(lft, /dimensions)
yy=findgen(sz(1))
cgcontour, lft[0:nx1/2,*],xx,yy, /xlog, /fill, xrange=[0.1,200], nlev=64
end
