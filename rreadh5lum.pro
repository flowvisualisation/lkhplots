cgdisplay, xs=800, ys=1100
numpic=8
arr=fltarr(numpic,250,251)
ysize=251
ofst=80
bigarr=fltarr(250,7*ofst+ysize)
tsz=size(bigarr, /dimensions)
ybgsz=tsz(1)

nrange=fltarr(numpic)
nrange[0]=24
nrange[1]=28
nrange[2]=32
nrange[3]=36
nrange[4]=40
nrange[5]=44
nrange[6]=48
nrange[7]=52

for qq=0,numpic-1 do begin
nfile=nrange[qq]
;nfile=35
;tag='lumley_b'+string(nfile,format='(I04)')+'.h5'
tag='lumley2dy'+string(nfile,format='(I04)')+'.h5'
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
bigarr[*,2*ofst:(2*ofst +ysize-1 )]  +=  arr[5,*,*]
bigarr[*,1*ofst :(1*ofst +ysize-1 )] += arr[6,*,*]
bigarr[*,0:250]                      +=  +arr[7,*,*]

cgloadct, 33
tvlct, 255,255,255,0
pos=[0.1,0.3,0.9,0.9]
;!p.multi=[0,1,2]
!p.multi=0
;cgcontour, reform(alog10(arr(0,*,*)+1e-6)), pos=pos, title='first'
pos=[0.1,0.1,0.9,0.9]
;cgcontour, reform(alog10(arr(1,*,*) +1e-6)),  pos=pos, /noerase
d=alog10(bigarr(*,*) +1e-2)
r=cgscalevector(d,0,254)
tmx=0.07d
tmin=-0.01d
x1=findgen(250)/250*(tmx-tmin)+tmin
yrange=1.0
x2=findgen(ybgsz)/(ybgsz)*1.0
cgcontour, r, x1,x2, pos=pos, /fill, nlev=50,  $
    title="Reynolds Stress",$
    xtitle="Invariant 3",$
    ytitle="Invariant 2"
xpos=0.05
ypos=yrange
;cgtext, xpos,ypos*0.35, "t="+string(nrange[3],format='(I3)')
;cgtext, xpos,ypos*0.50, "t="+string(nrange[2],format='(I3)')
;cgtext, xpos,ypos*0.65, "t="+string(nrange[1],format='(I3)')
for i=0,numpic-1 do begin
cgtext, xpos,ypos*0.23+ypos*0.10*i, "t="+string(nrange[numpic-1-i],format='(I3)')
endfor

end
