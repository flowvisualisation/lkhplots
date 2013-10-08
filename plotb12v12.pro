
!p.font=-1
 
items=['(b!D1!N!U2!N+b!D2!N!U2!N )/ (v!D1!N!U2!N+v!D2!N!U2!N)','5./3.']
linestyles=[0,1]
psym=[0,1]
colors=['red', 'blue']


 cgplot, tnorm, (b1arr^2+b2arr^2)/(v1arr^2+v2arr^2), yrange=[0,2],   color=colors[0], linestyle=linestyles[0]
 cgplot, tnorm, tnorm(*)-tnorm(*)+5./3., /overplot,   color=colors[1], linestyle=linestyles[1]




	

	al_legend, items, colors=colors, linestyle=linestyles, charsize=2




 end
