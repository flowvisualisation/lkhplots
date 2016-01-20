
if ( firstcall eq !NULL ) then begin
nfile=712000
dat=h5_read(nfile, /v,/rho,/b,  /remap) 
grd_ctl, model=nfile, g,c
nx=g.nx
ny=g.ny
nz=g.nz
firstcall=1
endif

b1=transpose(reform(dat.b(0,*,*,*)))
b2=transpose(reform(dat.b(1,*,*,*)))
b3=transpose(reform(dat.b(2,*,*,*)))
v3=transpose(reform(dat.v(2,*,*,*)))

slarr=[nz/2, 11*nz/16, 7*nz/8]


for qq=0,2 do begin
sl=slarr[qq]
bx=reform(b1(*,*,sl))
by=reform(b2(*,*,sl))
bz=reform(b3(*,*,sl))
;by=(bx^2+by^2+bz^2)
;by=by^2
by=by/abs(mean(by))
vz=reform(v3(*,*,sl))


highpass=1


; compute fft by
; apply butterworth filter
; inverse fft 

filterhp = BUTTERWORTH(nx,ny, cutoff=30, order=11, /origin)
byhp = real_part(FFT( FFT(by, -1) * filterhp, 1 ))


   vzhp=vz


filterlp = BUTTERWORTH(nx,ny, cutoff=10, order=11 )
bylp = real_part(FFT( FFT(by, -1) * filterlp, 1 ))

   vzlp=vz


mn1=min([vzhp,vzlp])
mx1=max([vzhp,vzlp])
mn2=min([byhp,bylp])
mx2=max([byhp,bylp])
;mx2=max([mx2, abs(mn2)])
;mx1=max([mx1, abs(mn1)])
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
pos=cglayout([5,1] , OXMargin=[8,4], OYMargin=[11,6], XGap=9, YGap=12)
cgdisplay,xs=1500,ys=400

spawn, 'basename $PWD', dirtag
fname="filz"+string(g.z(sl), format='(I1)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times' , font=1;, /quiet
omega_str='!9W!X'
charsize=cgdefcharsize()*0.6
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse

cgloadct,33
cgcontour, by,g.x,g.y, $
charsize=charsize,$
    /fill, nlev=32, $
    title='B!Dy,orig!N, z/H='+string(g.z(sl), format='(I3)'),$
    xtitle='x', $
    ytitle='y', pos=pos(*,0)

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

if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100 ;, /nomessage
;cgps_close ;, /jpeg,  Width=1100 ;, /nomessage
endif else begin
fname2=fname
endelse

endfor


endfor

end

