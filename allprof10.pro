cgdisplay, xs=900,ys=1150

if ( firstcall eq !NULL ) then begin
q01=h5_parse('q01/profile.h5', /read_data)
q03=h5_parse('q03/profile.h5', /read_data)
q05=h5_parse('q05/profile.h5', /read_data)
q07=h5_parse('q07/profile.h5', /read_data)
q11=h5_parse('q11/profile.h5', /read_data)
q12=h5_parse('q12/profile.h5', /read_data)
q13=h5_parse('q13/profile.h5', /read_data)
q14=h5_parse('q14/profile.h5', /read_data)
q15=h5_parse('q15/profile.h5', /read_data)
q16=h5_parse('q16/profile.h5', /read_data)
q17=h5_parse('q17/profile.h5', /read_data)
q18=h5_parse('q18/profile.h5', /read_data)
q19=h5_parse('q19/profile.h5', /read_data)
firstcall=1
endif

pos = cglayout([2,6] , OXMargin=[9,2], OYMargin=[12,1], XGap=10, YGap=1)

dat=ptrarr(12)
dat[0]=ptr_new(q01)
dat[1]=ptr_new(q03)
dat[2]=ptr_new(q05)
dat[3]=ptr_new(q07)
dat[4]=ptr_new(q11)
dat[5]=ptr_new(q12)
dat[6]=ptr_new(q13)
dat[7]=ptr_new(q14)
dat[8]=ptr_new(q15)
dat[9]=ptr_new(q16)
dat[10]=ptr_new(q17)
dat[11]=ptr_new(q19)
dat[7]=ptr_new(q19)

titstr=strarr(12)
titstr(0) ='q=0.1'
titstr(1) ='q=0.3'
titstr(2) ='q=0.5'
titstr(3) ='q=0.7'
titstr(4) ='q=1.1'
titstr(5) ='q=1.2'
titstr(6) ='q=1.3'
titstr(7) ='q=1.4'
titstr(8) ='q=1.5'
titstr(9) ='q=1.6'
titstr(10)='q=1.7'
titstr(11)='q=1.9'


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



for i=0,11 do begin
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
a=alog10(abs(a)+1e-9)*sgn
;a=a
;cgloadct,0
;a=sgn
qxq=where(t ge 50)
gg=a[0:qxq[0],*]
gg=a


xtick=1
xtickf="(a1)"
xtit=''
if ( i gt 9  ) then begin
xtick=2
xtickf="(I3)"
xtit='time (orbits)'
endif
r=cgscalevector(gg,1,254)
;cgimage, (gg), pos=pos[*,i], /noerase
cgloadct,33
cgcontour, (a),t,z, pos=pos[*,i], /noerase, $
    /fill, nlev=64,  $
    ;/nodata,  $
    xrange=[20,110],$
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
