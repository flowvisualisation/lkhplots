
pro rotalp3d, vx, vy, vz, alp, vxd, vyd , vzd
vxd=vx
vyd=vy*cos(alp) -vz*sin(alp)
vzd=vy*sin(alp) +vz*cos(alp)
end


