
ys=500
cgdisplay, xs=3*ys, ys=ys
 ik= vx*conj(vy)+conj(vx)*vy
 im= -bx*conj(by)-conj(bx)*by

 ikm= (conj(vx)*bx + conj(vy)*by - vx*conj(bx) - vy *conj(by))


 pos=cglayout ([3,1], xgap=11, ygap=11, oxmargin=[15,5], oymargin=[16,5])



titstr=strarr(9)
titstr[0]='I!DK!N'
titstr[1]='I!DM!N'
titstr[2]='I!DK-M!N'
datarr=ptrarr(9)
datarr[0]=ptr_new(  alog10(transpose(shift(total(abs(ik),1),nx/2,nx/2)  )))
datarr[1]=ptr_new(  alog10(transpose(shift(total(abs(im),1),nx/2,nx/2) )))
datarr[2]=ptr_new(  alog10(transpose(shift(total(abs(ikm),1),nx/2,nx/2) )))


x1arr=ptrarr(9)
x2arr=ptrarr(9)
k1=findgen(256)-128
x1arr[0]=ptr_new(k1)
x1arr[1]=ptr_new(k1)
x1arr[2]=ptr_new(k1)

x2arr[0]=ptr_new(k1)
x2arr[1]=ptr_new(k1)
x2arr[2]=ptr_new(k1)
 cgloadct,33
 cgerase


usingps=0
spawn, 'basename $PWD', dirtag
fname="transfer"+dirtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*.6
endelse


for i=0,2 do begin
d=*datarr[i]
r=cgscalevector(d,1,254)
x1=*x1arr[i]
x2=*x2arr[i]
px=pos[*,i]
cgimage, r, pos=px, /noerase
print, i
help,r 
cgcontour, r,x1,x2,  /nodata, $
    charsize=charsize,$
    xtitle='k!Dx!N',$
    ytitle='k!Dy!N',$
    pos=px,   $
    /noerase, $
    title=titstr[i]
endfor


if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor

end
