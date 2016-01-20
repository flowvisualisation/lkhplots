pro getnarr, vx,vy,vz, narr
vx3d=reform(transpose(r.v(0,*,*,*)))
vy3d=reform(transpose(r.v(1,*,*,*)))-vy3d0
vz3d=reform(transpose(r.v(2,*,*,*)))
narr2=reform( total( sqrt(vx3d^2+vy3d^2+vz3d^2),3) ) & tag="vb2"

end
