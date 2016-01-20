
pos=cglayout([2,2])

x=findgen(300)
y=findgen(100)
cgimage, x#y, pos=pos[*,0], /keep_aspect
cgcontour,x#y, pos=pos[*,0], /noerase, aspect=1./3.
end
