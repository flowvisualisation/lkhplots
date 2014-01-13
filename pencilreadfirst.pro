
varfile='VAR0'
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
rho=f0.rho[*,*]
v1=f0.uu[*,*,0]
v2=f0.uu[*,*,1]
v3=f0.uu[*,*,2]
b1=f0.bb[*,*,0]
b2=f0.bb[*,*,1]
b3=f0.bb[*,*,2]

end
