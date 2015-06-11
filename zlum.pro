pro zlum, maxwell=maxwell
cgdisplay, xs=800, ys=1100
numpic=8
arr=fltarr(numpic,250,251)
ysize=251
ofst=80
bigarr=fltarr(250,7*ofst+ysize)
tsz=size(bigarr, /dimensions)
ybgsz=tsz(1)

nrange=fltarr(numpic)
nrange[0]=40
nrange[1]=42
nrange[2]=44
nrange[3]=46
nrange[4]=47
nrange[5]=42
nrange[6]=47
nrange[7]=47

;nrange=findgen(8)+61
nrange=findgen(8)*2+109
for qq=0,numpic-1 do begin
nfile=nrange[qq]
;nfile=35
 if ( keyword_set(maxwell) ) then begin
rtag="znewMaxwell"
tag='lumleyb2dz'+string(nfile,format='(I04)')+'.h5'
endif else begin
rtag="znewReynolds"
tag='lumley2dz'+string(nfile,format='(I04)')+'.h5'
endelse
rtag1=rtag
rtag=rtag+string(nrange[0], format='(I04)')
s = H5_PARSE(tag, /READ_DATA)
;help, s.lumley._DATA, /STRUCTURE

dat= transpose(s.lumley._DATA)
;display,dat
wait, 1

arr( qq,*,*)=dat
endfor

bigarr[*,7*ofst:(7*ofst +ysize-1 )] +=arr[0,*,*]
bigarr[*,6*ofst:(6*ofst +ysize-1 )] +=arr[1,*,*]
bigarr[*,5*ofst:(5*ofst +ysize-1 )] +=arr[2,*,*]
bigarr[*,4*ofst:(4*ofst +ysize-1 )] +=arr[3,*,*]
bigarr[*,3*ofst:(3*ofst +ysize-1 )] +=arr[4,*,*]
bigarr[*,2*ofst:(2*ofst +ysize-1 )] +=arr[5,*,*]
bigarr[*,1*ofst:(1*ofst +ysize-1 )] +=arr[6,*,*]
bigarr[*,0:250]                     +=arr[7,*,*]



fname=rtag+"lumley"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse





cgloadct, 33
tvlct, 255,255,255,0
;pos=[0.1,0.3,0.9,0.9]
;!p.multi=[0,1,2]
;!p.multi=0
cgdisplay,xs=800,ys=1200
pos1 = cglayout([1,5] , OXMargin=[6,1], OYMargin=[6,1], XGap=1, YGap=0)
;cgcontour, reform(alog10(arr(0,*,*)+1e-6)), pos=pos, title='first'
;pos=[0.1,0.1,0.9,0.9]
;cgcontour, reform(alog10(arr(1,*,*) +1e-6)),  pos=pos, /noerase
for i=0,4 do begin
;d=alog10(bigarr(*,*) +1e-2)
d=reform(arr[i,*,*])
d=alog10(d +1e-1)
r=cgscalevector(d,0,254)
help,r
tmx=0.07d
tmin=-0.01d
sz=size(d, /dimensions)
x1=findgen(sz(0))/sz(0)*0.08d -0.01
x2=findgen(sz(1))/sz(1)*0.34d

;cgimage, r, pos=pos1(*,i), /noerase
;x1=findgen(250)/250*(tmx-tmin)+tmin
;yrange=(0.34d)*(ybgsz*1.0d)/(ysize*1.0d)
;x2=findgen(ybgsz)/(ybgsz)*yrange

xtickf="(a1)"
xtit=''

if ( i eq 4 ) then begin
xtickf="(F5.2)"
    xtit="!9c!X!D3!N"
endif

cgcontour, r, x1,x2,$
    pos=pos1(*,i),  $
    /noerase, $
    ;/overplot, $
       xTICKFORMAT=xtickf,$
    /fill, nlev=50,  $
;    title="Invariant Anisotropy Map of "+rtag1+" Stress",$
    yticks=3,$
    ;ytickformat='(F4.2)',$
    yTICKv = [0.0,0.1,0.20,0.3],$
    xtitle=xtit,$
    ytitle="|!9c!X!D2!N|"
xpos=0.06
ypos=0.06
;ypos=yrange

cgplot,  x1,  3.d*(x1/2.d)^(2.d/3.d), /overplot
cgplot, -x1,  3.d*(x1/2.d)^(2.d/3.d), /overplot
cgplot,  x1,  3.d*(x1(*)+1.d/27.d),/overplot

;cgtext, xpos,ypos, "t="+string(nrange[numpic-1-i],format='(I3)')
cgtext, xpos,ypos, "t="+string(nrange[i],format='(I3)')


if ( i eq 0 ) then begin
cgText,  0.06 , 0.30, '1D ', Alignment=0.9, Charsize=cgDefCharsize()*.9
cgText,  0.015, 0.19, '2D ', Alignment=0.5, Charsize=cgDefCharsize()*.9
cgText, -0.008, 0.14, '2D isotropic', Alignment=0.0, Charsize=cgDefCharsize()*.9
cgText,  0.005, 0.01, '3D isotropic', Alignment=0.0, Charsize=cgDefCharsize()*.9
endif


endfor
;cgtext, xpos,ypos*0.35, "t="+string(nrange[3],format='(I3)')
;cgtext, xpos,ypos*0.50, "t="+string(nrange[2],format='(I3)')
;cgtext, xpos,ypos*0.65, "t="+string(nrange[1],format='(I3)')
;for i=0,numpic-1 do begin
;endfor





if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


end
