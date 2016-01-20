
cgloadct,33
spawn, 'ls usr*h5' , list
print, size(list, /dimensions)

sz=size(list, /dimensions)
nl=sz[0]

nr=2
nc=2
nplots=nr*nc

nxw=1100/nr
cgdisplay, xs=nxw*nr, ys=nxw*nc

pos=cglayout([nplots/nc,nc], OXMargin=[5,1], OYMargin=[9,2], XGap=5, YGap=5)

    r=h5_read( 0, /v,/remap)
    vy0=reform(r.v[1,*,*,*]*1.0d)

for i=0,nplots-1 do begin

    nst=i+(nl-nplots)
    str=strmid(list[nst],3,6)
    num=long(str)
    r=h5_read( num, /v,/remap)
    grd_ctl, model=num, g,c
    vx=reform(r.v[0,*,*,*])*1.0d
    vy=reform(r.v[1,*,*,*]*1.0d)-vy0
    vz=reform(r.v[2,*,*,*])*1.0d
    v2=vx^2+vy^2+vz^2

    
    b=reform(sqrt( v2[0,*,*]))
    a=logfft(b)
    nx=g.ny-1
    ny=nx
        a=congrid(a,nx,ny)
        kx=findgen(nx)-nx/2
        ky=findgen(ny)-ny/2
    ;dat=smooth(congrid(abs(fft(b, /center)), nx,nx),5)
    dat=smooth(congrid(alog10(abs(fft(b, /center))), nx,nx),10)
;    gft=gauss2dfit(dat, aa,/tilt)
moffat=1
if (moffat eq 1) then begin
      gft=mpfit2dpeak(dat, aa,/tilt, /moffat)
      print, 'moffat power law index, ', 2*aa[7]
      endif else  begin
      gft=mpfit2dpeak(dat, aa,/tilt, /lorentzian)
      endelse


    
    xtickf='(A1)'
    ytickf='(A1)'
    
    nr=6
    if ( i ge (nplots-nr) ) then begin
    xtickf='(I5)'
endif
    if ( (i mod nr) eq 0 ) then begin
    ytickf='(I5)'
    endif

    px=pos[*,i]

    
    cl=['red', 'blue', 'red', 'blue']
    ls=[0,0,2,2]


th=aa[6]
print, 'angle= ',aa[6]*!RADEG
xi=ky
yi=ky
xq=nx/2+xi*cos(th) - yi *sin(th)
yq=ny/2+xi*sin(th) + yi *cos(th)
th2=aa[6]-!DPI/2.0d
xq2=nx/2+xi*cos(th2) - yi *sin(th2)
yq2=ny/2+xi*sin(th2) + yi *cos(th2)

;datshift=shift(dat, nx/2, ny/2)
maxstress=interpolate(dat,xq,yq)
maxstress2=interpolate(dat,xq2,yq2)
myax=sqrt(xq^2+yq^2)
;gftshift=shift(gft, nx/2, ny/2)
maxgft=interpolate(gft,xq,yq)
maxgft2=interpolate(gft,xq2,yq2)
myax=sqrt(xq^2+yq^2)


    cgplot, xi, maxstress,  pos=px,            color=cl[0], linest=ls[0], /noerase, $
        /xlog, $
        xrange=[1,240],$
        xtickf=xtickf, xstyle=1;, xrange=[-100,100]
    cgplot, xi,maxgft  ,pos=px,             /overplot, color=cl[1], linest=ls[1]
    cgplot, xi, maxstress2,pos=px,             /overplot, color=cl[2], linest=ls[2]
    cgplot, xi, maxgft2,pos=px,             /overplot, color=cl[3], linest=ls[3]

    ;cgtext, 1,1, 't='+string(c.time, format='(F5.1)'), color='white'
    
endfor

fname='timefftcut'
im=cgsnapshot(filename=fname, /jpeg, /nodialog)

end
