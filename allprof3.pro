cgdisplay, xs=1000,ys=800

if ( firstcall eq !NULL ) then begin
tor=h5_parse('tor/profile.h5', /read_data)
nvf=h5_parse('nvf/profile.h5', /read_data)
znf=h5_parse('znf/profile.h5', /read_data)
firstcall=1
endif

pos = cglayout([1,3] , OXMargin=[9,2], OYMargin=[12,1], XGap=3, YGap=2)

dat=ptrarr(3)
dat[0]=ptr_new(tor)
dat[1]=ptr_new(nvf)
dat[2]=ptr_new(znf)

titstr=strarr(3)
titstr(0)='NTF'
titstr(1)='NVF'
titstr(2)='ZNF'


cgloadct,0



fname="spacetimebz"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse



for i=0,2 do begin
a=(*dat[i]).by._DATA
;a=(*dat[i]).uz._DATA
ainit1d=reform(a[0,*])
ny=size(ainit1d, /dimensions)
sz=size(a,/dimensions)
nx=sz(0)
ainit=rebin(reform(ainit1d,1,ny),nx,ny)
a=a-ainit
t=(*dat[i]).time._DATA
z=(*dat[i]).z._DATA
sgn=signum(a)
cgloadct,33
a=alog10(abs(a))*sgn
;a=a
;cgloadct,0
;a=sgn
qxq=where(t ge 50)
gg=a[0:qxq[0],*]

xtick=1
xtickf="(a1)"
xtit=''
if ( i eq 2 ) then begin
xtick=2
xtickf="(I2)"
xtit='time (orbits)'
endif
r=cgscalevector(gg,1,254)
cgimage, (gg), pos=pos[*,i], /noerase
cgcontour, (a),t,z, pos=pos[*,i], /noerase, $
    ;/fill, nlev=64,  $
    /nodata,  $
    xrange=[0,50],$
    xtickf=xtickf, $
    xtitle=xtit, $
    ytitle=titstr(i)+', z/H'
endfor

;cgtext, .1,.95, 'Signed log of horizontally averaged azimuthal field,  sgn(B!DY!N(z,t))', /normal

if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor

end
