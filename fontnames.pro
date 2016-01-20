
!p.font=0
Device, GET_FONTNAMES=fontNames, SET_FONT='*times*'

print, fontnames
sz=size(fontnames, /dimensions)

nend=sz[0]
for n=0,nend-1 do begin
DEVICE, SET_FONT = fontnames[n]
print,fontnames[n]
cgplot, findgen(100), title='Trial plot'
endfor
end
