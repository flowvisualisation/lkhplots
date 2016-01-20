
pload,nlast
nbeg=nlast-10
nbeg=0
for i=nbeg, nlast do begin
pload,i


xx=x1
yy=x2
dd=rho
polar,dd, xx,yy

;display, ims=[800,800], /polar, x1=x1,x2=x2, alog10(rho), $
;    label1='x', $
;    label2='y'
dat=alog10(dd)
r=cgscalevector( dat,1 ,254)
imin=min(dat)
imax=max(dat)
pos=cglayout([1,1] , OXMargin=[8,5], OYMargin=[12,5], XGap=7, YGap=2)
px=pos[*,0]
cgimage, r, pos=px
cgcontour, r, xx,yy, /nodata, /noerase, pos=px, $
    title='Kepler 36 planetesimals, t='+string(t[i], format='(F4.1)'), $
    xtitle='X/R!DP!N', $
    ytitle='Y/R!DP!N '

cgcolorbar, range=[imin,imax], pos=[px[0], px[1]-0.08, px[2], px[1]-0.07 ]



fname='plan'+string(i, format='(I04)')
im=cgsnapshot(filename=fname, /jpeg, /nodialog)

endfor


end
