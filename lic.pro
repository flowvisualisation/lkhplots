

dir3='./'
num3=76380
num3=119198


spawn, 'ls' , list2
list=grep('usr',list2) 
sz=size(list, /dimensions)
fnum=sz(0)-1
;fnum=0

;for i=1,sz(0) do begin
;file=list[fnum]


;numstr=strmid(file,3,6)
;num=long(numstr)

spawn,'uname', listing
if ( listing ne 'Darwin') then begin
dir3='./'
num3=98929
endif

;readsliceb, dir3, num3, im3

qs=1
u=reform(im3[0,0,*,*])
v=reform(im3[1,0,*,*])
if ( listing eq 'Darwin') then begin
sz=size(u, /dimensions)
if ( qs gt 1 ) then begin
u=congrid(u,qs*sz(0), qs*sz(1) )
v=congrid(v,qs*sz(0), qs*sz(1) )
endif
endif

im=mg_lic ( u,v )

mag= sqrt(u*u+v*v)
m=mag/max(mag)

h=bytarr(sz(0), sz(1))
s=m
v=im/255.0
color_convert, h,s,v,r,g,b,/hsv_rgb

im2=bytarr(3L, sz(0)*1L, sz(1)*1L)
im2[0,*,*]=r
im2[1,*,*]=g
im2[2,*,*]=b
cgimage, im2
;endfor
end
