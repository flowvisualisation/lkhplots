
qarr=[0.1,0.5,0.7,0.9,1.3,1.5,1.7,1.9]
tptr=ptrarr(12)
bptr=ptrarr(12)
rptr=ptrarr(12)





for i=0,7 do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
print, dirtag

readcol,dirtag+'timevar',t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,dvxvy,thmin,w2,j2,hm
tptr[i]=ptr_new(t)

bptr[i]=ptr_new(dvxvy-bxby)
rptr[i]=ptr_new(dvxvy)

endfor


items=[ $
    'q=0.5'  $
    , 'q=0.7'  $
    , 'q=0.9'  $
    , 'q=1.1'  $
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
    , 'red'  $
    , 'orange'  $
    , 'green'  $
    , 'blue'  $
    ]

ls=[0,0,0,0,2,2,2,2]

cgdisplay, xs=800,ys=800
tmax=100
tmax=40
ymax=10*max(bxby)
ymax=1
ymin=1e-4


fname="allbxby"
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
cgplot, *tptr[0]/2./!DPI, (*bptr[0]), /ylog, yrange=[ymin,ymax], color=cl[0], xrange=[0,tmax], lines=ls[0], $
    charsize=charsize,$
    xtitle='t, orbits', $
    ytitle='BxBy '

for i=1,7 do begin
cgplot, *tptr[i]/2./!DPI, abs(*bptr[i]), /overplot, color=cl[i], lines=ls[i]
endfor


al_legend, items, lines=ls, colors=cl,  $   
    pos=[20,1e-2], $
;    /right, $
        charsize=charsize, linsize=.25

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
