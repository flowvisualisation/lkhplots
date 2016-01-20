
cgdisplay, xs=800,ys=1000
cgerase
pos = cglayout([3,6] , OXMargin=[5,12], OYMargin=[5,5], XGap=7, YGap=5)

!p.charsize=0.9
e=abs(fftarr)
nq=256
e=congrid(e,nq,nq,nq)
e=shift(e,nq/2,nq/2,0)

for i=0,18-1 do begin

ang=5*i

slice = EXTRACT_SLICE( e, nq, nq,nq/2 , nq/2, nq/2, !DPI/2, !DPI/2-!DPI/180.*ang, 0, OUT_VAL=0B, /radians)
dat=alog10(slice+1e-14)
r=cgscalevector(dat,1,254)
cgimage, r, pos=pos[*,i],title=string(ang), color='black', /noerase;, /fill, nlev=48
cgcontour, r, pos=pos[*,i], /noerase, /nodata, title=string(ang)
endfor


end
