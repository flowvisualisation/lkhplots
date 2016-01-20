cgdisplay,xs=1700,ys=800

;if ( firstcall eq !NULL ) then begin
nfile=712000L
nfile=790000L
nbeg=nfile
nend=nfile
nstep=2000L


spawn,'uname', listing
if ( listing ne 'Darwin') then begin
nbeg=322000
nbeg=714000L
nend=9998000L
nstep=2000L
nfile=986000L
endif

for nfile=nbeg, nend, nstep do begin

dat=h5_read(nfile, /v,/rho,/b,  /remap) 
grd_ctl, model=nfile, g,c
nx=g.nx
ny=g.ny
nz=g.nz
;firstcall=1
;endif


rho=transpose(reform(dat.rho(*,*,*)))
b1=transpose(reform(dat.b(0,*,*,*)))
b2=transpose(reform(dat.b(1,*,*,*)))
b3=transpose(reform(dat.b(2,*,*,*)))
v3=transpose(reform(dat.v(2,*,*,*)))

slarr=[nz/2, 11*nz/16, 7*nz/8, 15*nz/16]


for qq=2,2 do begin
sl=slarr[qq]
bx=reform(b1(*,*,sl))
by=reform(b2(*,*,sl))
bz=reform(b3(*,*,sl))
den=reform(rho(*,*,sl))
;by=(bx^2+by^2+bz^2)
;by=by^2
by=by/abs(max(by))
by=den/mean(den)
vz=reform(v3(*,*,sl))
by=vz
vz=den/mean(den)


fftby=fft(by, /center)
fit=alog10(abs(smooth(fftby,6)))
fit=abs(fftby)
gft=gauss2dfit(fit, aa,/tilt)
kxarr=(1./2.-findgen(nx)/nx)*ny
kyarr=(ny)/2.-findgen(ny)
print, 'Angle ', aa[6]*!RADEG


print, max(gft) , min(gft)


idlfilhp=gft
idlfillp=gft
idlfilhp(*,*)=1
idlfillp(*,*)=0
for i=0,nx-1 do begin
for j=0,ny-1 do begin
thres=gft[nx/2+15,ny/2+0]
;thres=1.1*max(gft)
if ( gft[i,j] gt thres) then begin
idlfilhp[i,j]=0
idlfillp[i,j]=1
endif
endfor
endfor

nxp=nx
nyp=ny
idlfillp=idealf(nxp,nyp, 42*!DTOR)
scrh=where(idlfillp(nx/2, ny/2:ny-1) lt 0.5)
scrh=scrh(0)
scrh=sqrt(2*scrh^2)
print, 'fil cut off', scrh(0)
idlfilhp=1-idlfillp

; compute fft by
; apply butterworth filter
; inverse fft 

filterhp = 1-BUTTERWORTH(nx,ny, cutoff=30, order=11)
filterhp=shift(idlfilhp,nx/2,ny/2)
byhp = real_part(FFT( FFT(by, -1) * filterhp, 1 ))
;byhp=bandpass_filter ( by , .4,1)


   vzhp=vz


filterlp = BUTTERWORTH(nx,ny, cutoff=10, order=11 )
filterlp=shift(idlfillp,nx/2,ny/2)
bylp = real_part(FFT( FFT(by, -1) * filterlp, 1 ))

   vzlp=vz


mn1=min([vzhp,vzlp])
mx1=max([vzhp,vzlp])
mn2=min([byhp,bylp])
mx2=max([byhp,bylp])
;mx2=max([mx2, abs(mn2)])
mx1=max([mx1, abs(mn1)])
;mn1=-mx1
;mx2=3.0
;mn2=-1.0

c=vzhp
d=byhp
sz=size(vz, /dimensions)
c=reform(c,sz(0)*sz(1))
d=reform(d,sz(0)*sz(1))
nsize=256
;mn1=min(c)
;mx1=max(c)
;mn2=min(d)
;mx2=max(d)
print,mn1, mx1, mn2, mx2
bn1=(mx1-mn1)/nsize
bn2=(mx2-mn2)/nsize
histhp = HIST_2D(c,d,MIN1=mn1, MAX1=mx1,  MIN2=mn2, MAX2=mx2, BIN1=bn1, BIN2=bn2)
x1hp=findgen(nsize+1)*bn1+mn1
x2hp=findgen(nsize+1)*bn2+mn2


c=vzlp
d=bylp
sz=size(vz, /dimensions)
c=reform(c,sz(0)*sz(1))
d=reform(d,sz(0)*sz(1))
nsize=256
;mn1=min(c)
;mx1=max(c)
;mn2=min(d)
;mx2=max(d)
bn1=(mx1-mn1)/nsize
bn2=(mx2-mn2)/nsize
histlp = HIST_2D(c,d,MIN1=mn1, MAX1=mx1,  MIN2=mn2, MAX2=mx2, BIN1=bn1, BIN2=bn2)
x1lp=findgen(nsize+1)*bn1+mn1
x2lp=findgen(nsize+1)*bn2+mn2

!p.position=0
pos=cglayout([5,2] , OXMargin=[16,4], OYMargin=[11,6], XGap=13, YGap=16)

spawn, 'basename $PWD', dirtag
tagh=string(g.z(sl), format='(I1)')
tagtime=string( nfile, format='(I06)')
fname="filz_vzrho"+tagh+tagtime
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times' , font=1;, /quiet
omega_str='!9W!X'
charsize=cgdefcharsize()*0.6
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
cgerase
endelse


datarr=ptrarr(10)
datarr[0]=ptr_new(by)
datarr[1]=ptr_new(bylp)
datarr[2]=ptr_new(byhp)
datarr[3]=ptr_new(alog10(histlp+.1))
datarr[4]=ptr_new(alog10(histhp+.1))
datarr[5]=ptr_new(shift(filterlp,nx/2,ny/2))
datarr[6]=ptr_new(shift(filterhp,nx/2,ny/2))
datarr[7]=ptr_new(alog10(abs(fft(by, /center))))
datarr[8]=ptr_new(alog10(abs(fft(bylp, /center))))
;datarr[8]=ptr_new(gft)
datarr[9]=ptr_new(alog10(abs(fft(byhp, /center))))

xarr=ptrarr(10)
xarr[0]=ptr_new(g.x)
xarr[1]=ptr_new(g.x)
xarr[2]=ptr_new(g.x)
xarr[3]=ptr_new(x1hp)
xarr[4]=ptr_new(x1lp)
xarr[5]=ptr_new(kxarr)
xarr[6]=ptr_new(kxarr)
xarr[7]=ptr_new(kxarr)
xarr[8]=ptr_new(kxarr)
xarr[9]=ptr_new(kxarr)

yarr=ptrarr(10)
yarr[0]=ptr_new(g.y)
yarr[1]=ptr_new(g.y)
yarr[2]=ptr_new(g.y)
yarr[3]=ptr_new(x2hp)
yarr[4]=ptr_new(x2lp)
yarr[5]=ptr_new(kyarr)
yarr[6]=ptr_new(kyarr)
yarr[7]=ptr_new(kyarr)
yarr[8]=ptr_new(kyarr)
yarr[9]=ptr_new(kyarr)

tagv1='V!Dz!N'
tagv2='rho'
titstr=strarr(10)
titstr[0]=tagv1+ ', z/H='+string(g.z(sl), format='(I3)')
titstr[1]=tagv1+'!Dlarge!N'
titstr[2]=tagv1+'!Dsmall!N'
titstr[3]=tagv1+'!Dlarge!N vs '+tagv2
titstr[4]=tagv1+'!Dsmall!N vs '+tagv2
titstr[5]='LP Filter '
titstr[6]='HP Filter '
titstr[7]='DFT B!Dy!N'
titstr[8]='DFT B!Dy,large!N'
titstr[9]='DFT B!Dy,small!N'

xtitstr=strarr(10)
xtitstr[0]='x'
xtitstr[1]='x'
xtitstr[2]='x'
xtitstr[3]=tagv2
xtitstr[4]=tagv2
xtitstr[5]='k!Dx!N'
xtitstr[6]='k!Dx!N'
xtitstr[7]='k!Dx!N'
xtitstr[8]='k!Dx!N'
xtitstr[9]='k!Dx!N'


ytitstr=strarr(10)
ytitstr[0]='y'
ytitstr[1]='y'
ytitstr[2]='y'
ytitstr[3]=tagv1
ytitstr[4]=tagv1
ytitstr[5]='k!Dy!N'
ytitstr[6]='k!Dy!N'
ytitstr[7]='k!Dy!N'
ytitstr[8]='k!Dy!N'
ytitstr[9]='k!Dy!N'

xtfstr=strarr(10)
xtfstr[0]='(F6.1)'
xtfstr[1]='(F6.1)'
xtfstr[2]='(F6.1)'
xtfstr[3]='(F6.1)'
xtfstr[4]='(F6.1)'
xtfstr[5]='(I6)'
xtfstr[6]='(I6)'
xtfstr[7]='(I6)'
xtfstr[8]='(I6)'
xtfstr[9]='(I6)'


for qi=0,9 do begin
cgloadct,33
datq=*datarr[qi]
xax=*xarr[qi]
yax=*yarr[qi]
r=cgscalevector(datq, 1,254)
cgcontour, r,xax,yax, $
charsize=charsize,$
    /fill, nlev=32, $
    /noerase, $
    title=titstr[qi], $
    xtitle=xtitstr[qi], $
    ytitle=ytitstr[qi], $
    xticks=4, $
    yticks=4, $
    xtickformat=xtfstr[qi], $
    ytickformat=xtfstr[qi], $
    pos=pos(*,qi)
endfor

doman=0
if ( doman eq 1) then begin
cgloadct,33
cgcontour, by,g.x,g.y, $
charsize=charsize,$
    /fill, nlev=32, $
    title='B!Dy,orig!N, z/H='+string(g.z(sl), format='(I3)'),$
    xtitle='x', $
    ytitle='y', pos=pos(*,qi)

cgcontour, bylp, g.x,g.y, $
pos=pos[*,1], /noerase,$
   charsize=charsize,$
    /fill, nlev=32, $
    title='B!Dy,large!N',$
    xtitle='x',$
    ytitle='y'

cgcontour, alog10(abs(byhp)), g.x, g.y,$
pos=pos[*,2], /noerase,$
   charsize=charsize,$
    /fill, nlev=32, $
    title='B!Dy,small!N'+string(max(byhp), format='(F6.1)'),$
    xtitle='x',$
    ytitle='y'

;cgloadct,0, /reverse
cgcontour, alog10(histlp+.1),x1lp,x2lp, $
pos=pos[*,3], /noerase,$
   charsize=charsize,$
    /fill, nlev=32, $
    title='B!Dy,large!N vs V!Dz!N',$
    xticks=3, $
    xtickformat='(F4.1)', $
    xtitle='vz',$
    ytitle='B!Dy,large!N'


cgcontour, alog10(histhp+.1),x1hp,x2hp, $
pos=pos[*,4], /noerase,$
   charsize=charsize,$
    /fill, nlev=32, $
    title='B!Dy,small!N vs V!Dz!N',$
    xticks=3, $
    xtickformat='(F4.1)', $
    xtitle='vz',$
    ytitle='B!Dy,small!N'
    endif

;endfor

if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100 ;, /nomessage
;cgps_close ;, /jpeg,  Width=1100 ;, /nomessage
endif else begin
fname2=fname
endelse

endfor


endfor

endfor

end

