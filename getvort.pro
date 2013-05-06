

function getvort, vec1,vec2, x1,x2,nx,ny
;print, nx,ny

;vort= 0.5*(shift(vec1,0,-1)-shift(vec1,0,1) ) - 0.5*(shift(vec2,-1,0) - shift(vec2,1,0))
;vort= 1./60.*(-shift(vec1,0,-3)+9*shift(vec1,0,-2)-45*shift(vec1,0,-1)-45*shift(vec1,0,1)-9*shift(vec1,0,1)-shift(vec1,0,1) ) - 0.5*(shift(vec2,-1,0) - shift(vec2,1,0))

dvec1dy=vec1
dvec2dx=vec2

for i=0,nx-1 do begin
   a=reform(vec1(i,*))
;help, dvec1dy(i,*), a,dx2
   dvec1dy(i,*)=deriv(x2,a)
endfor
for j=0,ny-1 do begin
   a=reform(vec2(*,j))
   dvec2dx(*,j)=deriv(x1,a)
endfor

vort=( dvec1dy-dvec2dx)
;0.5*(shift(vx1,0,-1)-shift(vx1,0,1) ) - 0.5*(shift(vx2,-1,0) - shift(vx2,1,0))

return, vort

end
