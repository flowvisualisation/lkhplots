
nfile=40
pload,nfile, dir='forcing01', var="vx1"
v01=vx1(*,*,0)
nfile=16
pload,nfile, dir='forcing', var="vx1"
v15=vx1(*,*,0)
nfile=90
pload,nfile, dir='forcing19', var="vx1"
v19=vx1(*,*,0)

qarr=[0.1,1.5,1.9]


pos=cglayout( [3,1], oxmargin=[11,1], oymargin=[11,1], xgap=1, ygap=11)

dptr=ptrarr(12)
dptr[0]=ptr_new(fft(v01,/center))
dptr[1]=ptr_new(fft(v15,/center))
dptr[2]=ptr_new(fft(v19,/center))

xs=1500
ys=600
cgloadct,33
cgdisplay,xs=xs,ys=ys

usingps=0
spawn, 'basename $PWD', dirtag
fname="forcefft"
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



sz=size(v01, /dimensions)


nx=sz[0]
ny=sz[1]
kx=findgen(nx)-nx/2
ky=findgen(ny)-ny/2
for i=0,2 do begin

ytickf="(a1)"
ytit=''

if ( i eq 0 ) then begin
ytickf="(I4)"
    ytit="k!Dy!N"
endif
dat=alog10(abs(*dptr[i]))

r=cgscalevector(dat,0,254)
px=pos[*,i]
cgimage, r, pos=px, /noerase ;, /keep_aspect_ratio
cgcontour,findgen(nx,ny), kx,ky,/noerase, /nodata, pos=px, $
    charsize=charsize,$
    ytickf=ytickf,$
    xtitle="k!Dx!N",$
    ytitle=ytit
    cgtext, -70,50, "q="+string(qarr[i], format='(F4.1)'), color='black', charsize=1.1*cgdefcharsize()

endfor


if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor

end
