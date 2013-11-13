
nx=50
ny=51

xvec=dindgen(nx)/nx-0.5
x=rebin(reform(xvec, nx, 1 ), nx,ny)
yvec=dindgen(ny)/ny-0.5
y=rebin(reform(yvec, 1, ny ), nx,ny)

inarr= cos(32* 2*!PI*(x+y)) $
		+ 2*sin(16*2*!PI *(x-y)) 
		
inarr= sqrt(0.5*x^2 + y^2) lt 0.1
inarr= sqrt( (( x+y)^2)/8 + ((y-x)^2)/1) lt 0.1
inarr= cos(32* 2*!PI*(x+y)) 
inarr= cos(4* 2*!PI*(x+y)) 

;time=1.6
;time=1.2
q=1.5
Ly=1.0
Lx=1.0
omega=1e-3
n=0.75
n=0.25

time=n*Ly/(q*omega*Lx)
;time=0
 fftrotate, inarr, outarr, time


cgloadct,33
;window, xs=1300, ys=1100
cgDisplay, WID=1, location=[1200,800],xsize=1300, ysize=800
pos = cgLayout([2,1], OXMargin=[5,5], OYMargin=[12,12], XGap=10, YGap=10)
;pos=[0.1,0.2,0.9,0.9]
imin=min(inarr)
imax=max(inarr)
cgimage, scale_vector(inarr,1,255), noerase=0, position=pos[*,0]
cgcontour, inarr,x,y,/nodata,/noerase,    xtitle="x", ytitle="y", position=pos[*,0], color='black'
cgcolorbar, Position=[pos[0], pos[1]-0.06, pos[2], pos[1]-0.05], range=[imin,imax], format='(G12.1)', annotatecolor='black'

abs_o=abs(outarr)
logabs_o=alog10(abs_o)
shiftlogabs_o=shift(logabs_o, nx/2,ny/2)
shiftabs_o=shift(abs_o, nx/2,ny/2)
r=scale_vector( shiftabs_o,1,255)

cgloadct,33
cgimage,r ,noerase=1,  position=pos[*,1]
imin=min(r)
imax=max(r)

kx=findgen(nx)-nx/2
ky=findgen(ny)-ny/2
cgcontour, r,kx,ky,/nodata,/noerase,    xtitle="k", ytitle="ky", position=pos[*,1], color='black'
cgcolorbar, Position=[pos[0,1], pos[1,1]-0.06, pos[2,1], pos[1,1]-0.05], range=[imin,imax], format='(G12.1)', annotatecolor='black'

 ;display, (abs(outarr)), ims=3, label1="k!Dx!N", /hbar
 end
