qarr=[0.1,0.5,0.7,0.9,1.3,1.5,1.7,1.9]
bptr=ptrarr(12)
tptr=ptrarr(12)
for i=0,7 do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
readcol,dirtag+'alphat.txt',t,alpha
tptr[i]=ptr_new(t)
bptr[i]=ptr_new(alpha)
endfor






items=[ $
    'q=0.1'  $
    ,'q=0.5'  $
    , 'q=0.7'  $
    , 'q=0.9'  $
    , 'q=1.3'  $
    , 'q=1.5'  $
    , 'q=1.7'  $
    , 'q=1.9'  $
    ]

cl=[ $
    'red'  $
    , 'orange'  $
    , 'green'  $
    , 'blue'  $
    , 'violet'  $
    , 'green'  $
    , 'red'  $
    , 'orange'  $
    ]

ls=[2,2,2,2,0,0,0,0]

cgdisplay, xs=800,ys=800

fname="allalpha"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
charsize=cgdefcharsize()
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()
endelse




tmax=max([*tptr[0]  $     
     ])/2/!DPI
ymax=10*max( [ abs(*bptr[7]) ] )

thick=2.
cgplot, *tptr[0]/2./!DPI, abs(*bptr[0]), /ylog, yrange=[1e-6*ymax,ymax], color=cl[0], xrange=[0,tmax], lines=ls[0], $
    xtitle='t, orbits', $
    ytitle='BxBy '

for i=1,7 do begin
cgplot, *tptr[i]/2./!DPI, abs(*bptr[i]), /overplot, color=cl[i], lines=ls[i]
endfor


al_legend, items, lines=ls, colors=cl, $
    pos=[60,1e-3],$
     charsize=charsize, linsize=.25


if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
endif else begin
e=1
endelse
endfor
end
