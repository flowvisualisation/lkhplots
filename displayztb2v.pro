
ys=600
xs=ys
cgdisplay, xs=xs,ys=ys
r=h5_parse("poyntingave0778000hdf5_out.h5",/read_data )


dat= r.SAMPLE_DATA._DATA

print, max(dat), min(dat)
grd_ctl, model=100000, g,c
t1=c.time/2./!DPI
grd_ctl, model=790000, g,c
t2=c.time/2./!DPI


usingps=0
spawn, 'basename $PWD', dirtag
fname="spacetimeb2v"+dirtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*.6
endelse


rainbow_Colors
pos=cglayout([1,2], oxmargin=[12,12], oymargin=[12,12] ,ygap=12)
r=cgscalevector(dat, 1,254)
cgimage, r, pos=pos[*,0], Stretch='Clip', Clip=1
sz=size(dat, /dimensions)
tarr=dindgen(sz(0))/sz(0)*(t2-t1)+t1
ave=total(dat,1)/sz(0)
ave=mean(dat,dimension=1)
px=pos[*,0]
imin=min(dat)
imax=max(dat)
cgcontour, dat, tarr,g.z , /noerase, /nodata, pos=px, title='Mag. Energy Flux, t='+string(c.time/2.0/!DPI, format='(I5)')+' orbits', $
    xtitle="t [orbits]",$
    ytitle="z/H"
cgcolorbar, range=[imin,imax], /vertical, pos=[px[2]+0.0, px[1],px[2]+0.03, px[3]], /right
px=pos[*,1]
cgplot, g.z, ave, title="Magnetic Energy Flux , B!U2!Nv!Dz!N", pos=px, /noerase,$
    ytitle="B!U2!Nv!Dz!N",$
    xtitle="z/H", yrange=[min(bot),max(top)]
    sig=stddev(dat, dimension=1)
    top= ave+sig
    bot= ave-sig
    zh=g.z
cgcolorfill,[zh,reverse(zh)],[bot,reverse(top)],/data, color='grey'
cgplot, g.z, ave, pos=px, /overplot


if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor



end
