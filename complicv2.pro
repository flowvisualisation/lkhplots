
xs=480
ys=320
cgdisplay, xs=xs, ys=ys

dir2='./nirvq/q15/'
num2=38792
dir3='./nirvqmri/q15/'
num3=158624


dir2='./nirvq/q03/'
num2=393256
dir3='./nirvq/q15/'
num3=38792

;dir2='./nirvq/q03/'
;num2=393256
;dir3='./nirvqmri/q03/'
;num3=511056

readslice2, dir3, 0, im3
vy30=reform(im3[1,0,*,*])

readslice2, dir2, 0, im2
vy20=reform(im2[1,0,*,*])


;numstr=strmid(file,3,6)
;num3=long(numstr)

spawn,'uname', listing
;if ( listing ne 'Darwin') then begin
;dir3='./'
;num3=98929
;endif

readslice2, dir3, num3, im3
readslice2, dir2, num2, im2

qs=1
u3=reform(im3[0,0,*,*])
v3=reform(im3[1,0,*,*])-vy30
if ( listing eq 'Darwin') then begin
sz=size(u3, /dimensions)
u3=congrid(u3,qs*sz(0), qs*sz(1) )
v3=congrid(v3,qs*sz(0), qs*sz(1) )
endif
lic3=mg_lic ( u3,v3 )

u2=reform(im2[0,0,*,*])
v2=reform(im2[1,0,*,*])-vy20
if ( listing eq 'Darwin') then begin
sz=size(u2, /dimensions)
u2=congrid(u2,qs*sz(0), qs*sz(1) )
v2=congrid(v2,qs*sz(0), qs*sz(1) )
endif
lic2=mg_lic ( u2,v2 )

 spawn, 'pwd', pwd
 pos=cglayout([1,2], xgap=1, ygap=1, oxmargin=[1,1], oymargin=[1,1])

 sx=159
 cgloadct,33
 dat2=cgscalevector(lic2,1,254)
 dat3=cgscalevector(lic3,1,254)
 cgimage,dat2,pos=pos[*,0] , /keep_aspect
 cgimage,dat3,pos=pos[*,1], /keep_aspect, /noerase 

end
