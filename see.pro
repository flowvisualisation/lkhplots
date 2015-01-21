pload,/float, 0, /nodata

nfile=10
for nfile=0,nlast,1 do begin
pload,/float, nfile
fname='t2'+string(nfile, format='(I04)')
cgloadct,33
vec=alog10(rho)
;vec=vx1
display, vec, x1=x1,x2=!PI/2-x2,/polar,  $
   ; xrange=[0,6], $
   ; yrange=[-5,5],$
    ims=[800,800], /hbar, charsize=2

;vecfield, -bx1, -bx2, x1, !PI/2-x2, /polar, /overplot, color=cgcolor('white')  , thick=2, len=1
;vecfield, vx1, -vx2, x1, !PI/2-x2, /polar, /overplot, color=cgcolor('white')  , thick=2, len=1


x=x1*cos(x2)
y=x1*sin(x2)

for i=0.1, 9.2,0.3 do begin
field_line, bx1, bx2, x,y,  i,0.1, rr,zz ;, /quiet
oplot, rr,zz,color=255
endfor

im=cgsnapshot(filename=fname, /jpeg, /nodialog)

endfor
end
