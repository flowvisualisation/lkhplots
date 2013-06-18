pload,0
initvort =0.5*(shift(vx1,0,-1)-shift(vx1,0,1) ) - 0.5*(shift(vx2,-1,0) - shift(vx2,1,0))
pload,3
vort =0.5*(shift(vx1,0,-1)-shift(vx1,0,1) ) - 0.5*(shift(vx2,-1,0) - shift(vx2,1,0))

ps_start
plot,x2, vort(50,*)-initvort(50,*), xrange=[0.4,0.6]
ps_end

end
