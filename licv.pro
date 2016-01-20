

dir3='./'
num3=0


spawn, 'ls' , list2
list=grep('usr',list2) 
sz=size(list, /dimensions)
fnum=sz(0)-1
;fnum=0

readslice2, dir3, num3, im3
vy0=reform(im3[1,0,*,*])

for i=1,sz(0) do begin
file=list[fnum]


numstr=strmid(file,3,6)
num3=long(numstr)

spawn,'uname', listing
;if ( listing ne 'Darwin') then begin
;dir3='./'
;num3=98929
;endif

readslice2, dir3, num3, im3

u=reform(im3[0,0,*,*])
v=reform(im3[1,0,*,*])-vy0
if ( listing eq 'Darwin') then begin
sz=size(u, /dimensions)
u=congrid(u,2*sz(0), 2*sz(1) )
v=congrid(v,2*sz(0), 2*sz(1) )
endif

im=mg_lic ( u,v )

 spawn, 'pwd', pwd
display, im, title=pwd
endfor
end
