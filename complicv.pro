
qs=1.5

sel=.5
xs=qs*480*sel
ys=qs*2*160
cgdisplay, xs=xs, ys=ys

dir2=   './nirvq/q19/'
num2=998596
dir3='./nirvqmri/q19/'
num3=302963


;dir2='./nirvq/q03/'
;num2=393256
;dir3='./nirvq/q15/'
;num3=38792

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

 sz=size(lic2, /dimensions)
 xf=(sz(0)-1)*sel
 yf=sz(1)-2
 dat2=cgscalevector(lic2[1:xf,1:yf],1,254)
 dat3=cgscalevector(lic3[1:xf,1:yf],1,254)
 cgloadct,0
 cgimage,dat2,pos=pos[*,0] , /keep_aspect
 cgimage,dat3,pos=pos[*,1], /keep_aspect, /noerase 

fname2='complic'
im=cgsnapshot(filename=fname2, /jpeg, /nodialog)
end
