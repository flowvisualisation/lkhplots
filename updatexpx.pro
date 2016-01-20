

spawn ,'ls ex* | tail -1',a
b=strmid(a, 2,7)
nend2=long(b)
nend=nend2(0)



nstep=1000
nbeg=nend-10*nstep
for n=nbeg,nend,1000 do begin

path='./branches/nodielec/'
if ( file_test(path+'0000000ionxpx'+String(n,format='(I07)') ) ne 1) then begin
print, 'File does not exist ... exiting'
break
endif
readgenps, n, 'ionxpx', data, n1,n2
str=string(n, format='(I05)')
;r=h5_parse('ionxpx'+str+'.h5', /read_data)
;data=r.data._DATA
sz=size(data, /dimensions)
n1=sz(0)
n2=sz(1)

massratio=250.
nx=8e3
lambda_i_skin=3e8/sqrt(2e10)*sqrt(massratio)
dx=791.95/lambda_i_skin
dx=1
xl=nx*dx/2
x1=findgen(n1)*xl/(n1)-xl/2

x2=findgen(n2)*.03/(n2)-0.015
dispgenps2, n, 'ionxpx', data, n1,n2,x1,x2,tit,xtit,ytit
;cgloadct,33
;tvlct,255,255,255,1
;display, alog10(data[400:500,200:400]+0.1), /hbar, ims=[800,800], title=string(n)
;cgplot, fltarr(900)+385, findgen(900), /overplot, color='white'
endfor

end
