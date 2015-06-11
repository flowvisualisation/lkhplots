
nx1=100.
nx2=100.
nx3=100.
x1=findgen(nx1)/nx1
x2=findgen(nx2)/nx2
x3=findgen(nx3)/nx3

x2d=rebin(reform(x1,nx1,1,1),nx1,nx2,nx3)
y2d=rebin(reform(x2,1,nx2,1),nx1,nx2,nx3)
z2d=rebin(reform(x3,1,1,nx3),nx1,nx2,nx3)


myarr=fltarr(nx1,nx2,nx3)


myarr=sin(2*!PI*(x1+x2+x3)) 


ft=fft3d(myarr,+1)

end
