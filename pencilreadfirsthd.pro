
varfile='VAR0'
pc_read_var, obj=f0, varfile=varfile
rho=f0.rho[*,3,*]
v1=f0.uu[*,3,*,0]
v2=f0.uu[*,3,*,1]
v3=f0.uu[*,3,*,2]
print, 'max, min, v1', max(v1), min(v1)
print, 'max, min, v2', max(v2), min(v2)
print, 'max, min, v3', max(v3), min(v3)

end
