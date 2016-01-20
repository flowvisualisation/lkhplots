nsim=10
qarr=[0.1,0.7,1.5,1.9,1.3,1.5,1.7,1.9]
qarr=[0.1,0.3,0.5,0.7,0.9,1.1,1.3,1.5,1.7,1.9]
bptr=ptrarr(12)
tptr=ptrarr(12)
maxt=0
maxb=0
for i=0,nsim-1 do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
readcol,dirtag+'averages.dat',n,t,alpha,k1,k2
tptr[i]=ptr_new(t)
bptr[i]=ptr_new(alpha)

print, qarr[i], max(t)
maxt=max( [maxt, max(t)    ] )
maxb=max( [maxb, max(alpha)] )

endfor






items=[ $
     'q='+string(qarr[0], format='(F4.1)')  $
    ,'q='+string(qarr[1], format='(F4.1)')  $
    ,'q='+string(qarr[2], format='(F4.1)')  $
    ,'q='+string(qarr[3], format='(F4.1)')  $
    ,'q='+string(qarr[4], format='(F4.1)')  $
    ,'q='+string(qarr[5], format='(F4.1)')  $
    ,'q='+string(qarr[6], format='(F4.1)')  $
    ,'q='+string(qarr[7], format='(F4.1)')  $
    ,'q='+string(qarr[8], format='(F4.1)')  $
    ,'q='+string(qarr[9], format='(F4.1)')  $
    ]

cl=[ $
    'red'  $
    , 'orange'  $
    , 'green'  $
    , 'blue'  $
    , 'violet'  $
    , 'red'  $
    , 'orange'  $
    , 'green'  $
    , 'blue'  $
    , 'violet'  $
    ]

ls=[0,0,0,0,2,2,2,2,3,3,3,3]

cgdisplay, xs=800,ys=800

fname="allalpha"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
rho_str='!9r!X'
charsize=cgdefcharsize()
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
rho_str='!7q!X'
charsize=cgdefcharsize()
endelse




tmax=maxt/2.0d/!DPI
tmax=20
ymax=maxb
ymin=1e-1*ymax

thick=2.
cgplot, *tptr[0]/2./!DPI, abs(*bptr[0]), /ylog, yrange=[ymin,ymax], color=cl[0], xrange=[0,tmax], lines=ls[0], $
    pos=[.15,.1,.95,.99],$
    xtitle='t, orbits', $
    ytitle=rho_str+'v!U2!N '

for i=0,nsim-1 do begin
cgplot, *tptr[i]/2./!DPI, abs(*bptr[i]), /overplot, color=cl[i], lines=ls[i]
endfor


al_legend, items[0:nsim-1], lines=ls[0:nsim-1], colors=cl[0:nsim-1], $
    pos=[0.6*tmax,7e-5],$
     charsize=charsize, linsize=.25


if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
endif else begin
e=1
endelse
endfor
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a

end
