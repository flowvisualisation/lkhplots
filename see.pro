

; COMMON PLUTO_GRID
; COMMON PLUTO_VAR
; COMMON PLUTO_RUN
pload, 0,  /silent

rhomin=1e-4
rhomax=1

nfile=10
nstep=1
nbeg=max([0,nlast-2])
nbeg=0
for nfile=nbeg,nlast,nstep do begin
print, nfile
pload, nfile, /silent
fname='stardisk'+string(nfile, format='(I04)')
cgloadct,33
;cgloadct,4
vec=alog10(rho)
vec[0,nx2-1]=rhomin
vec[1,nx2-1]=rhomax
;vec=vx1
ys=1100
ys=800
display, vec, x1=x1,x2=!PI/2-x2,/polar,  $
    title=' SDI, t='+string(t(nfile)/2.0/!DPI, format='(F6.2)')+' inner disk orbits',$
   ; xrange=[0,6], $
   ; yrange=[-5,5],$
    ims=[ys,ys], /hbar, charsize=2

;vecfield, -bx1, -bx2, x1, !PI/2-x2, /polar, /overplot, color=cgcolor('white')  , thick=2, len=1
if ( nfile ne 0) then begin
vecfield, vx1, -vx2, x1, !PI/2-x2, /polar, /overplot, color=cgcolor('white')  , thick=2, len=1
endif


x=x1*cos(x2)
y=x1*sin(x2)

b2=(bx1^2+bx2^2+bx3^2)/2.
bet=b2/prs


;for i=1.1, 9.2,0.3 do begin
;field_line, bx1, bx2,0., x,y,0.,  seed=[i,0.1], rr,zz ;, /quiet

field=0
field=1
if ( field eq 1) then begin
 for qq=x1[1],5.5,0.65 do begin
seed=[qq,!PI*9.9/20.]
myxq=x1
myyq=x2
br=bx1
bth=bx2/sqrt(xpos^2+ypos^2)
pl=0
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('black')
pl=0
seed=0
endfor
endif

;oplot, rr,zz,color=255
;endfor

im=cgsnapshot(filename=fname, /jpeg, /nodialog)

endfor
end
