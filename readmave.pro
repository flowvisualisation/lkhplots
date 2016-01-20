

tptr=ptrarr(12)
bptr=ptrarr(12)
rptr=ptrarr(12)
items=strarr(9)

nfile=50
tptr=ptrarr(12)
simmax=8

qarr=[0.3,0.5,0.7,0.9,1.1,1.3,1.5,1.7,1.9]
alpharr=fltarr(9)
for i=0,simmax do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
print, dirtag

readcol,dirtag+'/averages.dat',step,t1,b21,bxy1,rhouxuy1
tptr[i]=ptr_new(reform(t1))
bptr[i]=ptr_new(reform(bxy1))
rptr[i]=ptr_new(reform(rhouxuy1))
sz=size(bxy1, /dimensions)
sq=sz(0)-1

alpharr[i]= mean(rhouxuy1[sq*.25:sq]-bxy1[sq*.25:sq])
endfor


openw, 23, "alphaall.dat"
for i=0,8 do begin
alphanorm=alpharr[6]
items[i]='q='+string(qarr[i], format='(F4.1)') 
print, qarr[i], alpharr[i]
printf,23, qarr[i], alpharr[i]
endfor
close, 23




cl=[ $
    'red'  $
    , 'orange'  $
    , 'green'  $
    , 'blue'  $
    , 'violet'  $
    , 'brown'  $
    , 'red'  $
    , 'orange'  $
    , 'green'  $
    , 'black'  $
    ]

ls=[1,1,1,2,2,2,0,0,0]

;cgdisplay, xs=800,ys=800
tmax=max([  $
    *tptr[0], $     
    *tptr[1], $     
    *tptr[2], $     
    *tptr[3], $     
    *tptr[4], $     
    *tptr[5], $     
    *tptr[6], $     
    *tptr[7] $     
     ])/2/!DPI
ymax=10*max( [ $
    *bptr[0], $     
    *bptr[1], $     
    *bptr[2], $     
    *bptr[3], $     
    *bptr[4], $     
    *bptr[5], $     
    *bptr[6], $     
    *bptr[7] $     
    ])

    ymax=2e-1
    ymin=1e-4


fname="allalpha"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*1.1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*1.1
endelse



thick=2.
qsm=10
cgplot, *tptr[0]/2./!DPI,smooth( *rptr[0]-*bptr[0], qsm), /ylog, yrange=[ymin,ymax], color=cl[0], xrange=[0,tmax], lines=ls[0], $
    pos=[.15,.15,.95,.95],$
    xtitle='t, orbits', $
    ytitle='Normalized Turbulent MHD Stress, T!Dr!9f!X!N/P'

for i=1,simmax do begin
cgplot, *tptr[i]/2./!DPI, smooth(*rptr[i]-*bptr[i],qsm), /overplot, color=cl[i], lines=ls[i]
endfor


al_legend, items, lines=ls, colors=cl,  $
    ;/right, $
    pos=[20,5e-3], $
     charsize=charsize*.8, linsize=.25



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


READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a

end
