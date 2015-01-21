
pro getpplast, n
spawn, "ls Data/field*.dat ",a
sz=size(a, /dimensions )
a2=a(sz-1)
b=strmid(a2,12,6)
nend2=long(b)
n=nend2(0)
end
