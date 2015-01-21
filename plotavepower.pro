
!p.multi=0
cgdisplay, xs=800,ys=600

cgerase

fname="powerave"+vtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse


colors[0]='black'
colors[1]='black'
colors[2]='black'
colors[3]='red'
lines[0]=0
lines[1]=1
lines[2]=2
lines[3]=3

 cgplot,k1, k1*maxave, /xlog, /ylog, xrange=[1,100], yrange=[1e-6,3e0], xstyle=1, color=colors['red'], ytitle='k |DFT('+vtag2+')|!U2!N', xtitle='kL', pos=[0.15,0.15,0.95,0.95], charsize=0.7*cgdefcharsize()
 cgplot,k1, k1*minave, /overplot , color=colors[1], linestyle=lines[1]
 cgplot,k1h,k1h*zave, /overplot , color=colors[2], linestyle=lines[2]
 cgplot,k1,k1*pave, /overplot , color=colors[3], linestyle=lines[3]

readcol, 'new.txt', num, angle

na=size(angle, /dimensions)

qa=30
qb=10

 a=k1*maxave
 kpexp = ( alog10(a[qa])- alog10(a[qb])) /  (alog10(k1[qa])-alog10(k1[qb])) 

qa=20
qb=10
 a=k1*minave
 ;khexp = alog10(abs( (a[qa]-a[qb]) / (alog10(k1[qa])-alog10(k1[qb])) 
 khexp = (alog10(a[qa])-alog10(a[qb]) ) / (alog10(k1[qa])-alog10(k1[qb])) 

qa=20
qb=11
 a=k1h*zave
 ;kzexp = alog10(abs( (a[qa]-a[qb]) / (alog10(k1h[qa])-alog10(k1h[qb])) 
 kzexp = (alog10(a[qa]) - alog10(a[qb])) / (alog10(k1h[qa])-alog10(k1h[qb])) 


qa=30
qb=12
 a=k1*pave
 ;krexp = alog10(abs( (a[qa]-a[qb]) / (k1[qa]-k1[qb]) ))
 krexp = ( alog10(a[qa])-alog10(a[qb]) ) / (alog10(k1[qa])-alog10(k1[qb])) 

print, kpexp,khexp,kzexp, krexp

th=5.5
thick=[th,th,th,th]

k1short=k1[4:20]
scrh= k1[qa]*maxave[qa]/k1[qa]^(kpexp)
 cgplot, k1short,1.3*scrh* k1short^(kpexp), /overplot,  color=colors[0], thick=thick[0]


scrh= k1h[qa]*zave[qa]/k1h[qa]^(kzexp)
k1hshort=k1h[4:20]
 cgplot, k1hshort, 1.3*scrh*k1hshort^(kzexp), /overplot,  color=colors[2], linestyle=lines[2], thick=thick[0]

k1short=k1[4:20]
scrh= k1[qb]*minave[qb]/k1[qb]^(khexp)
 cgplot, k1short, 1.3*scrh*k1short^(khexp), /overplot,  color=colors[1], linestyle=lines[1], thick=thick[0]


k1short=k1[4:20]
scrh= k1[qb]*pave[qb]/k1[qb]^(krexp)
 cgplot, k1short, 1.3*scrh*k1short^(krexp), /overplot,  color=colors[3], linestyle=lines[3], thick=thick[0]


ktest=findgen(100)+1
cgplot, ktest, ktest^(-3), /overplot

items[0]='k!D1!N, !9a!X!D1!N='+String(abs(kpexp), format='(F4.1)')
items[1]='k!D2!N, !9a!X!D2!N='+String(abs(khexp), format='(F4.1)')
items[2]='k!D3!N, !9a!X!D3!N='+String(abs(kzexp), format='(F4.1)')
items[3]='k!Dr!N, !9a!X!Dr!N='+String(abs(krexp), format='(F4.1)')



al_legend, items[0:3], colors=colors[0:3], linestyle=lines[0:3], charsize=0.5*cgdefcharsize(), /right, linsize=0.5, thick=thick

r= histogram( angle[0.25*na:na-1], locations=xbin)  
cgplot, xbin, smooth(r,8), xtitle='Angle !Uo!N', ytitle='Frequency', /noerase, pos=[0.25,0.28,0.45,0.5], charsize=0.5*cgdefcharsize(), xticks=3,xtickinterval=10, xrange=[20,50]


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor

 end
