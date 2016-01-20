function barycentric, l1, l2, l3, xn, yn
c1c=l1-l2
c2c=2*(l2-l3)
c3c=3*l3+1

x1c=-1
y1c=0

x2c=1
y2c=0

x3c=0
y3c=1.74

xn=c1c*x1c+ c2c*x2c +c3c*x3c
yn=c1c*y1c+ c2c*y2c +c3c*y3c

return, 0
end
