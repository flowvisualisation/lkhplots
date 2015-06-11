
varfile='VAR0'
pc_read_var, obj=f0, varfile=varfile;, /trimall
slice=y/2
if tag_exist(f0,'rho' ) eq 0 then begin
rho=f0.lnrho[*,slice,*]
endif else begin
rho=f0.rho[*,slice,*]
endelse
v1=f0.uu[*,slice,*,0]
v2=f0.uu[*,slice,*,1]
v3=f0.uu[*,slice,*,2]
;a1=f0.aa[*,*,0]
;a2=f0.aa[*,*,1]
;a3=f0.aa[*,*,2]
xx=x[3:mx-4]
yy=z[3:mz-4]
xx=x
yy=z
print, 'max, min, v1', max(v1), min(v1)
print, 'max, min, v2', max(v2), min(v2)
print, 'max, min, v3', max(v3), min(v3)

dataptr=ptrarr(12)

titlestr=strarr(12,30)
dataptr[0]=ptr_new(reform(rho))
dataptr[1]=ptr_new(alog(reform(rho)))
dataptr[2]=ptr_new(alog(reform(rho)))
dataptr[3]=ptr_new(reform(v1))
dataptr[4]=ptr_new(reform(v2))
dataptr[5]=ptr_new(reform(v3))
;dataptr[3]=ptr_new(a1)
;dataptr[4]=ptr_new(a2)
;dataptr[5]=ptr_new(a3)

titlestr[0,*]='rho'
titlestr[1,*]='rho'
titlestr[2,*]='rho'
titlestr[3,*]='v1'
titlestr[4,*]='v2'
titlestr[5,*]='v3'
titlestr[3,*]='a1'
titlestr[4,*]='a2'
titlestr[5,*]='a3'



time=f0.t

   cgDisplay, WID=1,xs=1100, ys=1100
   cgLoadCT, 22, /Brewer, /Reverse
   pos = cglayout([3,2] , OXMargin=[5,5], OYMargin=[5,12], XGap=3, YGap=7)
   FOR j=0,5 DO BEGIN
     p = pos[*,j]
	r=cgscalevector( *dataptr(j), 1,254)
	imin=min(*dataptr[j])
	imax=max(*dataptr[j])
     cgImage, r, NoErase=j NE 0, Position=p
  cgcontour, dist(mx,mz), xx,yy , /nodata, /noerase, xtitle='x', pos=p, title=titlestr(j), Charsize=cgDefCharsize()*0.5
     cgColorBar, position=[p[0], p[1]-0.03, p[2], p[1]-0.02],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5
   ENDFOR
   cgText, 0.5, 0.96, /Normal,  'Jet time='+string(time), Alignment=0.5, Charsize=cgDefCharsize()*1.25





end
