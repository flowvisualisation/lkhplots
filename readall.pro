cgdisplay, xs=1100, ys=1300
pos=cglayout([1,6], ygap=2)

num=10
for num=0,990000,1000 do begin
if ( file_test('ex'+String(num,format='(I07)')+'.dat' ) ne 1) then begin
print, 'File does not exist ... exiting'
break
endif


readgenf, 'ne', num,de 
readgenf, 'ni', num,di 
readgenf, 'ex', num,ex 
readgenf, 'ey', num,ey 
readgenf, 'ez', num,ez 
readgenf, 'bx', num,bx 
readgenf, 'by', num,by 
readgenf, 'bz', num,bz 
sz=size(ex, /dimensions)
wp=1e4
wpi=1/wp
dt=1e-5*wpi
time=num*dt
x1=(findgen(sz(0))-sz(0)/2)/1e3
cgplot, x1, ex, pos=pos[*,0], title='t= '+string(time)+' seconds', ytitle='ex'
;cgplot, x1, ey, pos=pos[*,1], /noerase, ytitle='ey'
;cgplot, x1, ez, pos=pos[*,2], /noerase, ytitle='ez'
cgplot, x1, abs(de), pos=pos[*,1], /noerase, ytitle='de'
cgplot, x1, di, pos=pos[*,2], /noerase, ytitle='di'
cgplot, x1, bx, pos=pos[*,3], /noerase, ytitle='bx'
cgplot, x1, by, pos=pos[*,4], /noerase, ytitle='by'
cgplot, x1, bz, pos=pos[*,5], /noerase, ytitle='bz', xtitle='x [km]'
endfor

end
