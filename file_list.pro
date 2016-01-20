

spawn , 'ls *.dbl' , dbllist
spawn , 'ls *.jpg' , jpglist

njpgarr=size(jpglist, /dimensions)
njpg=njpgarr[0]
for i=0, njpg do begin

r=file_info(jpglist[i])
q=file_info(dbllist[i])
jpgdate=r.atime
dbldate=r.atime

endfor
end
