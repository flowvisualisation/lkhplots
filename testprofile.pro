nx=100
a=findgen(nx,nx)

x=findgen(nx)
y=findgen(nx)

xq=cos(!PI/3)*x
yq=sin(!PI/3)*y

profile1=interpolate(a, xq, yq)
cgplot, profile1



end
