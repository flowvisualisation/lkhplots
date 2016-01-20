pload,  0, /nodata
for nfile=0,nlast,1 do begin
pload,nfile
!p.font=0
device,set_font="-adobe-times-medium-r-normal--20-140-100-100-p-96-iso8859-15"
cgloadct,33
;cgloadct,4

ys=1100
xs=ys/2
display, alog10(rho),x1=x1,x2=!PI/2-x2, /polar, /hbar, ims=[xs,ys],$
    label1='R',$
    label2='Z',$
    xrange=[0,10],$
    yrange=[-10,10],$
    title='time'+string(t(nfile), format='(F5.1)')

    vecfield, vx1,vx2, x1,!PI/2-x2(*), /polar, /overplot,color=cgcolor('yellow')

for i=3.1,21,2 do begin
field_line, bx1,bx2/sqrt(xpos^2+ypos^2),x1,x2,2.1+i/10.,!PI/2 ,rr,zz
oplot, rr*sin(zz), rr*cos(zz), color=cgcolor('white')

field_line, bx1,bx2/sqrt(xpos^2+ypos^2),x1,x2,5, i*!PI/40,rr,zz
oplot, rr*sin(zz), rr*cos(zz), color=cgcolor('white')
endfor

fname="den"+string(nfile, format='(I04)')
im=cgsnapshot(filename=fname, /jpeg,/nodialog)


;display,  /polar, x1=x1,x2=!PI/2-x2, ims=[550,1100], /hbar, vx3

endfor

end

