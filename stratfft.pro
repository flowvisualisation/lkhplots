
cgdisplay, xs=800,ys=800

nfile=46


nbeg=3
nend=nfile
spawn,'uname', listing
if ( listing ne 'Darwin') then begin
nbeg=2
nend=47
endif

for nfile=nbeg,nend,2 do begin
pload,nfile, /xyassoc




pos= cglayout([3,2] , OXMargin=[4,1], OYMargin=[9,6], XGap=4, YGap=9)



bnorm=1.0
;vec=bx1^2+bx2^2+bx3^2
tag='b'
;vec=bx1*bx2
tag='bxby'
;vecnorm=total(vec)/nx1/nx2/nx3
;vec=vec/vecnorm


nh1=3*nx3/4
nh1=7*nx3/8



;levh1=vec(*,*,nh1)
levh1=bx1(nh1)^2+bx2(nh1)^2+bx3(nh1)^2
fh1=alog10(nx1*nx2*abs(fft(levh1,/center)))
qsm=2
fh1=smooth(fh1,qsm)
nh0=nx3/2
;levh0=vec(*,*,nh0)
levh0=bx1(nh0)^2+bx2(nh0)^2+bx3(nh0)^2
fh0=alog10(nx1*nx2*abs(fft(levh0,/center)))
fh0=smooth(fh0,qsm)

datptr=ptrarr(12)
datptr(0)=ptr_new(fh0)
datptr(1)=ptr_new(levh1)
datptr(2)=ptr_new(fh1)
datptr(3)=ptr_new(fh1)
datptr(4)=ptr_new(levh0)
datptr(5)=ptr_new(fh0)

titstr=strarr(12)
titstr(0)='dummy'
h1tag=string(x3(nh1), format='(F4.2)')
h0tag=string(x3(nh0), format='(F4.2)')
titstr(1)='b(x,y,z='+h1tag+')'
titstr(2)='B(k!Dx!N,k!Dy!N), z='+string(x3(nh1), format='(F4.2)')
titstr(3)='dummy'
titstr(4)='b(x,y,z='+h0tag+')'
titstr(5)='B(k!Dx!N,k!Dy!N), z='+string(x3(nh0), format='(F4.2)')

xtitstr=strarr(12)
xtitstr(0)='dummy'
xtitstr(1)='x/H'
xtitstr(2)='k!Dx!N'
xtitstr(3)='dummy'
xtitstr(4)='x/H'
xtitstr(5)='k!Dx!N'


ytitstr=strarr(12)
ytitstr(0)='dummy'
ytitstr(1)='y/H'
ytitstr(2)='k!Dy!N'
ytitstr(3)='dummy'
ytitstr(4)='y/H'
ytitstr(5)='k!Dy!N'

xaxis1=fltarr(12)
xaxis1(0)=999.
xaxis1(1)=x1(nx1-1)-x1(0)
xaxis1(2)=nx2
xaxis1(3)=999.0
xaxis1(4)=x1(nx1-1)-x1(0)
xaxis1(5)=nx2

xaxis2=fltarr(12)
xaxis2(0)=999.0
xaxis2(1)=(x1(nx1-1)-x1(0))/2.
xaxis2(2)=nx2/2
xaxis2(3)=999.0
xaxis2(4)=(x1(nx1-1)-x1(0))/2.
xaxis2(5)=nx2/2

yaxis1=fltarr(12)
yaxis1(0)=999.0
yaxis1(1)=x2(nx2-1)-x2(0)
yaxis1(2)=nx2
yaxis1(3)=999.0
yaxis1(4)=x2(nx2-1)-x2(0)
yaxis1(5)=nx2

yaxis2=fltarr(12)
yaxis2(0)=999
yaxis2(1)=(x2(nx2-1)-x2(0))/2
yaxis2(2)=nx2/2
yaxis2(3)=999
yaxis2(4)=(x2(nx2-1)-x2(0))/2
yaxis2(5)=nx2/2

cgloadct,33




fname=tag+'slices'+string(nfile,format='(I03)')

for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet ;, /nomatch, xs=20, ys=5, /bold
charsize=cgdefcharsize()*1.1
pi_str='!9p!X'
   !P.CharThick = 8
endif else  begin
set_plot, 'x'
charsize=cgdefcharsize()*1.1
pi_str='!7p!X'
endelse



pload, nfile, x2range=[0,0], var="bx1"
pload, nfile, x2range=[0,0], var="bx2"
pload, nfile, x2range=[0,0], var="bx3"

cgerase
a=reform(bx1(*,0,*)^2+bx2(*,0,*)^2+bx3(*,0,*)^2)
print,max(a),min(a)



pos1=[pos[0,0],pos[1,3],pos[2,0],pos[3,0]]
d=alog10(a)
imin=min(d)
imax=max(d)
r=cgscalevector(d,1,254)
cgimage,r, pos=pos1
sz=size(d,/dimensions)
x=findgen(sz(0))/sz(0)-0.5
z=findgen(sz(1))/sz(1)*3-1.5
cgcontour, d, x1,x3, /nodata, pos=pos1, color='black', /noerase, $
    ;title='!9r!X', $
    charsize=cgDefCharsize()*.6,$
    title='B!U2!N', $
    xtitle='x/H', ytitle='z/H'
p=pos1
cgcolorbar, Position=[p[0], p[1]-0.07, p[2], p[1]-0.06], range=[imin,imax], format='(F5.1)', $
    charsize=cgDefCharsize()*.6

nplot=[1,2,4,5]

for myc=0,3 do begin
i=nplot[myc]
d=*datptr(i)
r=cgscalevector(d,1,254)
imin=min(d)
imax=max(d)
cgimage, r, pos=pos[*,i], /noerase
sz=size(d,/dimensions)
x=findgen(sz(0))/sz(0)*xaxis1(i)-xaxis2(i)
y=findgen(sz(1))/sz(1)*yaxis1(i)-yaxis2(i)
cgcontour, d,x,y, /nodata, pos=pos[*,i], color='black', /noerase, $
    charsize=cgDefCharsize()*.6,$
    title=titstr(i),$
    xtitle=xtitstr(i),$
    ytitle=ytitstr(i)
p=pos[*,i]
cgcolorbar, Position=[p[0], p[1]-0.07, p[2], p[1]-0.06], range=[imin,imax], $
    format='(F6.1)',$
    charsize=cgDefCharsize()*.6
endfor

cgtext, 0.2,0.95, "DFT at z="+h0tag+','+h1tag+", t/2"+pi_str+"="+string(t[nfile]/2/!DPI, format='(F4.1)')+' orbits', /normal


if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


endfor


end
