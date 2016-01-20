nfile=nlast
;nbeg=0
nend=nlast
nstep=1
nbeg=max([0,nlast-nstep])
nbeg=nend
nbeg=10
nstep=10


xs=1100
ys=600
cgdisplay, xs=xs, ys=ys
y=rebin(reform(x2,1,nx2),nx1,nx2)
;pload,0
;rho0=rho

cs=1
omega=1
spawn," tail -2 pluto.ini | head -1", list
res=strsplit(list, /extract)   
betap=float(res[1])
;betap=6.0
b0=cs*cs/betap
h=sqrt(1+1/betap)*cs/omega
b0=sqrt(2*b0*exp(-y^2/(2*h^2) ))


for nfile=nbeg, nend, nstep do begin
pload,nfile

pos=cglayout([1,1], oxmargin=[9,5], oymargin=[9,5])

bx=reform(bx2(0,*,*))
by=reform(bx3(0,*,*))
bxs=reform(bx2s(0,*,*))
bys=reform(bx3s(0,*,*))
vx=reform(vx2(0,*,*))
vy=reform(vx3(0,*,*))
dat=alog10(reform(rho(0,*,*)))


px=pos[*,0]


usingps=0
spawn, 'basename $PWD', dirtag
fname="parker"+string(nfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*.6
endelse




dat[0,0]=-7
dat[0,1]=1.
imin=min(dat)
imax=max(dat)
r=cgscalevector(dat,1,254)
cgloadct,5
cgimage, r, pos=px
cgcontour, r, x2,x3, pos=pos[*,0], /nodata, /noerase, title='!8t!X='+string(t(nfile)/2./!DPI, format='(F4.1)')+' t!Dorb!N', xtitle='!8y/H!X', ytitle='!8z/H!X'

cgcolorbar, range=[imin, imax], pos=[px[2]+0.01,px[1],px[2]+0.02,px[3]] , /vertical, /right

pl=0
for qint=-2.0d,3.0d,0.35d do begin
seed=[0.0d,qint,0.0d]
myxq=x2
myyq=x3
bxx=bx
byy=by
field_line, bxx,byy,0,myxq,myyq,0,seed=seed ,pl , method="CK45", tol=1.e-5,  maxstep=100
cgplot, pl[0,*], pl[1,*], color=cgcolor('white'), /overplot

endfor

q1=13
q2=q1
bq1=congrid(vx,q1,q2)
bq2=congrid(vy,q1,q2)
qx1=congrid(x2,q1)
qx2=congrid(x3,q2)
;velovect,bq1, bq2, qx1,qx2 , /overplot, color=cgcolor('white')

;px=pos[*,1]
;cgplot, x2, rho[0,*], pos=px, /noerase, xtitle='y', xstyle=1
;cgplot, x2, rho0[0,*], pos=px, /noerase, /overplot, linestyle=2


if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
wait,1
endif
endfor

endfor

end
