
!p.multi=0
readcol,'data/time_series.dat', it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax

items=['v1','v2', 'v3', 'b1', 'b2', 'b3','growth=0.75' ]
linestyles=[0,0,0,3,2,2,1]
psym=[0,1,2,3,4,5,6]
colors=['red', 'blue', 'green', 'orange', 'turquoise', 'purple', 'black']


maxall=max([ [ux2m] , [uy2m], [uz2m] , [bx2m] , [by2m] ,[bz2m]   ])

cgplot, t, ux2m, color=colors[0], linestyle=linestyles[0], /ylog, yrange=[1e-4*max(maxall), max(maxall)]
cgplot, t, uy2m, /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, t, uz2m, /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, t, bx2m, /overplot, color=colors[3], linestyle=linestyles[3]
cgplot, t, by2m, /overplot, color=colors[4], linestyle=linestyles[4]
cgplot, t, bz2m, /overplot, color=colors[5], linestyle=linestyles[5]
cgplot, t, ux2m[0]*exp(0.75*t), /overplot, color=colors[6], linestyle=linestyles[6]



	al_legend, items, colors=colors, linestyle=linestyles




end
