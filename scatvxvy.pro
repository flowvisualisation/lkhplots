
window, xs=1200, ys=1200
!p.charsize=2
for nfile=0,21 do begin
pload,nfile, /silent
sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba

xx=rebin(reform(x1,nx1,  1,  1),nx1,nx2,nx3) 
yy=rebin(reform(x2,  1,nx2,  1),nx1,nx2,nx3) 
zz=rebin(reform(x3,  1,  1,nx3),nx1,nx2,nx3) 
vshear=vsh*xx




vx=vx1
vy=vx2-vshear

bx=bx1
by=bx2

vnorm=sqrt(vx^2+vy^2)
bnorm=sqrt(bx^2+by^2)

vscat=intarr(2,nx3)
vxarr=fltarr(nx3)
vyarr=fltarr(nx3)

bscat=intarr(2,nx3)
bxarr=fltarr(nx3)
byarr=fltarr(nx3)

for k=0,nx3-1 do begin
vnorm2d=reform(vnorm(*,*,k))
bnorm2d=reform(bnorm(*,*,k))

	index =0L
   index = WHERE(vnorm2d EQ max( vnorm2d))
   index2 = WHERE(bnorm2d EQ max( bnorm2d))
	;help, vnorm2d
   s = SIZE(vnorm2d)
   ncol = s(1)
   col = index MOD ncol
   row = index / ncol
	;print,index,col[0],row[0]
   s = SIZE(bnorm2d)
   ncol = s(1)
   bcol = index MOD ncol
   brow = index / ncol

	vscat[0,k]=col[0]
	vscat[1,k]=row[0]
	vxarr[ k ]=vx( vscat[0,k], vscat[1,k]  ,k) 
	vyarr[ k ]=vy( vscat[0,k], vscat[1,k]  ,k) 

	bscat[0,k]=bcol[0]
	bscat[1,k]=brow[0]
	bxarr[ k ]=bx( bscat[0,k], bscat[1,k]  ,k) 
	byarr[ k ]=by( bscat[0,k], bscat[1,k]  ,k) 

endfor
maxx=max([max(bxarr),max(vxarr)]) 
maxy=max([max(byarr),max(vyarr)]) 
minx=min([min(bxarr),min(vxarr)]) 
miny=min([min(byarr),min(vyarr)]) 



for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
pxs=11.
pys=12
!p.charsize=1.8
DEVICE, XSIZE=pxs, YSIZE=pys, /INCHES
endif else begin
!p.font=-1
!p.color=0
!p.charsize=1.8
legchar=0.6
;window, xs=1100,ys=800
;device, Set_Resolution=[1100,800]
if ( keyword_set(zbuf) ) then begin
set_plot, 'z'
device, set_resolution=[1300,1100], Decomposed=1, Set_Pixel_Depth=24
endif else begin
legchar=1.1
set_plot, 'x'
;window, xs=xs, ys=ys
legchar=0.6
endelse
endelse

cgplot, bxarr, byarr, psym=4,  $
        color='red',$
		title="Scatter plots of B!DX,Y!N and V!DX,Y!N at t="+string(nfile)+" orbits", $
		xtitle="B!DX!N, V!DX!N",$
		ytitle="B!DY!N, V!DY!N", $
		xrange=[minx,maxx], $
		yrange=[miny,maxy]
cgplot, vxarr, vyarr, psym=16,  color='blue', /overplot


qtag='scattervxvybxby'

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname=qtag+zero+nts
           endfor

if ( usingps ) then begin
device,/close
;set_plot,'x'
if ( keyword_set(zbuf) ) then begin
set_plot, 'z'
device, set_resolution=[1300,1100], Decomposed=1, Set_Pixel_Depth=24
endif else begin
set_plot, 'x'
endelse
endif else begin
;set_plot,'x'
if ( keyword_set(zbuf) ) then begin
set_plot, 'z'
device, set_resolution=[1300,1100], Decomposed=1, Set_Pixel_Depth=24
endif else begin
set_plot, 'x'
endelse
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse







endfor
end
