;===
cgdisplay, xs=1600,ys=600

fname='mri_pi_5plot'

for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, /nomatch, xs=20, ys=5, /bold
   !P.CharThick = 8
   omega='!9W!X'
endif else  begin
set_plot, 'x'
   omega='!7x!X'
endelse





cgloadct,0
cgloadct,33

pos=cglayout([5,1] , OXMargin=[6,7], OYMargin=[6,1], XGap=1, YGap=0)

for  pno=0,3 do begin


var=reform(myarr(*,*,pno))
imin=min(var)
imax=max(var)
r=cgscalevector(var,1,255) 
cgimage, r, pos=pos(*,pno), /noerase
;cgcolorbar, range=[imin, imax] , pos=[pos[2]+0.07, pos[1], pos[2]+0.08, pos[3]], /vertical

ytick=30
ytickf="(a1)"
ytit=''
if ( pno eq 0 ) then begin
ytick=1
ytickf="(I3)"
ytit='Kz'
endif
xx=(findgen(nx/2)/nx-1)*2*!DPI+!DPI*1.5
zz=(findgen(nz)/nz-1)*2*!DPI+!DPI*1.
cgcontour, cgscalevector(vortprojsl,1,255),xx,zz, /nodata,/noerase,$
    xtit='k!Dh!Nh',$
             ytitle=ytit, $
         ;Ytickinterval=ytick,$
         xTICKs=3,$
         xTICKFORMAT="(I3)",$
          xTICKv = [-1,0,1],$
         yTICKFORMAT=ytickf,$
        ; Yticklayout=1,$
        axiscolor='black',$
    pos=pos(*,pno)

x=findgen(nx)
z=findgen(nz)
qx=congrid(myv1(*,*,pno),23,17)
qy=congrid(myv2(*,*,pno),23,17)
qqx=congrid(xx,23)
qqz=congrid(zz,17)

velovect, qx,qy,qqx,qqz, color=cgcolor('white'), pos=pos(*,pno), /overplot, c_thick=3.25, len=2.5; , thick=8

endfor

readcol,'timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm



ux2m=vxmax^2
uy2m=vymax^2
uz2m=vzmax^2
bx2m=bxmax^2
by2m=bymax^2
bz2m=bzmax^2

items=['v!Dx!N','v!Dy!N', 'v!Dz!N', 'B!Dx!N', 'B!Dy!N', 'B!Dz!N','e!U0.75t!N' ]
linestyles=[0,0,0,3,2,2,1]
psym=[0,1,2,3,4,5,6]
colors=['red', 'blue', 'green', 'orange', 'turquoise', 'purple', 'black']


maxall=max([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
minall=min([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
ymin=1e-6
ymax=3e2
ymax=maxall


pos1=reform(pos[*,4])

addt=0
tnorm=t+addt
cgplot, tnorm, sqrt(ux2m), color=colors[0], linestyle=linestyles[0], /ylog, yrange=[ymin, ymax], ystyle=1, title="MRI + PI" ,$
pos=[pos1[0]+0.02,pos1[1],pos1[2]+.02,pos1[3]],$
xtitle='time, t  ['+omega+'!U-1!N]',$
/noerase,$
xrange=[addt,addt+1.]
cgplot, tnorm, sqrt(uy2m), /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, tnorm, sqrt(uz2m), /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, tnorm, sqrt(bx2m), /overplot, color=colors[3], linestyle=linestyles[3]
cgplot, tnorm, sqrt(by2m), /overplot, color=colors[4], linestyle=linestyles[4]
cgplot, tnorm, sqrt(bz2m), /overplot, color=colors[5], linestyle=linestyles[5]
cgplot, tnorm, sqrt(ux2m[0])*exp(0.75*t), /overplot, color=colors[6], linestyle=linestyles[6]
cgplot, tnorm, abs(bzmax-0.1643751), /overplot, color=colors[5], linestyle=linestyles[5]

	al_legend, items, colors=colors, linestyle=linestyles, charsize=1.8, pos=[addt+.2,1.e-1], linsize=0.2, box=0


if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



end
