
nx=64
ny=128
mxm=128



print, 128L*64L*32L*100


; 8 = rop
readafort, 'fort.8', nx, ny, rop
; 9= t,ex,eyo
;10 ehx, ehy first five modes

; 11, fpx, (ascii?)
; 12,fpy
; 13 rho
readafort, 'fort.13', nx, ny, rho
; 14 = ex
readafort, 'fort.14', nx, ny, ex
; 15 = ey
readafort, 'fort.15', nx, ny, ey
; 16 = fpx
readafort, 'fort.16', mxm, nx, fpx
; 17 , fpy
readafort, 'fort.17', mxm, ny, fpy
help, rho, ex,ex,fpx,fpy




dataptr=ptrarr(12)

titlestr=strarr(12,30)
dataptr[0]=ptr_new(rho)
dataptr[1]=ptr_new(fpx)
dataptr[2]=ptr_new(fpy)
dataptr[3]=ptr_new(ex)
dataptr[4]=ptr_new(ey)
dataptr[5]=ptr_new(rop)
dataptr[6]=ptr_new(rop)
dataptr[7]=ptr_new((rho))
dataptr[8]=ptr_new((rho))

titlestr[0,*]='rho'
titlestr[1,*]='fpx'
titlestr[2,*]='fpy'
titlestr[3,*]='ex'
titlestr[4,*]='ey'
titlestr[5,*]='rop'
titlestr[6,*]='rho'
titlestr[7,*]='rho'
titlestr[8,*]='rho'



time=0

   cgDisplay, WID=1,xs=1100, ys=1100
   cgLoadCT, 22, /Brewer, /Reverse
   pos = cglayout([3,3] , OXMargin=[5,5], OYMargin=[5,12], XGap=3, YGap=7)
   FOR j=0,8 DO BEGIN
     p = pos[*,j]
	r=cgscalevector( *dataptr(j), 1,254)
	imin=min(*dataptr[j])
	imax=max(*dataptr[j])
     cgImage, r, NoErase=j NE 0, Position=p
     sz=size(r, /dimensions)
     xx=findgen(sz(0))
     yy=findgen(sz(0))
  cgcontour,xx#yy, xx,yy , /nodata, /noerase, xtitle='x', pos=p, title=titlestr(j), Charsize=cgDefCharsize()*0.5
     cgColorBar, position=[p[0], p[1]-0.03, p[2], p[1]-0.02],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5
   ENDFOR

 end



