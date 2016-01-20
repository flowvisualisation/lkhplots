function getunplotted

spawn , 'ls *.dbl' , dbllist
spawn , 'ls *.jpg' , jpglist

njpgarr=size(jpglist, /dimensions)
njpg=njpgarr[0]

for i=0, njpg-1 do begin
r=file_info(jpglist[i])
q=file_info(dbllist[i])
jpgdate=r.mtime
dbldate=q.mtime

if ( jpgdate le dbldate) then begin
print, i, jpgdate, dbldate
break
endif
endfor

return, i
end
