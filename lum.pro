

a= [[1 ,0, 0],[0 ,1 ,0 ],[0, 0 ,0] ]/2.

d=identity(3)/3.
b=a-d

print, determ(b)
print, 0.5*(trace(b)^2 - trace(b*b))



end
