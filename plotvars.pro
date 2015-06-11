
readcol, "averages.dat", t,dt, b2, bxby, rhou, alpha, bz,by,bx


colors=['blue', 'red', 'green']
linestyles=[0,2,3]
cgplot,t, bx, color=colors[0], linestyle=linestyles[0]
cgplot,t, by, /overplot, color=colors[1], linestyle=linestyles[1]
cgplot,t, bz, /overplot, color=colors[2], linestyle=linestyles[2]

end
