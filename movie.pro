
nbeg=10
nstep=10
pload,1

window, xs=1900, ys=1200
!p.charsize=5
for nfile=nbeg,nlast,nstep do begin
pload,nfile
!p.multi=[0,3,2]

;erase
cgloadct,33

var=ptrarr(15)
var(0)= ptr_new(vx1(*,32,*))
var(1)= ptr_new(vx2(*,32,*))
var(2)= ptr_new(vx3(*,32,*))
var(3)= ptr_new(bx1(*,32,*))
var(4)= ptr_new(bx2(*,32,*))
var(5)= ptr_new(bx3(*,32,*))

xx=x1
yy=x3

titlstr=strarr(15,30)
titlstr(0,*)="V!DX!N (x,z) "
titlstr(1,*)="V!DY!N (x,z) "
titlstr(2,*)="V!DZ!N (x,z) "
titlstr(3,*)="B!DX!N (x,z) "
titlstr(4,*)="B!DY!N (x,z) "
titlstr(5,*)="B!DZ!N (x,z) "

for i=0,5 do begin
   pos = [0.09, 0.35, 0.98, 0.91]
localimagecopy=reform(*var(i))
 cgIMAGE, localimagecopy, POSITION=pos, /KEEP_ASPECT_RATIO ,background='white', scale=1
 cgcontour, localimagecopy, xx,yy,POSITION=pos, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=titlstr(i), $
       axiscolor='black',$
      xtitle='x ', ytitle='z'
imin=min(localimagecopy)-1e-6
imax=max(localimagecopy)+1e-6
cgcolorbar, Position=[pos[0], pos[1]-0.09, pos[2], pos[1]-0.08], range=[imin,imax], format='(G12.1)', annotatecolor='black'
endfor

omega=1.
torbit=2*!PI/omega

time_orbits=string(t(nfile)/torbit , format='(F6.2)')
xyouts, 0.01,0.01, "Time="+time_orbits+" orbits", color=cgcolor("black"), /normal


ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='mri'+zero+nts+'.jpeg'
im=cgsnapshot(filename=fname,/nodialog, /jpeg)

endfor


!p.multi=0
end
