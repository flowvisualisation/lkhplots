


nx1=200
nx2=200
x1=findgen(nx1)
x2=findgen(nx2)
x2d=rebin(reform(x1,nx1,1),nx1,nx2)
y2d=rebin(reform(x2,1,nx2),nx1,nx2)
a=dist(nx1)
a=sin(2*!PI* (x2d+y2d)/nx1 ) 
a=sin(2*!PI* (x2d)/nx1 ) 

b=fft(a , /center)



M = (INDGEN(nx1)-(nx1/2-1)) 

k2d=rebin(reform(m,1,nx1),nx1,nx2)

jimag=complex(0,1)
angle=0.2
rotat=exp(jimag * x2d*  k2d *2 *!PI * angle)
c=b * rotat 

d=fft(c , /inverse , /center)


window, xs=800, ys=1100
!p.position=0
!p.multi=[0,1,6]
cgimage, a
cgimage, alog10(abs(b))
cgimage,  (real_part(rotat))
;cgimage,  (imaginary(rotat))
cgimage,  scale_vector(abs(b),1,255)
cgimage,  alog10(abs(c))
cgimage,  (real_part(d))
!p.multi=0
end


