
x1=findgen(100)

testdata=sin(x1/100*2*!PI)


f=fft(testdata, /center)

j=complex(0,1)
k=0.5
rf=f*exp(j*k*x1)

g=fft(rf, /inverse, /center)
!p.multi=[0,1,6]


cgplot, testdata
cgplot, abs(f)
cgplot, atan(f, /phase)
cgplot, abs(rf)
cgplot, atan(rf, /phase)
cgplot, real_part(g)


end
