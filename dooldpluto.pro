pload,out=1
nx=200

cgloadct,33

fname='rho'
display, alog10(rho(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )

fname='v1'
display, (v1(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )

fname='v2'
display, (v2(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )


fname='v3'
display, (v3(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )

fname='prs'
display, alog10(pr(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )

fname='b1'
display, (b1(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )

fname='b2'
display, (b2(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )

fname='b3'
display, (b3(1:nx,1:nx,0)),x1=x1(1:nx),x2=x2(1:nx), ims=2, /hbar, title=fname
im=cgsnapshot(filename=fname,/jpeg, /nodialog )

end
