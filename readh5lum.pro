numpic=4
arr=fltarr(numpic,250,251)
bigarr=fltarr(250,500)
nrange=fltarr(numpic)
nrange[0]=13
nrange[1]=24
nrange[2]=30
nrange[3]=33

for qq=0,numpic-1 do begin
nfile=nrange[qq]
;nfile=35
tag='lumley2dy'+string(nfile,format='(I04)')+'.h5'
s = H5_PARSE(tag, /READ_DATA)
;help, s.lumley._DATA, /STRUCTURE

dat= transpose(s.lumley._DATA)
;display,dat
wait, 1

arr( qq,*,*)=dat
endfor

bigarr[*,240:490] =arr[0,*,*]
bigarr[*,160:410]  +=  arr[1,*,*]
bigarr[*,80:330] += arr[2,*,*]
bigarr[*,0:250]  +=  +arr[3,*,*]

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
x1=findgen(250)/250*0.01-0.01d
x2=findgen(500)/500*0.33
cgcontour, r, x1,x2, pos=pos, /fill, nlev=50 ,  $
    title="Reynolds",$
    xtitle="Invariant 3",$
    ytitle="Invariant 2"

xpos=-0.002
ypos=0.3333
cgtext, xpos,ypos*0.35, "t="+string(nrange[3],format='(I3)')
cgtext, xpos,ypos*0.50, "t="+string(nrange[2],format='(I3)')
cgtext, xpos,ypos*0.65, "t="+string(nrange[1],format='(I3)')
cgtext, xpos,ypos*0.83, "t="+string(nrange[0],format='(I3)')

end
