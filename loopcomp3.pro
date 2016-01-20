


dir1='dhires2/'
dir2='shires2/'
dir3='q15/'

spawn, 'ls '+dir1 , list2
list=grep('usr',list2) 
sz=size(list, /dimensions)
fnum=sz(0)-1
numarr=lonarr(fnum+1)
for i=0,fnum do begin
file=list[i]
numstr=strmid(file,3,6)
numarr[i]=long(numstr)
end

spawn, 'ls '+dir2 , list2
list=grep('usr',list2) 
sz=size(list, /dimensions)
fnum2=sz(0)-1
numarr2=lonarr(fnum2+1)
for i=0,fnum2 do begin
file=list[i]
numstr=strmid(file,3,6)
numarr2[i]=long(numstr)
end


spawn, 'ls '+dir3 , list3
list=grep('usr',list3) 
sz=size(list, /dimensions)
fnum3=sz(0)-1
numarr3=lonarr(fnum3+1)
for i=0,fnum3 do begin
file=list[i]
numstr=strmid(file,3,6)
numarr3[i]=long(numstr)
end

print, numarr

cgloadct,33
pos=cglayout([1,3])

ims=ptrarr(12)
timarr=fltarr(12)
for i=fnum-5,fnum do begin

grd_ctl, dir=dir1,model=numarr[i], g1,c1
grd_ctl, dir=dir2,model=numarr2[i], g2,c2
grd_ctl, dir=dir3,model=numarr3[i], g3,c3
readslice2, dir1, numarr[i], im
readslice2, dir2, numarr2[i], im2
readslice2, dir3, numarr3[i], im3
;display, /hbar, title=string(c.time, format='(F5.1)'),reform(im[0,0,*,*])

ims[0]=ptr_new(reform(im[0,0,*,*]))
ims[1]=ptr_new(reform(im2[0,0,*,*]))
ims[2]=ptr_new(reform(im3[0,0,*,*]))
timarr[0]=c1.time
timarr[1]=c2.time
timarr[2]=c3.time

cgerase
for q=0,2 do begin
dat=*(ims[q])
px=pos[*,q]
sz=size(dat, /dimensions)
x=findgen(sz(0))
y=findgen(sz(1))
cgimage, dat, pos=px, /noerase
cgcontour, dat, x,y, /nodata, /noerase, pos=px, ytitle=string(sz(0), format='(I4)')+' x '+string(sz(1), format='(I4)') , title=string(timarr[q])
;cgimage, reform(im2[0,0,*,*]), pos=pos[*,1], /noerase
endfor

fname2='compare_res'+string(i, format='(I06)')
print, fname2
myim=cgsnapshot( filename=fname2, /jpeg, /nodialog)


endfor
;ptr_free, ims
end
