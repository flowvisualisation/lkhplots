
q=1.5
spawn, 'basename $PWD', a
dirname=a
dirtag='znf?'
CASE dirname OF
   'strat'	: dirtag='ZNF 3:3:6'
   'znfs266'	: dirtag='ZNF 2:6:6'
   'znfs246'	: dirtag='ZNF 2:4:6'
   'znfs244'	: dirtag='ZNF 2:4:4'
   'znfs264'	: dirtag='ZNF 2:6:4'
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





usingps=0
!p.multi=0
;readcol,'timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm

readcol,'averages.dat',t,dt,b2,vx2,vy2,vz2,bx2,by2,bz2
t=t



; it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax
    fname="timeseries"

ux2m=vx2
uy2m=vy2
uz2m=vz2
bx2m=bx2
by2m=by2
bz2m=bz2

items=['v!Dx!N','v!Dy!N', 'v!Dz!N', 'B!Dx!N', 'B!Dy!N', 'B!Dz!N','exp(qt/2)' ]
linestyles=[0,0,0,3,2,2,1]
psym=[0,1,2,3,4,5,6]
colors=['red', 'blue', 'green', 'orange', 'turquoise', 'purple', 'black']


h=size(ux2m, /dimensions)
h=h-1
maxall=max([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
maxall=max([ [(ux2m)] , [(uy2m)], [(uz2m)] , [(bx2m)] , [(by2m)] ,[(bz2m)]   ])
minall=min([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
minall=min([ [(ux2m[1:h])] , [(uy2m[1:h])], [(uz2m[1:h])] , [(bx2m[1:h])] , [(by2m[1:h])] ,[(bz2m[1:h])]   ])
ymin0=1e-6
ymin0=minall
;ymax=1e2
;ymin=1e-13
ymax=maxall;+0.16



fname="timehistory"+dirname
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



tnorm=t/2.d/!DPI
xmin=min(tnorm)
xmax=max(tnorm)
;xmin=14
;xmax=28
;ymin=.1
ymin=1e3*ymin0
ymin=ymin0
;ymax=100
cgplot, tnorm, (ux2m), color=colors[0], linestyle=linestyles[0], $
    /ylog, $
    yrange=[ymin, ymax], $
    ystyle=1, title="Time history of v!Dx,y,z!N,B!Dx,y,x!N "+dirtag, $
    pos=[0.18,0.12,0.98,0.9],$
    charsize=charsize,$
    xtitle="time/2"+pi_str+" (orbits)", $
    ytitle="v!Dx,y,z!N,B!Dx,y,z!N", $
    xstyle=1, xrange=[xmin,xmax]
        
cgplot, tnorm, (uy2m), /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, tnorm, (uz2m), /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, tnorm, (bx2m), /overplot, color=colors[3], linestyle=linestyles[3]
cgplot, tnorm, (by2m), /overplot, color=colors[4], linestyle=linestyles[4]
cgplot, tnorm, (bz2m), /overplot, color=colors[5], linestyle=linestyles[5]
cgplot, tnorm, (uy2m[0])*exp(2*q/2.*t), /overplot, color=colors[6], linestyle=linestyles[6]
;cgplot, tnorm, (bz2m+0.16437451), /overplot, color=colors[5], linestyle=linestyles[5]


fit=sqrt(uy2m[0])*exp(0.75*t)
dat=sqrt(ux2m)

nlines=size(t, /dimensions)
if ( nlines gt 80 ) then begin
print,"growth rate theory", (alog(fit[nlines])-alog(fit[nlines-10])) / (t[nlines]-t[nlines-10])

print, "growth rate data", (alog(dat[nlines])-alog(dat[nlines-10])) / (t[nlines]-t[nlines-10])
endif

rho=1.d0
omega=1.d0
va=0.16437451
lfast=sqrt(15.d0/16.d0) *2.d0 *!DPI  /omega/sqrt(rho) 
print, '1 lfast', 1/lfast

	al_legend, items, colors=colors, linestyle=linestyles, $
    charsize=charsize,$
    ;/bottom, $
    ;pos=[4,2e-3],$
    linsize=0.25

print, 'Saturation level', maxall




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
