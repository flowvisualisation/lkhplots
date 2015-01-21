
pro getlast, n
spawn, "ls ex*.dat ",a
sz=size(a, /dimensions )
a2=a(sz-1)
b=strmid(a2,2,7)
nend2=long(b)
n=nend2(0)
end
