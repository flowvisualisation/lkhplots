
pro plotvec, v1arr,v2arr,v3arr,b1arr,b2arr,b3arr, tnorm



items=['v1','v2', 'v3', 'b1', 'b2', 'b3' ]
linestyles=[0,0,0,2,2,2]
psym=[0,1,2,3,4,5]
colors=['red', 'blue', 'green', 'orange', 'turqoise', 'purple']

!p.thick=2
cgplot, tnorm, v1arr,  $
		/ylog, yrange=[1e-2,1e4], $
		color=colors[0], linestyle=linestyles[0]

	cgplot, tnorm, v2arr, /overplot, color=colors[1], linestyle=linestyles[1]
	cgplot, tnorm, v3arr, /overplot, color=colors[2], linestyle=linestyles[2]
	cgplot, tnorm, b1arr, /overplot, color=colors[3], linestyle=linestyles[3]
	cgplot, tnorm, b2arr, /overplot, color=colors[4], linestyle=linestyles[4]
	cgplot, tnorm, b3arr, /overplot, color=colors[5], linestyle=linestyles[5]

	
	cgplot, tnorm, 0.2*exp(0.75*tnorm), /overplot, color=colors[5], linestyle=linestyles[5]

	al_legend, items, colors=colors, linestyle=linestyles


	end
