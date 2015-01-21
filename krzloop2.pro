;pload, 46
cgdisplay, xs=800,ys=800


fftarr=complexarr(nx1,nx2,nx3)

neven=nlast - (nlast mod 2)
for nfile=neven-2,neven, 2 do begin
pload, nfile, var="bx1"
pload, nfile, var="bx2"
pload, nfile, var="bx3"
b2=bx1^2+bx2^2+bx3^2
for k=0,nx3-1 do begin


;fftarr(*,*,k)=fft(b2(*,*,k),/center)
fftarr(*,*,k)=fft(b2(*,*,k))

endfor


cgloadct,33
;display, alog10(abs(fftarr(nx1/2,*,*))),ims=[400,1200]
;display, alog10(abs(fftarr(*,nx2/2,*))),ims=[400,1200]


n=1

spawn, 'basename $PWD', dirtag

qq=0


data=reform( alog10(abs(fftarr(0:nx1/2-1,0,*))))
xx1=findgen(nx1/2)
xtit1='k!Dr!N'
varname='kr'+dirtag+string(nfile, format='(I04)')


fftarr2=congrid(fftarr,nx2,nx2,nx3)

afft=abs(fftarr2)

angled=10.


;gg=alog10( shift(reform(fftarr2(*,*,nx3/2)),nx2/2,nx2/2 ))
gg=alog10(abs(shift(reform(fftarr(*,*,nx3/2)),nx2/2,nx2/2)))
gft=gauss2dfit(gg, aa,/tilt)
print, 'angle= ', aa[6]*!RADEG
angled=  -1*aa[6]*!RADEG

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

data=alog10(slice2d)

help, data
xx2=x3
title='log!D10!N|B!U2!N('+xtit1+',z)|'
ytit1='z'

;dispgenps3, n, varname, data, n1,n2,xx1,xx2, title, xtit1, ytit1
 
spawn, 'basename $PWD', a
dirname=a

fname="b"+varname
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
charsize=cgdefcharsize()*0.9
pi_str='!9p!X'
endif else  begin
set_plot, 'x'
charsize=cgdefcharsize()*1.1
pi_str='!7p!X'
endelse



ttag=', t='+string(nfile, format='(I4)')

    pos=[0.12,0.23,0.9,0.93]
 cgcontour, data, $
    xx1,$
    xx2/sqrt(2),$ 
    /xlog, /fill, nlev=64, $
    xrange=[1,200], $
    yrange=[0,4.], $
    pos=pos,$
    xtitle=xtit1,$
    ytitle="z/H",$
    title=dirtag+ttag
    imin=min(data)
    imax=max(data)
    cgcolorbar, range=[imin,imax], pos=[pos[0], pos[1]-0.15, pos[2], pos[1]-0.13]







if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100
endif else begin
endelse

endfor




endfor

end
