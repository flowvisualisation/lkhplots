
spawn, 'ls', list2
list=grep( 'usr', list2)
sz=size(list, /dimensions)
file=list[sz(0)-1]

str=strmid(file,3,6 )
xs=1600
ys=1200
cgdisplay, xs=xs, ys=ys
num=long(str)
numstr=string(num, format='(I06)')
r=h5_parse("stf-v/stf"+numstr+".h5", /read_Data)


pos=cglayout([3,3], xgap=11, ygap=2, oxmargin=[15,5], oymargin=[16,5])

ytitstr=strarr(9)
ytitstr[0]='S!Ux!N!Dp!N(l!Dx!N)/S!Ux!N!Dp!N(1)'
ytitstr[1]='S!Ux!N!Dp!N(l!Dy!N)/S!Ux!N!Dp!N(1)'
ytitstr[2]='S!Ux!N!Dp!N(l!Dz!N)/S!Ux!N!Dp!N(1)'
ytitstr[3]='S!Uy!N!Dp!N(l!Dx!N)/S!Uy!N!Dp!N(1)'
ytitstr[4]='S!Uy!N!Dp!N(l!Dy!N)/S!Uy!N!Dp!N(1)'
ytitstr[5]='S!Uy!N!Dp!N(l!Dz!N)/S!Uy!N!Dp!N(1)'
ytitstr[6]='S!Uz!N!Dp!N(l!Dx!N)/S!Uz!N!Dp!N(1)'
ytitstr[7]='S!Uz!N!Dp!N(l!Dy!N)/S!Uz!N!Dp!N(1)'
ytitstr[8]='S!Uz!N!Dp!N(l!Dz!N)/S!Uz!N!Dp!N(1)'


datptr=ptrarr(9)
datptr[0]=ptr_new(r.sxx._DATA)
datptr[1]=ptr_new(r.sxy._DATA)
datptr[2]=ptr_new(r.sxz._DATA)
datptr[3]=ptr_new(r.syx._DATA)
datptr[4]=ptr_new(r.syy._DATA)
datptr[5]=ptr_new(r.syz._DATA)
datptr[6]=ptr_new(r.szx._DATA)
datptr[7]=ptr_new(r.szy._DATA)
datptr[8]=ptr_new(r.szz._DATA)

ymax=11
ymin=0


xtit=''

delstr='!9D!X'

usingps=0
spawn, 'basename $PWD', dirtag
fname="structurefunction"+dirtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omegastr='!9W!X'
delstr='!9D!X'
endif else  begin
set_plot, 'x'
omegastr='!7X!X'
delstr='!9D!X'
charsize=cgdefcharsize()*.6
endelse

xtitstr=strarr(9)
xtitstr[0]=''
xtitstr[1]=''
xtitstr[2]=''
xtitstr[3]=''
xtitstr[4]=''
xtitstr[5]=''
xtitstr[6]='l!Ix!N/'+delstr
xtitstr[7]='l!Iy!N/'+delstr
xtitstr[8]='l!Iz!N/'+delstr

cgerase
for i=0,8 do begin
xtickf="(a1)"
ytickf="(a1)"

if ( (i mod 3) eq 0 ) then begin
ytickf="(I10)"
endif

if ( i  gt 5 ) then begin
xtickf="(I4)"
endif

;dat=findgen(10)
arr=*datptr[i]
dat=arr[*,0]/arr[0,0]
sz=size(dat, /dimensions)
l=findgen(sz(0))+1
cgplot, l,alog10(dat), pos=pos[*,i], /noerase, /xlog,  xrange=[0.5,800],  $
    xtickformat=xtickf,$
    ytickformat=ytickf,$
    xtitle=xtitstr[i], $
    ytitle=ytitstr[i], $
    yrange=[ymin,ymax];, psym=-1
    cgtext, l(sz(0)-3) , alog10(dat(sz(0)-1)), string(0, format='(I2)'), charsize=cgdefcharsize()*.6
for q=1,10  do begin
dat=arr[*,q]/arr[0,q]
cgplot, l, alog10(dat), pos=pos[*,i], /overplot, /noerase ;, psym=-1
    cgtext, l(sz(0)-3) , alog10(dat(sz(0)-1)), string(q, format='(I2)'), charsize=cgdefcharsize()*.6
endfor

endfor



if ( usingps ) then begin
cgps_close, /jpeg,  Width=2400, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor





end
