;pload, 46
cgdisplay, xs=800,ys=800


fftarr=complexarr(nx1,nx2,nx3)

neven=nlast - (nlast mod 2)
for nfile=neven-2,neven, 2 do begin
pload, nfile, var="bx1"
pload, nfile, var="bx2"
pload, nfile, var="bx3"
bxy=bx1*bx2
vartag='B!Dxy!N, '
for k=0,nx3-1 do begin


;fftarr(*,*,k)=fft(b2(*,*,k),/center)
fftarr(*,*,k)=fft(bxy(*,*,k))

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

if ( qq eq 1) then begin
e=abs(fftarr(0,0:nx2/2-1,*))
ang=80
 slice = EXTRACT_SLICE( e, 400, 400, 200, 200, 200, !DPI/2, !DPI/2-!DPI/180.*ang, 0, OUT_VAL=0B, /radians)
data=slice[201:399,*]

endif

xx2=x3
title='log!D10!N|B!U2!N('+xtit1+',z)|'
ytit1='z'

;dispgenps3, n, varname, data, n1,n2,xx1,xx2, title, xtit1, ytit1
 
spawn, 'basename $PWD', a
dirname=a

fname="bxy"+varname
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
 cgcontour, data, xx1,xx2/sqrt(2), /xlog, /fill, nlev=64, $
    xrange=[1,200], $
    yrange=[0,4.], $
    pos=pos,$
    xtitle=xtit1,$
    ytitle="z/H",$
    title=vartag+dirtag+ttag
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
