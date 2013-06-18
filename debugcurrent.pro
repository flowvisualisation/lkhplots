pload,0
initvort =getvort(bx1,bx2,x1,x2,nx1,nx2)

pload,3
vort =getvort(bx1,bx2,x1,x2,nx1,nx2)


ps_start, filename="artifact"
!p.multi=[0,1,2]
plot,x2, vort(50,*)-initvort(50,*), xrange=[0.4,0.6]


cgplot,x2, vort(50,*), xrange=[0.4,0.6], title="overploteed vorticities at time t=0.1"
cgplot,x2, initvort(50,*), /overplot
ps_end
end
