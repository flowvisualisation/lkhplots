
cgdisplay, xs=1200,ys=1240

nfile=50
nbeg=0
nend=5000



spawn, 'ls Data/fields*', flist
a=size(flist, /dimensions)
ba= flist(a-2)

nlaststr=reform(strmid(ba, 12,6))
nlast=uint(nlaststr)

nlast2=nlast[0]
;help, nlast2
nbeg=max([nlast2-10,0])
nstep=10
for nfile=nbeg,nlast2,nstep do begin
print, nfile
if ( file_test('Data/fields-'+String(nfile,format='(I06)')+'.dat' ) ne 1) then begin
print, 'File does not exist ... exiting'
break
endif
p=rp(nfile)
f=rf(nfile)

pos = cglayout([1,4] , OXMargin=[8,10], OYMargin=[5,5], XGap=5, YGap=6)

samp=500
vmax=1.1*max(p.p(*,2,0))
;expx=hist_2d(p.r(*,2,0), p.p(*,2,0), bin1=p.s.gn(2)/samp, bin2=(2*vmax)/samp, max2=vmax,min2=-vmax)
expx=hist_2d( [ p.r(*,2,0), p.r(*,2,2) ] , [p.p(*,2,0), p.p(*,2,2)] , bin1=p.s.gn(2)/samp, bin2=(2*vmax)/samp, max2=vmax,min2=-vmax)
expx=alog10(expx+9e-1)
sz=size(expx, /dimensions)
expx=expx(1:sz(0)-1,*)

vmax2=1.1*max(p.p(*,2,1))
ixpx=hist_2d([ p.r(*,2,1),p.r(*,2,3) ], [p.p(*,2,1),p.p(*,2,3)  ] , bin1=p.s.gn(2)/samp, bin2=(2*vmax2)/samp, max2=vmax2,min2=-vmax2)
ixpx=alog10(ixpx+9e-1)
sz=size(ixpx, /dimensions)
ixpx=ixpx(1:sz(0)-1,*)

cgloadct,33
tvlct,255,255,255,0
tvlct,255,255,255,1
tvlct,255,255,255,2
tvlct,255,255,255,3
;cgerase

sz=size(expx, /dimensions)
x2=findgen(sz(1))/sz(1)*(vmax+vmax)-vmax
x1=findgen(sz(0))/sz(0)*p.s.gn[2]- p.s.gn[2]/2

lambda_str='!9l!X'


spawn, 'basename $PWD', dirtag
fname="pic1d"+dirtag+string(nfile, format='(I07)')
for usingps=0,0 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
omega_str='!9W!X'
lambda_str='!9l!X'
!p.charsize=0.9
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
lambda_str='!7k!X'
!p.charsize=1
endelse


xtitle='xpos ['+lambda_str+'!De!N]'

px=pos(*,0)
sz=size(expx, /dimensions)
x1=findgen(sz(0))/sz(0)*p.s.gn[2]- p.s.gn[2]/2
x2=findgen(sz(1))/sz(1)*(vmax+vmax)-vmax
cgimage, cgscalevector(expx,1,254), pos=px
cgcontour, expx,x1,x2,/nodata,/noerase, pos=px, title='elec, t='+string(p.s.ptime), ytitle='v!Delec!N/c', xtitle=xtitle
imin=min(expx)
imax=max(expx)
cgcolorbar, range=[imin,imax], /vertical, pos=[px[2]+0.03,px[1],px[2]+0.05,px[3]]


sz=size(ixpx, /dimensions)
x1=findgen(sz(0))/sz(0)*p.s.gn[2]- p.s.gn[2]/2
x2=findgen(sz(1))/sz(1)*(vmax2+vmax2)-vmax2
px=pos(*,1)
cgimage, cgscalevector(ixpx,1,254), pos=px, /noerase
cgcontour, ixpx,x1,x2,/nodata,/noerase, pos=px, ytitle='ions', xtitle=xtitle
imin=min(expx)
imax=max(expx)
cgcolorbar, range=[imin,imax], /vertical, pos=[px[2]+0.03,px[1],px[2]+0.05,px[3]]




zz=480
sz=size(reform( f.d(0,0,*,0)), /dimensions)

xx=findgen(sz(0))-sz(0)/2
cgplot, xx, f.d(0,0,*,0)+f.d(0,0,*,2), ytitle='ion,elec density', xtitle='xpos', pos=pos[*,2], /noerase,xstyle=1
cgplot, xx, f.d(0,0,*,1)+f.d(0,0,*,3), pos=pos[*,2], /noerase, /overplot, color='red'

cgplot, xx, f.bz(0,0,*), title='Bz', xtitle='xpos', pos=pos[*,3], /noerase,xstyle=1, color='blue'
cgplot, xx, f.bx(0,0,*), /overplot, pos=pos[*,3], /noerase,xstyle=1, color='red'
cgplot, xx, f.by(0,0,*), /overplot, pos=pos[*,3], /noerase,xstyle=1, color='green'

items=['bx','by','bz']
colors=['red','green','blue']
linestyle=[0,0,0]
al_legend, items, linestyle=linestyle, color=colors


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor

endfor
end
