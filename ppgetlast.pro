
pro ppgetlast, n
spawn, "ls -rt Data/fields-0?????.dat ",a6
;spawn, "ls usr???????.h5 ",a7
sz=size(a, /dimensions )
a2=a6(sz-1)
b=strmid(a2,12,6)
nend2=long(b)
n=nend2(0)
end
