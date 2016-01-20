
cgdisplay, xs=800,ys=800



fftarr=complexarr(nx1,nx2,nx3)

neven=nlast - (nlast mod 2)
for nfile=neven-2,neven, 2 do begin
d=h5_read(300000,  /B)
bx1=transpose(reform(d.b[2,*,*,*]))
bx2=transpose(reform(d.b[1,*,*,*]))
bx3=transpose(reform(d.b[0,*,*,*]))


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
for qq=0,1 do begin


data=reform( alog10(abs(fftarr(0:nx1/2-1,0,*))))
xx1=findgen(nx1/2)
xtit1='k!Dx!N'
varname='kx'+dirtag+string(nfile, format='(I04)')

if ( qq eq 1) then begin
data=reform( alog10(abs(fftarr(0,0:nx2/2-1,*))))
xx1=findgen(nx2/2)
xtit1='k!Dy!N'
varname='ky'+dirtag
endif

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
 cgcontour, data, xx1,xx2, /xlog, /fill, nlev=64, xrange=[1,200], $
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

endfor

end

