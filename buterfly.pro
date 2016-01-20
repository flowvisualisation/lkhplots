

;display,ims=[800,550], r.by._DATA*1e5 , title=pwd , x1=r.time._DATA, x2=r.z._DATA, /vbar, xrange=[0,55], /eps
r=h5_parse('profile.h5', /read)
spawn, 'basename $PWD', tag
title=tag
varname=tag+'butterfly'
data=r.by._DATA*1e5
x1=r.time._DATA
x2=r.z._DATA
n1=size(x1,/dimensions)
n2=size(x1,/dimensions)
xtit='time'
ytit='Z/H'
n=322000

dispgenps3, n, varname, data, n1,n2,x1,x2, title, xtit, ytit

end
