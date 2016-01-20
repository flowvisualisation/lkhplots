
cgloadct,33
spawn, 'ls usr*h5' , list
print, size(list, /dimensions)

sz=size(list, /dimensions)
nl=sz[0]

nr=2
nc=2
nplots=nr*nc

nxw=250
cgdisplay, xs=nxw*nr, ys=nxw*nc
pos=cglayout([nplots/nc,nc], OXMargin=[5,1], OYMargin=[9,2], XGap=1, YGap=1)

    r=h5_read( 0, /v,/remap)
    vy0=reform(r.v[1,*,*,*])

for i=0,nplots-1 do begin

    nst=i+(nl-nplots)
    str=strmid(list[nst],3,6)
    num=long(str)
    r=h5_read( num, /v,/remap)
    grd_ctl, model=num, g,c
    vx=reform(r.v[0,*,*,*])
    vy=reform(r.v[1,*,*,*])-vy0
    vz=reform(r.v[2,*,*,*])
    v2=vx^2+vy^2+vz^2

    
    b=reform( sqrt(v2[0,*,*]))
    a=logfft(b)
    nx=480
    ny=nx
        a=congrid(a,nx,ny)
        kx=findgen(nx)-nx/2
        ky=findgen(ny)-ny/2
    dat=congrid(abs(fft(b, /center)), nx,nx)
        gft=mpfit2dpeak(dat, aa,/tilt, /moffat)
        print, 'moffat power law index, ', aa[7]
    
    xtickf='(A1)'
    ytickf='(A1)'
    
    if ( i ge (nplots-nr) ) then begin
    xtickf='(I5)'
endif
    if ( (i mod nr) eq 0 ) then begin
    ytickf='(I5)'
    endif

    px=pos[*,i]
    cgimage, a, pos=px, /noerase, /keep_aspect
    cgcontour, a,kx, ky , pos=px, $ 
        /noerase, /nodata,$
        aspect=1, $
        xtickf=xtickf,$
        ytickf=ytickf
        cgcontour, gft,nlev=30, kx, ky, /overplot, pos=px
    cgtext, -200,200, 't='+string(c.time/2./!DPI, format='(F8.1)')+' orbits', color='white'
    
endfor

fname='timefft'
im=cgsnapshot(filename=fname, /jpeg, /nodialog)
end
