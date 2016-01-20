function remapfunc , arr , myt, nx,ny , q,x1,x2, dx2
;nfile=nlast
;nfile=63
;myt=t(nfile)
;pload,nfile, /silent
;print, 'reading ', nfile

;arr=reform(bx1[*,*,0])


narr=arr



; nearest periodic point

; every 1/q 

;spawn, 'basename ${PWD}', dirtag
;qtag=strmid(dirtag,1,2)
;qq=fix(qtag)
;q=qq[0]/10.
;qstr="q="+string(q, format='(F4.1)')


dt = myt mod (1./q)

if ( dt > 1./q/2) then dt= 1./q-dt

print, 't', myt
print, 'dt', dt

ysize=x2[ny-1]-x2[0]+dx2[0]
omega=1.0
yshift= q*omega*ysize *dt/2
print, 'ysize  =', ysize
print, 'q      =', q
print, 'yshift =', yshift


shft=(findgen(nx)/(nx-1)*2-1) *yshift

for i=0,nx-1 do begin
for j=0,ny-1 do begin


; find location of shear
; if pos or neg
; if too big wrap around


; interpolate:1
myshft=shft(i)+x2[j]
if ( myshft gt ysize/2 ) then myshft= myshft-ysize
if ( myshft lt -ysize/2    ) then myshft= myshft+ysize

myarr=reform(arr[i,*])
a=interpol( myarr,x2,  myshft )
;print, myshft

narr(i,j)= a
endfor
endfor


cgloadct,33
;display,  ims=[1000,1000], /hbar, [ [  narr,narr ] ,   [ arr,arr  ]]
fn=alog10(abs(fft( narr  , /center)+1e-6))
fo=alog10(abs(fft(  arr  , /center)+1e-6))
;display,  ims=[1000,500], /hbar, [fo, fn]

return, narr
end
