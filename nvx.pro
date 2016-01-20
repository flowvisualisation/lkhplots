getlast, nlast
nstep=2000
nbeg=nlast-3*nstep
nbeg=nlast
for nfile=nbeg, nlast, nstep do begin
print, nfile
r=h5_read(nfile, /rho, /v, /remap)
grd_Ctl, model=nfile, g,c

cgloadct,33
xs=1500
ys=1100
cgdisplay,xs=xs,ys=ys

vx=reform(r.v(0,0,*,*))
;display, ims=[800,800], vx, /hbar, title='t='+string(nfile)
pos=cglayout([3,3], OXMargin=[9,1], OYMargin=[9,1], XGap=5, YGap=6)

datptr=ptrarr(9)
datptr[0]=ptr_new( transpose(reform(r.v(0,*,*,g.nx/2)) ))
datptr[1]=ptr_new( reform(r.v(0,*,g.ny/2,*)) )
datptr[2]=ptr_new( reform(r.v(0,g.nz/2,*,*)) )
datptr[3]=ptr_new( transpose(reform(r.v(1,*,*,g.nx/2)) ))
datptr[4]=ptr_new( reform(r.v(1,*,g.ny/2,*)) )
datptr[5]=ptr_new( reform(r.v(1,g.nz/2,*,*)) )
datptr[6]=ptr_new( transpose(reform(r.v(2,*,*,g.nx/2)) ))
datptr[7]=ptr_new( reform(r.v(2,*,g.ny/2,*)) )
datptr[8]=ptr_new( reform(r.v(2,g.nz/2,*,*)) )

xstr=strarr(9)
xstr[0]="Y"
xstr[1]="Z"
xstr[2]="Y"
xstr[3]=xstr[0]
xstr[4]=xstr[1]
xstr[5]=xstr[2]
xstr[6]=xstr[0]
xstr[7]=xstr[1]
xstr[8]=xstr[2]


ystr=strarr(9)
ystr[0]="Z"
ystr[1]="X"
ystr[2]="X"
ystr[3]=ystr[0]
ystr[4]=ystr[1]
ystr[5]=ystr[2]
ystr[6]=ystr[0]
ystr[7]=ystr[1]
ystr[8]=ystr[2]

cgerase

for i=0,8 do begin
dat= *datptr[i]
imin=min(dat)
imax=max(dat)
res=cgscalevector(dat,1,255)

px=pos[*,i]
cgimage, res, pos=px, /noerase, /keep_aspect
cgcontour, res, /nodata, /noerase, pos=px, $
    xtitle=xstr[i],$
    ytitle=ystr[i]
cby=0.04
cgcolorbar, range=[imin,imax],pos=[px[0], px[1]-0.01-cby, px[2], px[1]-cby]

endfor

endfor

end
