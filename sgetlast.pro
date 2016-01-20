
pro sgetlast, n
spawn, "ls data/v????.vtk ",a6
;spawn, "ls usr???????.h5 ",a7
sz=size(a6, /dimensions )
a2=a6(sz-1)
b=strmid(a2,7,4)
nend2=long(b)
n=nend2(0)
print, "nlast = ",n
end
