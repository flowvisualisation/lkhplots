
!p.multi=0
readcol,'data/time_series.dat', it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax

items=['v1','v2', 'v3', 'b1', 'b2', 'b3','growth=0.75' ]
linestyles=[0,0,0,3,2,2,1]
psym=[0,1,2,3,4,5,6]
colors=['red', 'blue', 'green', 'orange', 'turquoise', 'purple', 'black']


maxall=max([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
minall=min([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])

cgplot, t, sqrt(ux2m), color=colors[0], linestyle=linestyles[0], /ylog, yrange=[max(sqrt(uz2m)), max(maxall)], ystyle=1
cgplot, t, sqrt(uy2m), /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, t, sqrt(uz2m), /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, t, sqrt(bx2m), /overplot, color=colors[3], linestyle=linestyles[3]
cgplot, t, sqrt(by2m), /overplot, color=colors[4], linestyle=linestyles[4]
cgplot, t, sqrt(bz2m), /overplot, color=colors[5], linestyle=linestyles[5]
cgplot, t, sqrt(ux2m[0])*exp(0.75*t), /overplot, color=colors[6], linestyle=linestyles[6]


fit=sqrt(ux2m[0])*exp(0.75*t)
dat=sqrt(ux2m)

nlines=size(t, /dimensions)
if ( nlines gt 80 ) then begin
print, (alog(fit[nlines])-alog(fit[nlines-10])) / (t[nlines]-t[nlines-10])
print, (alog(dat[nlines])-alog(dat[nlines-10])) / (t[nlines]-t[nlines-10])
endif

rho=1.d0
omega=1.d0
va=0.16437451
lfast=sqrt(15.d0/16.d0) *2.d0 *!PI  /omega/sqrt(rho) 
print, 1/lfast

	al_legend, items, colors=colors, linestyle=linestyles




end
