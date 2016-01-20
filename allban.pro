;pload, 0, dir='q01', /nodata
nfile=50
tptr=ptrarr(12)

nfile=189
nstr=string(nfile, format='(I08)')
qarr=[0.3,0.5,0.7,0.9,1.3,1.5,1.7,1.9]
for i=0,7 do begin

dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')
print, dirtag
;PLOAD, nfile, DIR = dirtag, var='bx2'
qq=h5_parse(dirtag+'/banerbh0'+dirtag+nstr+'.h5', /read_data)
;narr=remapfunc (bx2(*,*,0) , t[nfile], nx1,nx2,qarr[i],  x1,x2,dx2)
tptr[i]=ptr_new(reform(qq.lumley._DATA))
endfor



items=[ $
    'q=0.1'  $
    , 'q=0.5'  $
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
    , 'yellow'  $
    , 'green'  $
    , 'blue'  $
    , 'violet'  $
    , 'black'  $
    , 'black'  $
    ]

ls=[0,1,2,3,4,5,6,7]

;tmax=max([t1,t2,t3 , $     
;    t4, t13, t15, t17,t19 ])/2/!DPI
;1max=10*max( [ abs(bxy1) , abs(bxy2) , abs(bxy3) ] )

thick=2.
;cgplot, *tptr[0]/2./!DPI, abs(*bptr[0]), /ylog, yrange=[1e-6*ymax,ymax], color=cl[0], xrange=[0,tmax], lines=ls[0], $
;    xtitle='t, orbits', $
;    ytitle='BxBy '

; pos=cglayout([2,4] , OXMargin=[9,1], OYMargin=[14,2], XGap=9, YGap=9)
 pos=cglayout([4,2] , OXMargin=[13,1], OYMargin=[9,1], XGap=4, YGap=9)

 xs=1200
 ys=650
 cgdisplay, xs=xs, ys=ys

 cgloadct,33


fname="qban"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
charsize=cgdefcharsize()*.7
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse


for i=0,7 do begin
;cgplot, *tptr[i]/2./!DPI, abs(*bptr[i]), /overplot, color=cl[i], lines=ls[i]
px=pos[*,i]
dat=(*tptr[i])
tvlct, 255,255,255,0
r=cgscalevector(dat,0,254)
imin=min(dat)
imax=max(dat)
print, 'q', qarr[i], imin, imax
cgimage, r , pos=px, /noerase
cgcolorbar, range=[imin,imax], pos=[px[0] , px[1]-0.03, px[2],px[1]-0.02], charsize=charszie
sz=size(dat, /dimensions)
x=findgen(sz(0))/sz(0)*1-0.5
y=findgen(sz(1))/sz(1)*sqrt(2.)
cgcontour, r,x,y,  $
    /noerase, $
    /nodata, $
        xticklayout=1, $
    yticklayout=1, $
    xtickname=REPLICATE(' ', 2),$
    ytickname=REPLICATE(' ', 2),$
      axiscolor='white', $
          xticks=1,$
    yticks=1,$
    pos=px, $
    charsize=charsize, $
    ytitle='';'q='+string(qarr[i],format='(F4.1)')


cgtext, -0.5,1.2 , "q="+string(qarr[i],format='(F4.1)')

cx=findgen(250)/250*3.4-1.7


cx2=cx ( where ( cx le 0))
cx2=findgen(100)/100*(-.5)
cx3=cx ( where ( cx ge 0))

cgplot, cx2,  2.8*cx2+1.4, /overplot,pos=pos
cgplot, cx3,  -2.8*cx3+1.4, /overplot, pos=pos
cgplot, cx,  0*cx, /overplot, pos=pos, color='red'
endfor


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
;al_legend, items, lines=ls, colors=cl, /right, charsize=cgdefcharsize()*1.5, linsize=.25

READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
end
