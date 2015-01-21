
fftarr2=congrid(fftarr,nx2,nx2,nx3)

afft=abs(fftarr2)

angled=10.

angle=angled*!DTOR

slice2d=fltarr(nx2/2,nx3)

for k=0,nx3-1 do begin


dat=reform(afft(*,*,k))
sz=size(dat, /dimensions)

nxq=sz(0)
nyq=sz(1)
xq=findgen(nxq/2)*cos(angle);+nxq/2
yq=findgen(nyq/2)*sin(angle);+nyq/2
yq1=yq
   slice2d(*,k)=interpolate (dat ,xq,yq)



endfor

display, alog10(slice2d)



end
