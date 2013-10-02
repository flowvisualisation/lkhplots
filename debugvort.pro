pload,0
initvort =getvort(vx1,vx2,x1,x2,nx1,nx2)

pload,3
vort =getvort(vx1,vx2,x1,x2,nx1,nx2)


ps_start, filename="artifact.eps"
!p.multi=[0,1,2]
plot,x2, vort(50,*)-initvort(50,*), xrange=[0.4,0.6]


cgplot,x2, vort(50,*), xrange=[0.4,0.6], title="overplotted vorticities at time t=0.1", psym=-16, linestyle=0, color='blue'
cgplot,x2, initvort(50,*), /overplot, psym=-17, linestyle=2, color='red'
ps_end
end
