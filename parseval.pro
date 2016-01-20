
!p.multi=0
!p.position=0
seed=1
nx=100
f=randomn(seed,nx)

!p.multi=[0,1,2]
cgplot, f^2, title='f(n)!U2!N'
fk= abs(fft(f,/center))
cgplot, nx*fk^2, title='N!Dx!N*F(k)!U2!N'


print, "Parseval's theorem, total (f^2)", total(f^2), "=total    abs(fk^2)", total(nx*fk^2) ;/2/!DPI

end
