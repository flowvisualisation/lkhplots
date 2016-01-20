


spawn, 'ls' , list2
list=grep('usr',list2) 
sz=size(list, /dimensions)
fnum=sz(0)-1

numarr=lonarr(fnum+1)

for i=0,fnum do begin
file=list[i]
numstr=strmid(file,3,6)
numarr[i]=long(numstr)
end

print, numarr

cgloadct,33

for i=0,fnum do begin

grd_ctl, model=numarr[i], g,c
readslice2, './', numarr[i], im
display, /hbar, title=string(c.time, format='(F5.1)'),reform(im[0,0,*,*])
endfor
end
