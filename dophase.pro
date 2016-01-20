 ppgetlast, nend
 nbeg=nend
dptr=ptrarr(12)
ax=ptrarr(12)

tstr=strarr(12)
xstr=strarr(12)
ystr=strarr(12)


cgdisplay, xs=800,ys=1200
pos=cglayout([1,2] , OXMargin=[11,11], OYMargin=[10,10], XGap=10, YGap=10  )

for nfile=nbeg, nend do begin

p=rp(nfile)
dptr[0]=ptr_new( [p.r(*,2,1)  ,p.r(*,2,3)  ]  )
dptr[1]=ptr_new( [p.p(*,2,1)  ,p.p(*,2,3)  ]  )
dptr[2]=ptr_new( [p.r(*,2,0)  ,p.r(*,2,2)  ]  )
dptr[3]=ptr_new( [p.p(*,2,0)  ,p.p(*,2,2)  ]  )


ns=500
ns2=1024
max2=max( *dptr[1])
min2=min( *dptr[1])
max1=max( *dptr[0])
min1=min( *dptr[0])
ixpx=hist_2d( *dptr[0], *dptr[1],  bin1=32000./ns2, bin2=2./ns, max2=max2,min2=min2, max1=max1, min1=min1)
sz=size(ixpx, /dimensions)
nx=sz[0]
ny=sz[1]
ax[1]=ptr_new( findgen(ny)/ny*(max2-min2)+min2 )
max2=max( *dptr[3])
min2=min( *dptr[3])
max1=max( *dptr[2])
min1=min( *dptr[2])
expx=hist_2d( *dptr[2], *dptr[3],  bin1=32000./ns2, bin2=(max2-min2)/ns, max2=max2,min2=min2, max1=max1, min1=min1)

c=1.0
wpi=1.0/sqrt(250)
lsi=c/wpi
ncel=3.2e4
dz=p.s.ds[2]

dist2=ncel*dz/lsi

ixpx[0,*]=0.0
expx[0,*]=0.0
sz=size(ixpx, /dimensions)
nx=sz[0]
ny=sz[1]
xa=(findgen(nx)/nx*1-0.5)*dist2

ax[0]=ptr_new(xa)

sz=size(expx, /dimensions)
nx=sz[0]
ny=sz[1]
ax[2]=ptr_new( (findgen(nx)/nx-0.5)*dist2)
ax[3]=ptr_new( findgen(ny)/ny*(max2-min2)+min2 )

fname="phase"+string(nfile, format='(I06)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omega_str='!9W!X'
gamstr='!9g!X'
omstr='!9w!X'
lstr='!9l!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
gamstr='!7c!X'
omstr='!7x!X'
lstr='!7k!X'
charsize=cgdefcharsize()*.6
endelse


xstr[0]='x/'+lstr+'!DS,I!N'
xstr[1]='x/'+lstr+'!DS,I!N'

ystr[0]=gamstr+'v!DI!N'
ystr[1]=gamstr+'v!DE!N'


cgloadct,33
tvlct, 255,255,255,0

dat=alog10(ixpx+.1)
r=cgscalevector(dat,0,254)
px=pos[*,0]
imin=min(dat)
imax=max(dat)
cgimage, r, pos=px
cgcontour, r,*ax[0], *ax[1], /noerase,  pos=px, /nodata, $ 
    title='Ion phase space, v!Dz!N vs z, t='+String(wpi*p.s.time, format='(I4)')+' '+omstr+'!U-1!N!Dp,ion!N', $
    xtitle=xstr[0], $
    ytitle=ystr[0]
    cgcolorbar, range=[imin,imax], /vertical, pos=[px[2]+.07,px[1],px[2]+0.08, px[3]]

dat=alog10(expx+.1)
r=cgscalevector(dat,0,254)
imin=min(dat)
imax=max(dat)
px=pos[*,1]
cgimage, r, pos=px, /noerase
cgcontour, r, *ax[2], *ax[3] , /noerase,  pos=px, /nodata,$
    xtitle=xstr[1], $
    ytitle=ystr[1]
    cgcolorbar, range=[imin,imax], /vertical, pos=[px[2]+.07,px[1],px[2]+0.08, px[3]]





if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor





endfor


end
