

nx=300
ny=300


xvec=findgen(nx)/nx-0.5
x=rebin(reform(xvec, nx, 1 ), nx,ny)
yvec=findgen(ny)/ny-0.5
y=rebin(reform(xvec, 1, ny ), nx,ny)

inarr= cos(32* 2*!PI*(x+y)) $
		+ 2*sin(16*2*!PI *(x-y)) 
		
inarr= sqrt(0.5*x^2 + y^2) lt 0.1
inarr= sqrt( (( x+y)^2)/4 + ((y-x)^2)/2) lt 0.1

time=1.6
time=1.2
;time=0
 fftrotate, inarr, outarr, time


cgloadct,33
;window, xs=1300, ys=1100
cgDisplay, WID=1, location=[1200,800],xsize=1300, ysize=800
!p.position=0
!p.multi=0
pos = cgLayout([2,1], OXMargin=[5,5], OYMargin=[5,12], XGap=3, YGap=10)
;pos=[0.1,0.2,0.9,0.9]
cgimage, scale_vector(inarr,1,255), noerase=0, position=pos[*,0]

abs_o=abs(outarr)
logabs_o=alog10(abs_o)
shiftlogabs_o=shift(logabs_o, nx/2,ny/2)
r=scale_vector( shiftlogabs_o,1,255)

cgloadct,33
cgimage,r ,noerase=1,  position=pos[*,1]
;cgcontour, xx,/nodata,  /onimage, /overplot, xtitle="k", ytitle="ky"
 ;display, (abs(outarr)), ims=3, label1="k!Dx!N", /hbar
 end


