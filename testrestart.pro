
nbeg=0

if (nend eq !NULL ) then begin
pload, 0, /nodata
nbeg=0
nend=nlast
endif else begin
nbeg=nend
pload, 0, /nodata
nend=nlast
endelse


for nfile=nbeg,nend do begin
pload,nfile
 b2=bx1^2+bx2^2+bx3^2      
 cgloadct,33
display, alog10(rho), /polar, x1=x1,x2=!PI/2-x2, ims=[550,1100], /hbar,$
    label1='R',$
    label2='Z',$
    xrange=[0,10],$
    yrange=[-10,10],$
    title='time'+string(t(nfile), format='(F5.1)')


for i=3.1,21,2 do begin
field_line, bx1,bx2/sqrt(xpos^2+ypos^2),x1,x2,2.1+i/10.,!PI/2 ,rr,zz
oplot, rr*sin(zz), rr*cos(zz), color=cgcolor('white')

field_line, bx1,bx2/sqrt(xpos^2+ypos^2),x1,x2,5, i*!PI/40,rr,zz
oplot, rr*sin(zz), rr*cos(zz), color=cgcolor('white')
endfor

fname="den"+string(nfile, format='(I04)')
im=cgsnapshot(filename=fname, /jpeg,/nodialog)



endfor

end
