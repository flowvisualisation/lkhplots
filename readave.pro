;pro readave
readcol,'averages.dat',t,dt,rho,vx2,vy2,vz2,vy,rhovy,Ebxby
cgplot,t, vx2/vx2(0), /ylog, yrange=[1e-4,1], PSym=-15, Color='red', xtitle='k!Dh!N', ytitle='growth rate', linestyle=0
cgplot, t, vy2/vx2(0), /overplot,  PSym=-16, Color='dodger blue', linestyle=2
cgplot, t, vz2/vx2(0), /overplot,  PSym=-17, Color='green', linestyle=3
al_Legend, ['vx2', 'vy2', 'vz2'], PSym=[-15,-16,-17], $
      LineStyle=[0,2,3], Color=['red','dodger blue', 'green']
      ;cgsnapshot()


    set_plot,'ps'
      device, /encapsulated, /color
      device, filename="kh_3d_growth.eps"  

!p.font=0
device, /times


cgplot,t, vx2/vx2(0), /ylog, yrange=[1e-4,1], PSym=-15, Color='red', xtitle='k!Dh!N', ytitle='growth rate', linestyle=0
cgplot, t, vy2/vx2(0), /overplot,  PSym=-16, Color='dodger blue', linestyle=2
cgplot, t, vz2/vx2(0), /overplot,  PSym=-17, Color='green', linestyle=3
al_Legend, ['vx2', 'vy2', 'vz2'], PSym=[-15,-16,-17], $
      LineStyle=[0,2,3], Color=['red','dodger blue', 'green']
      ;cgsnapshot()

device, /close
!p.font=-1

      set_plot,'x'

end

