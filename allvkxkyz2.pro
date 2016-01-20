cgdisplay, xs=1200,ys=400

if ( firstcall eq !NULL ) then begin
tor=h5_parse('tor/vkxkyz0712000.h5', /read_data)
nvf=h5_parse('nvf/vkxkyz0712000.h5', /read_data)
znf=h5_parse('znf/vkxkyz0712000.h5', /read_data)
firstcall=1
endif

pos = cglayout([3,1] , OXMargin=[6,3], OYMargin=[7,1], XGap=3, YGap=2)

dat=ptrarr(3)
dat[0]=ptr_new(tor)
dat[1]=ptr_new(nvf)
dat[2]=ptr_new(znf)

titstr=strarr(3)
titstr(0)='NTF'
titstr(1)='NVF'
titstr(2)='ZNF'


cgloadct,0



fname="vkxkyz2"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
charsize=cgdefcharsize()*.5
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*.8
endelse


for i=0,2 do begin
a=(*dat[i]).kyz._DATA
;a=(*dat[i]).uz._DATA
ainit1d=reform(a[0,*])
ny=size(ainit1d, /dimensions)
sz=size(a,/dimensions)
nx=sz(0)
nz=sz(1)
t=findgen(nx)
z=findgen(sz(1))/sz(1)*8-4
sgn=signum(a)
cgloadct,33
;a=alog10(abs(a))*sgn
;a=a
;cgloadct,0
;a=sgn
qxq=where(t ge 50)
gg=a[0:qxq[0],*]
r=cgscalevector(gg,1,254)
;cgimage, (gg), pos=pos[*,i], /noerase
    
    ytick=2
ytickf="(a1)"
ytit=''
if ( i eq 0 ) then begin
ytick=1
ytickf="(I2)"
ytit='z/H'
endif

arr=fltarr(nz)
for qi=0,nz-1 do begin
axa=where( a(*,qi) lt 0.5*(max(a(*,qi)) -min(a(*,qi)) ) )
arr[qi]=axa[0]


endfor

lev=0.4*(min(a)+max(a))

cgcontour, (a),t,z, pos=pos[*,i], /noerase, $
    /fill, nlev=64,  $
    /xlog, $
    charsize=charsize,$
    ;title=titstr[i], $
    yTICKFORMAT=ytickf,$
    xrange=[1,120],$
    xtitle='k!Dy!N ', $
    ytitle=ytit
    cgcontour, smooth(a,10), t,z,/overplot, lev=lev, label=''
    cgtext, 40,2.5, titstr[i],charsize=charsize
endfor

;cgtext, .1,.95, 'xxx' /normal

if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage, DELETE_PS=0
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor

end
