
cgdisplay, xs=800, ys=600
q=1.5
spawn, 'basename $PWD', a
dirname=a
CASE dirname OF
   'v1_448'	: dirtag='Vertical'
   'v1_448_r200400'	: dirtag='Vertical'
   't1_448'	: dirtag='Toroidal field'
   'z1_448'	: dirtag='Zero net flux'
   'q18n200' : begin
   q=1.8
   dirtag='net B!Dz!N, q=1.8'
    end
   'q14n200' : begin
   q=1.4
   dirtag='net B!Dz!N, q=1.4'
    end
   'q14n200_noise2_res' : begin
   q=1.4
   dirtag='net B!Dz!N, q=1.4'
    end
   'betaz1600_s266'	: dirtag='!9b!X!Dz!N=1600 2:6:6'
   't1b1e5s246'	: dirtag='!9b!X!Df!N=1600 2:4:6'
   't1b1e5s266'	: dirtag='!9b!X!Df!N=1600 2:6:6'
	'3d_mri_pi_wn'		: dirtag='3D MRI + PI!DWN!N =0 '
   ELSE: PRINT, 'Not one through four'
ENDCASE
dirtag=dirname





usingps=0
!p.multi=0
;readcol,'timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm




; it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax
    fname="timeseries"



fname="fc"+dirname
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
charsize=cgdefcharsize()*0.9
pi_str='!9p!X'
endif else  begin
set_plot, 'x'
charsize=cgdefcharsize()*1.1
pi_str='!7p!X'
endelse



;ttag=", t="+string(nfile, format='(I8)')
grd_ctl, model=712000, p,cx
ttag=', t='+string(cx.time/2.d/!DPI, format='(F7.1)')

ang=7.d
e=reform(abs(fftarr(*,*,*)))
slice = EXTRACT_SLICE( e, p.ny, p.nz, p.nx/2, p.ny/2, p.nz/2, !DPI/2, !DPI/2-!DPI/180.*ang, 0, OUT_VAL=0B, /radians)
sz=size(slice, /dimensions)

data=slice[1:sz(0)/2-1,*]


;a=reform(abs(fftarr(*,0,*)))  & b=a[0:nx1/2-1,*]
;a=reform(abs(fftarr(0,*,*)))  & b=a[0:99,*]
d=total(data[0:10,*],1)/(total(data[0:nx1/2-2,*],1) +1e-14 )
d=reform(d)
cgplot, x3/sqrt(2),(d) , $
    yrange=[0.1, 0.5], $
    ystyle=1, $
    title=dirtag+ ttag, $
    pos=[0.18,0.16,0.98,0.9],$
    charsize=charsize,$
    xtitle="z/H", $
    ytitle="f(k!Dc!N)", $
    xstyle=1 
cgplot, x3/sqrt(2),smooth(d,50) , /overplot
        






if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor





end
