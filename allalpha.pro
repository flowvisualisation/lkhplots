pload, 0, dir='q01', /nodata
nfile=50
tptr=ptrarr(12)

qarr=[0.1,0.5,0.7,0.9,1.3,1.5,1.7,1.9]
for i=0,7 do begin

dirnum=qarr[i]
tag1=string(dirnum, format='(F4.1)')
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
PLOAD, nfile, DIR = dirtag, /silent
mx=bx1*bx2
ry=rho*vx1*vx2

alpha=(ry-mx)/rho^1.6666667
alphamean=mean(alpha)

print, tag1, alphamean
endfor

end
