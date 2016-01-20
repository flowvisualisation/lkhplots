
cgloadct,33
cgdisplay,xs=1200,ys=1200
dir1='nirvqmri/q15/'
num1=22387
dir2='shires/'
num2=50534
dir3='dhires/'
num3=98929
grd_ctl,model=num1, g1,c, dir=dir1
print,'t= ', c.time
grd_ctl,model=num2, g2,c, dir=dir2
print,'t= ', c.time
grd_ctl,model=num3, g3,c, dir=dir3
print,'t= ', c.time
if ( firstcall eq !NULL ) then begin 
readslice2, dir1, num1, im1
readslice2, dir2, num2, im2
readslice2, dir3, num3, im3

firstcall=1
endif

imarr=ptrarr(3)
im2arr=ptrarr(3)
xarr=ptrarr(3)
yarr=ptrarr(3)
k1arr=ptrarr(3)
k2arr=ptrarr(3)

xtfarr=strarr(3)
xtfarr[0]='(A1)'
xtfarr[1]='(A1)'
xtfarr[2]='(I5)'


imarr[0] =ptr_new(reform(im1[0,0,*,*]))
imarr[1] =ptr_new(reform(im2[0,0,*,*]))
imarr[2] =ptr_new(reform(im3[0,0,*,*]))

titstr=strarr(3)
xtitstr=strarr(3)
ytitstr=strarr(3)
ytitstr[0]='160x480'
ytitstr[1]='320x960'
ytitstr[2]='640x1920'

ys=6.0
xarr[0]=ptr_new(findgen(g1.ny-1)/(g1.ny-1)*ys)
xarr[1]=ptr_new(findgen(g2.ny-1)/(g2.ny-1)*ys)
xarr[2]=ptr_new(findgen(g3.ny-1)/(g3.ny-1)*ys)

xs=2.0
yarr[0]=ptr_new(findgen(g1.nx-1)/(g1.nx-1)*xs)
yarr[1]=ptr_new(findgen(g2.nx-1)/(g2.nx-1)*xs)
yarr[2]=ptr_new(findgen(g3.nx-1)/(g3.nx-1)*xs)


k1arr[0]=ptr_new(findgen(g1.ny-1) - (g1.ny-1)/2 )
k1arr[1]=ptr_new(findgen(g2.ny-1) - (g2.ny-1)/2 )
k1arr[2]=ptr_new(findgen(g3.ny-1) - (g3.ny-1)/2 )

k2arr[0]=ptr_new(findgen(g1.ny-1) - (g1.ny-1)/2 )
k2arr[1]=ptr_new(findgen(g2.ny-1) - (g2.ny-1)/2 )
k2arr[2]=ptr_new(findgen(g3.ny-1) - (g3.ny-1)/2 )

for i=0,2 do begin
dat=logfft(abs(*imarr[i])+1e-5)
sz=size(dat, /dimensions)
dat=congrid(dat, sz(0), sz(0))
bfg=g3.ny-1
bdat=dblarr(bfg,bfg)
bdat(*,*)=mean(dat[0,*])
bdat[0,0]=-0.6
bdat(0,1)=-8.9
sz=size(dat, /dimensions)
np=bfg/2-sz(0)/2
;bdat[np:np+sz-1,np:np+sz-1 ]=dat
mys=sz(0)
ll=bfg/2-mys/2
bdat[ll:ll+mys-1,ll:ll+mys-1]=dat

im2arr[i]=ptr_new(  bdat )
k1arr[i]=ptr_new(findgen(g3.ny-1) - (g3.ny-1)/2 )
k2arr[i]=ptr_new(findgen(g3.ny-1) - (g3.ny-1)/2 )
endfor

im5, imarr, titstr, xtitstr, ytitstr, xarr,yarr, k1arr, k2arr, im2arr, xtfarr, ytfarr


end
