
pro nearshear, qarr, closestshear

;qarr=[0.1, 0.3,0.7,0.9,1.1,1.3,1.4,1.5,1.6,1.7,1.8,1.9]
;closestshear=dblarr(14)
;closestshear(*)=1.0

nsim=10
for i=0, nsim do begin
dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'

minq=1
for nfile=40000,54000,2000 do begin 
grd_ctl, model=nfile, g,c ,dir=dirtag
;print, qarr[i], nfile, c.time/(3/qarr[i]) 
qq= c.time/(3.0/qarr[i]) 
if ( (qq mod 1 ) le minq) then begin
minq=(qq mod 1)
print,qarr[i], ' , n= ', nfile, ' , minq', minq
closestshear[i]=nfile
endif

endfor
print, ' '
endfor

for i=0,nsim do begin
dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
nfile=closestshear[i]
grd_ctl, model=nfile, g,c ,dir=dirtag
qq= c.time/(3.0/qarr[i])
minq=qq mod 1
print, qarr[i], closestshear[i],minq
endfor
end
