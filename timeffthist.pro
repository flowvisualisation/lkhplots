nr=8
nc=5
nplots=nr*nc
nq=11
nx=1100/nr
cgdisplay, xs=nx*nr, ys=nx*nc
ymax=6
cgplot, findgen(nplots), findgen(nplots), yrange=[1,ymax], /nodata

cl=[ 'red', 'orange','green', 'blue','violet' ,$ 
'red', 'orange','green', 'blue','violet' ,$ 
'red', 'orange','green', 'blue','violet' $ 
    ]


allq=[3,5,7,9,11,13,15,17,19]
allq=[3,5,7,9,11,13,15,16,17,18,19]
allqf=allq*0.1
alldir=strarr(nq+1,5)
for i=0,nq-1 do begin
;print, i
str="q"+string(allq[i],format='(I02)')
;print, i, str
alldir(i,*)=str
endfor

;alldir=['q09', 'q11', 'q13', 'q14']
aptr=ptrarr(nq+1)
bptr=ptrarr(nq+1)

for qq=0,nq-1 do begin
cd, alldir[qq]
print, alldir[qq]
cgloadct,33
spawn, 'ls' , list2
list=grep('usr',list2)

;print, size(list, /dimensions)


aarr=findgen(1)
barr=findgen(1)
aarr[*]=1
barr[*]=1

sz=size(list, /dimensions)
nl=sz[0]


pos=cglayout([nplots/nc,nc], OXMargin=[5,1], OYMargin=[9,2], XGap=1, YGap=1)

    r=h5_read( 0, /v,/remap)
    vy0=reform(r.v[1,*,*,*])

for i=0,nplots-1 do begin

    nst=i+(nl-nplots)
    str=strmid(list[nst],3,6)
    num=long(str)
    r=h5_read( num, /v,/remap)
    grd_ctl, model=num, g,c
    vx=reform(r.v[0,*,*,*])
    vy=reform(r.v[1,*,*,*])-vy0
    vz=reform(r.v[2,*,*,*])
    v2=vx^2+vy^2+vz^2

    
    b=reform( v2[0,*,*])
    a=logfft(b)
    nx=480
    ny=nx
        a=congrid(a,nx,ny)
        kx=findgen(nx)-nx/2
        ky=findgen(ny)-ny/2
    dat=smooth(congrid(abs(fft(b, /center)), nx,nx),5)
    gft=mpfit2dpeak(dat, aa,/tilt, /lorentzian)

    
    a=max([aa[2],aa[3]])
b=min([aa[2],aa[3]])
    ;print, a,b
    aarr=[aarr,a]
    barr=[barr,b]
    
    xtickf='(A1)'
    ytickf='(A1)'
    
    nr=6
    if ( i ge (nplots-nr) ) then begin
    xtickf='(I5)'
endif
    if ( (i mod nr) eq 0 ) then begin
    ytickf='(I5)'
    endif

    px=pos[*,i]

    



    
endfor
cgplot, aarr/barr, /overplot, linestyle=qq, color=cl[qq]

aptr[qq]=ptr_new(aarr)
bptr[qq]=ptr_new(barr)

print, 'end of ', alldir[qq], ''

cd , '..'
endfor



top=allqf
bot=top
mea=top

for i=0,nq-1 do begin

a=(*aptr[i])[1:nplots-1]
b=(*bptr[i])[1:nplots-1]
ab=a/b
top[i]=   max(ab,/nan)
bot[i]=   min(ab,/nan)
mea[i]=  mean(ab,/nan)
sig   =stddev(ab,/nan)
top[i]=mea[i]+sig
bot[i]=mea[i]-sig

endfor


fname="timeffthist"
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

ymax=max(top)
    xax=findgen(nplots)/nplots*2
  cgplot,allqf, top,ystyle=2 , /nodata, xrange=[0,2], yrange=[1,ymax], $
    xtitle='Shear rate, q',  $
    ytitle='Aspect ratio of Lorentzian 2d fit'
  cgcolorfill,[allqf,reverse(allqf)],[bot,reverse(top)],/data, color='pink'
  cgloadct,0
  cgplot,allqf, mea,color=0, /overplot

if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor




print, 'q mean-sig mean +1sig'
for i=0,nq-1 do begin

print, allqf[i] , bot[i], mea[i], top[i]
endfor


end
