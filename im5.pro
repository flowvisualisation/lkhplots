pro im5, imarr, titstr, xtitstr, ytitstr, xarr, yarr, k1arr, k2arr, im2arr, xtfarr, ytfarr

cgdisplay, xs=1200,ys=1200
pos=cglayout([2,3],  xgap=4, ygap=6, oxmargin=[15,1], oymargin=[14,1])
fname='comparison'


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

for i=0,2 do begin
imx=*(imarr[i])
px=pos[*,2*i]
dat=reform(imx)
cgimage,dat, pos=px, /noerase, /keep_aspect
cgcontour, dat,*(xarr[i]), *(yarr[i]), /nodata, /noerase, ytitle=ytitstr[i] , pos=px, aspect=1./3., xtickf=xtfarr[i]

px=pos[*,2*i+1]
dat=*(im2arr[i])
cgimage, dat, pos=px, /noerase, /keep_aspect
cgcontour, *(im2arr[i]) ,*(k1arr[i]), *(k2arr[i]),  /noerase, pos=px, aspect=1., xrange=[-960,960], yrange=[-960,960], nlev=64, /fill, /nodata, xtickf=xtfarr[i]
imin=min(dat)
imax=max(dat)
print, imin,imax
cgcolorbar, /vertical, range=[imin, imax], pos=[px[2]+0.05, px[1], px[2]+0.06, px[3]]
endfor



if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor





end
