
pro getlast, n, dir=dir

 if not keyword_set(dir) then dir='./'
spawn, "ls "+dir+"usr??????.h5 ",a6

slen=strlen(dir)
;spawn, "ls usr???????.h5 ",a7
sz=size(a, /dimensions )
a2=a6(sz-1)
b=strmid(a2,slen+3,7)
nend2=long(b)
n=nend2(0)
end
