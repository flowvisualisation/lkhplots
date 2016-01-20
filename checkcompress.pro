
qarr=[0.1,0.5,0.7,0.9,1.3,1.5,1.7,1.9]
nfile=60
for i=0,7 do begin
dirnum=qarr[i]
dirtag='q'+string(dirnum*10, format='(I02)')+'/'
;print, dirtag
PLOAD, nfile, DIR = dirtag, var='rho', /silent
print, qarr[i], min(rho), max(rho)
endfor

end
