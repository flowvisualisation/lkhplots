

function getvortsimple, vec1,vec2, x1,x2,nx,ny
print, nx,ny

vort= 0.5*(shift(vec1,0,-1)-shift(vec1,0,1) ) - 0.5*(shift(vec2,-1,0) - shift(vec2,1,0))
;vort= 1./60.*(-shift(vec1,0,-3)+9*shift(vec1,0,-2)-45*shift(vec1,0,-1)-45*shift(vec1,0,1)-9*shift(vec1,0,1)-shift(vec1,0,1) ) - 0.5*(shift(vec2,-1,0) - shift(vec2,1,0))

return, vort

end
