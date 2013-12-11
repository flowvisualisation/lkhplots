; $Id: power3d.pro,v 1.24 2008/11/14 09:07:59 aake Exp $

PRO power3d,a,b,c,oplt=oplt,title=title,xtitle=xtitle,ytitle=ytitle,$
  size=size,spectrum=spectrum,wavenumbers=wns,fit=fit,afit=afit,$
  average=average,corners=corners,debug=debug,kindex=kindex,$
  compensate=compensate,offset=o,noplot=noplot,potsdam=potsdam,_extra=extra,rad=rad,ta=ta
;
;  Calculate 3d power spectrum.  The resulting spectrum satisfies
;  total(a^2)=wavenumber(1)*total(spectrum).
;
;  Only handles the common case where all sides of the periodic
;  domain are equal (=size).
;
if n_elements(title ) eq 0 then title =''
if n_elements(xtitle) eq 0 then xtitle='Wavenumber'
if n_elements(ytitle) eq 0 then ytitle='Power'
if n_elements(o     ) eq 0 then o     =0.18

if keyword_set(kindex) then o=0.

if keyword_set(potsdam) then begin
  kindex=1
  o=0.5
  plo=0.
end else begin
  plo=o
end
print,o,plo

s=size(a) & nx=s(1) & ny=s(2) & nz=s(3)
if n_elements(size) eq 0 then size=2.*!pi
k0=2.*!pi/size

if keyword_set(debug) then print,'doing fft ...'
t0=systime(1)
if s(0) eq 3 then begin
  ta=fft(a,-1)                                          ; complex 3D FFT
  ta=shift(ta,nx/2,ny/2,nz/2)                           ; shift to corner
end else if s(0) eq 4 then begin
  ta=complexarr(s(1),s(2),s(3),s(4))
  for i=0,s(4)-1 do ta(*,*,*,i)=shift(fft(a(*,*,*,i),-1),nx/2,ny/2,nz/2)
end
parseval=aver(a^2)
t1=systime(1)
if keyword_set(debug) then print,t1-t0,' sec'

t0=systime(1)
x1=indgen(nx)-nx/2
y1=indgen(ny)-ny/2
z1=indgen(nz)-nz/2
x1=reform(x1,nx,1,1)
y1=reform(y1,1,ny,1)
z1=reform(z1,1,1,nz)
rad=rebin(x1,nx,ny,nz)^2
rad=temporary(rad)+rebin(y1,nx,ny,nz)^2                 ; conserve memory
rad=temporary(rad)+rebin(z1,nx,ny,nz)^2
rad=temporary(sqrt(rad))                                ; wave vector radius
t1=systime(1)
if keyword_set(debug) then print,t1-t0,' sec'

if keyword_set(corners) then $
  imax=fix(max(rad)) $                                  ; include corners
else $
  imax=min([nx,ny,nz]/2)                                ; cut corners
spectrum=fltarr(imax)
ka=fltarr(imax)
if n_elements(average) ne 1 then average=spectrum

if keyword_set(debug) then print,'looping over shells'
t0=systime(1)
for i=0L,imax-1 do begin                                ; cut the corners?
  ii=where((rad ge i+o-.5) and (rad lt i+o+.5),nw)      ; indices into shell
  if keyword_set(debug) and i le 10 then print,i,nw
  if s(0) eq 3 then begin
    tmp=ta(ii) & tmp=abs(temporary(tmp))^2              ; conserve memory
  end else begin
    tmp=abs(ta(*,*,*,0))^2
    for k=1,s(4)-1 do tmp=temporary(tmp)+abs(ta(*,*,*,k))^2
  end
  ka(i)=aver(rad(ii))                                   ; average wave number
  if keyword_set(kindex) then ka(i)=i+plo
  if n_elements(average) ne 1 then begin                ; average array or not?
    spectrum(i)=total(tmp)                              ; sum over shell
    average(i)=aver(tmp*rad(ii)^2)*4.*!pi               ; average*volume
  end else begin
    spectrum(i)=aver(tmp*rad(ii)^2)*4.*!pi              ; average*volume
  end
endfor
t1=systime(1)
if keyword_set(debug) then print,t1-t0,' sec'

wns=ka*k0                                               ; normalize wavenumbers
spectrum=spectrum/k0                                    ; normalize to k0

if keyword_set(corners) then begin
  spectrum=spectrum*(parseval/sum(spectrum))            ; make sure Parseval is OK
end

if keyword_set(compensate) then spectrum(1:*)=spectrum(1:*)*wns(1:*)^compensate

if n_elements(c) gt 0 then begin
  power3d,c,aver=aver,compensate=compensate,kindex=kindex,sp=sp1,/noplot,offset=o,potsdam=potsdam
  spectrum=spectrum+sp1
end
if n_elements(b) gt 0 then begin
  power3d,b,aver=aver,compensate=compensate,kindex=kindex,sp=sp1,/noplot,offset=o,potsdam=potsdam
  spectrum=spectrum+sp1
end

if keyword_set(fit) then begin
  if n_elements(fit) eq 2 then begin
    i=fit
  end else begin
   i=[1,10]
  end
  kfit=alog(wns(i(0):i(1)))
  pfit=alog(spectrum(i(0):i(1)))
  afit=poly_fit(kfit,pfit,1,yfit)
  if keyword_set(compensate) then afit[1]=afit[1]-compensate
  print,afit[1]
end

if keyword_set(noplot) then return

if n_elements(oplt) eq 0 then begin
  plot_oo,wns(1:*),spectrum(1:*),$              ; skip DC in log-log
    title=title,xtitle=xtitle,ytitle=ytitle,$
    _extra=extra
endif else begin
  oplot,wns(1:*),spectrum(1:*),$
    line=oplt, _extra=extra
endelse
if keyword_set(fit) then oplot,exp(kfit),exp(yfit)

return
end

;+
 PRO test_power3d,n,iter=iter,index=testindex,_extra=e
;
;  Amplitudes           ~ k^p
;  Square ampl          ~ k^{2p}
;  Power spectrum       ~ k^{2p+2}
;
;  p=-1 should give a flat power spectrum P(k), and p=-2 should give a flat k^2 P(k)
;-
  default,n,16
  default,iter,100
  kk=wavenumbers(n,n,n)
  kk(0,0,0)=1.

  sp1=0.
  sp2=0.
  powerindex=0.
  ft=complexarr(n,n,n)
  for i=1,iter do begin
    ft(0:n/2-1,0:n/2-1,0:n/2-1)=exp(complex(0.,1.)*2.*!pi*randomu(seed,n/2,n/2,n/2))
    ft(0      ,0:n/2-1,0:n/2-1)=sqrt(.5)*ft(0      ,0:n/2-1,0:n/2-1)
    ft(0:n/2-1,0      ,0:n/2-1)=sqrt(.5)*ft(0:n/2-1,0      ,0:n/2-1)
    ft(0:n/2-1,0:n/2-1,0      )=sqrt(.5)*ft(0:n/2-1,0:n/2-1,0      )
    ft=ft/kk^(powerindex/2.+1.)
    ft(0,0,0)=0.
    f=float(fft(/inv,ft))
    power3d,f,sp=p1,wa=k,/nopl,_extra=e
    sp1=sp1+p1
    power3d,f,sp=p2,wa=k,/nopl,/aver,_extra=e
    sp2=sp2+p2
  end
  print,k(0:n/2-1)
  print,sp1(0:n/2-1)/iter
  print,sp2(0:n/2-1)/iter

  sp1=0.
  sp2=0.
  default,testindex,1.75
  for i=1,iter do begin
    ft(0:n/2-1,0:n/2-1,0:n/2-1)=exp(complex(0.,1.)*2.*!pi*randomu(seed,n/2,n/2,n/2))
    ft(0      ,0:n/2-1,0:n/2-1)=sqrt(.5)*ft(0      ,0:n/2-1,0:n/2-1)
    ft(0:n/2-1,0      ,0:n/2-1)=sqrt(.5)*ft(0:n/2-1,0      ,0:n/2-1)
    ft(0:n/2-1,0:n/2-1,0      )=sqrt(.5)*ft(0:n/2-1,0:n/2-1,0      )
    ft=ft/kk^(testindex/2.+1.)
    ft(0,0,0)=0.
    f=float(fft(/inv,ft))
    power3d,f,sp=p1,wa=k,/nopl,_extra=e
    sp1=sp1+p1
    power3d,f,sp=p2,wa=k,/nopl,/aver,_extra=e
    sp2=sp2+p2
  end
  print,testindex
  print,k(0:n/2-1)^testindex*sp1(0:n/2-1)/iter
  print,k(0:n/2-1)^testindex*sp2(0:n/2-1)/iter

END
