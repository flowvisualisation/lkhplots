
;pload,74
cgloadct,33

if ( file_test('data.0000.dbl') ) then begin
code='pluto'
bsq=bx1^2+bx2^2+bx3^2
endif else begin 
code='snoopy'
bsq=bx^2+by^2+bz^2
nx1=nx
nx2=ny
endelse
 bsqm =bsq(*,*,*) -mean(bsq)
d= alog10(smooth( abs(fft(bsqm(*,*,0),/center)) , 2 , /edge_wrap )) 
 ;display, d , ims=[800,800]

n=15
varname="fftbsq"
data=reform(d)
x1=findgen(nx1)-nx2/2
x2=findgen(nx2)-nx2/2
n1=nx1
n2=nx2
title="DFT B!U2!N(k!Dx!N,k!Dy!N)"
xtit1="k!Dx!N"
ytit1="k!Dy!N"

 dispgenps3, n, varname, data, n1,n2,x1,x2, title, xtit1, ytit1

end
