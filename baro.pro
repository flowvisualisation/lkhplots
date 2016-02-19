xs=600
ys=2*xs
;cgdisplay, xs=xs, ys=ys
pload,0
minrho=99
maxrho=0
minv=99
maxv=-5
for i=0,nlast do begin
pload,i, /silent
minrho=min ([minrho, min(rho)])
maxrho=max ([maxrho, max(rho)])
minv=min ([minv, min(vx2)])
maxv=max ([maxv, max(vx2)])
endfor
print, minv



usingps=0
spawn, 'basename $PWD', dirtag
fname="timehistory"+dirtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omegastr='!9W!X'
rhostr='!9r!X'
endif else  begin
set_plot, 'x'
omegastr='!7X!X'
rhostr='!7q!X'
charsize=cgdefcharsize()*.6
endelse


pos=cglayout([1,2], xgap=7, ygap=12, oxmargin=[11,5], oymargin=[12,5])

px=pos[*,0]
ymin=minrho*.3
ymax=maxrho*1.2
cgplot,x2,  rho(0,*), /ylog , xrange=[0,1.2], yrange=[ymin,ymax], ytitle='log '+rhostr, xtitle='y',pos=px, title='t='+string(t(nlast))+', nz='+string(nx2)

for i=0,nlast do begin 
pload,i,/silent 
cgplot,x2,  rho(0,*),  /overplot, linestyle=i, pos=px
cgtext, x2[nx2-1], rho(0,nx2-1), ' t='+string(t(i), format='(F4.1)')
endfor


px=pos[*,1]
ymin=minv
ymax=maxv
cgplot,x2,  vx2(0,*),  xrange=[0,1.2], yrange=[ymin,ymax], ytitle='V!DY!N', xtitle='y',pos=px, /noerase
for i=0,nlast do begin 
pload,i,/silent 
cgplot,x2,  vx2(0,*),  /overplot, linestyle=i, pos=px
cgtext, x2[nx2-1], rho(0,nx2-1), ' t='+string(t(i), format='(F4.1)')
endfor

if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor




end
