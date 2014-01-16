
varfile='VAR0'
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
rho=f0.rho[*,*]
v1=f0.uu[*,*,0]
v2=f0.uu[*,*,1]
v3=f0.uu[*,*,2]
b1=f0.bb[*,*,0]
b2=f0.bb[*,*,1]
b3=f0.bb[*,*,2]
print, 'max, min, v1', max(v1), min(v1)
print, 'max, min, v2', max(v2), min(v2)
print, 'max, min, v3', max(v3), min(v3)
print, 'max, min, b1', max(b1), min(b1)
print, 'max, min, b2', max(b2), min(b2)
print, 'max, min, b3', max(b3), min(b3)

end
