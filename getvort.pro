

function getvort, vec1,vec2, x1,x2,nx,ny
;print, nx,ny

;vort= 0.5*(shift(vec1,0,-1)-shift(vec1,0,1) ) - 0.5*(shift(vec2,-1,0) - shift(vec2,1,0))
;vort= 1./60.*(-shift(vec1,0,-3)+9*shift(vec1,0,-2)-45*shift(vec1,0,-1)-45*shift(vec1,0,1)-9*shift(vec1,0,1)-shift(vec1,0,1) ) - 0.5*(shift(vec2,-1,0) - shift(vec2,1,0))

dvec1dy=vec1
dvec2dx=vec2

extarr=fltarr(ny+4)
extx2=fltarr(ny+4)
for i=0,nx-1 do begin
    extarr[0:1]=vec1[i,ny-2:ny-1]
    extarr[2:ny+1]=vec1[i,0:ny-1]
    extarr[ny+2:ny+3]=vec1[i,0:1]
    extx2[2:ny+1]=x2
    dy=x2[1]-x2[0]
    extx2[0]=x2[0]-2*dy
    extx2[1]=x2[0]-dy
    extx2[ny+2]=x2[ny-1]+dy
    extx2[ny+3]=x2[ny-1]+2*dy
   a=reform(vec1(i,*))

;help, dvec1dy(i,*), a,x2

   b=deriv(extx2,extarr)
   dvec1dy(i,*)=deriv(x2,a)
   dvec1dy(i,*)=b[2:ny+1]
endfor
extarr=fltarr(nx+4)
extx1=fltarr(nx+4)
for j=0,ny-1 do begin
    extarr[0:1]=vec2[nx-2:nx-1,j]
    extarr[2:nx+1]=vec2[0:nx-1,j]
    extarr[nx+2:nx+3]=vec2[0:1,j]
    extx1[2:nx+1]=x1
    dx=x1[1]-x1[0]
    extx1[0]=x1[0]-2*dx
    extx1[1]=x1[0]-dx
    extx1[nx+2]=x1[nx-1]+dx
    extx1[nx+3]=x1[nx-1]+2*dx

   a=reform(vec2(*,j))
   dvec2dx(*,j)=deriv(x1,a)
   b=deriv(extx1,extarr)
   dvec2dx(*,j)=b[2:nx+1]
   ;cgplot, extarr
   ;stop
endfor

vort=( dvec1dy-dvec2dx)
;0.5*(shift(vx1,0,-1)-shift(vx1,0,1) ) - 0.5*(shift(vx2,-1,0) - shift(vx2,1,0))

return, vort

end
