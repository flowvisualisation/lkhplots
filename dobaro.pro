nplots=5
nphys=2

nplots=min([nplots,nlast+1])
pos=cglayout( [nphys,nplots], oxmargin=[11,1], oymargin=[11,1], xgap=10, ygap=5)

xs=1270
ys=xs*nplots/5
cgdisplay, xs=xs,ys=ys
for i=0,nplots-1 do begin

if ( i gt nlast ) then break 
pload,i
px1=pos[*,nphys*i]
px2=pos[*,nphys*i+1]
;px3=pos[*,nphys*i+2]
cgplot, x2, rho[0,*], pos=px1, /noerase, /ylog, ytitle='!7q!X, t= '+string(t[i], format='(F5.3)'), xtitle='z'
;cgplot, x2, prs[0,*], pos=px3, /noerase, /ylog, ytitle='Pressure', xtitle='z'
cgplot, x2, vx2[0,*], pos=px2, /noerase, ytitle='v!Dz!N', xtitle='z'

endfor
fname2='allvar'
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
end
