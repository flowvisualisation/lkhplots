readcol, 'q01/averages.dat', n,t01,k01,k2,k3
readcol, 'q07/averages.dat', n,t07,k07,k2,k3
readcol, 'q15/averages.dat', n,t15,k15,k2,k3
readcol, 'q19/averages.dat', n,t19,k19,k2,k3


color=['green', 'blue', 'red', 'orange']

pi2=2*!DPI
cgplot, t01/pi2, k01, /nodata
cgplot, t19/pi2, k19, /overplot, color=color[0]
cgplot, t15/pi2, k15, /overplot, color=color[1]
cgplot, t07/pi2, k07, /overplot, color=color[2]
cgplot, t01/pi2, k01, /overplot, color=color[3]

items=[$
    'q=1.9',$
    'q=1.5',$
    'q=0.7',$
    'q=0.1'$
    ]
    lines=[0,0,0,0]
al_legend, items, lines=lines, color=color, /bottom
end
