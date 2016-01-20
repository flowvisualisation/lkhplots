
q=3.d/2.d
s=q/2.d

k0=1.d/2.d ;/sqrt(2.d)
kx=k0
ky=k0
kf=sqrt(1-ky^2)

print, 'q=',q
print, 's=',s
print, 'k0=',k0
print, 'kf=',kf

t=(kf-k0)/q/ky
print,'t=',t
maxpar=0.19d
maxpar_2=maxpar/2.d
print , '1/2 max parasite', maxpar_2
amri=s*t
print, 'Amri',amri
apar=maxpar_2*t
print, 'Apar',apar, 'b'
print, format='(" = ", F5.1,"-", F5.1, "ln(R)")', 1.d/apar, amri/apar 

i=1
bcrit=amri/apar-1.d/apar*alog(10.d^(-1.d*i))
amp=[314,70.7,15.]
for j=0,2 do begin 
for i=1,6 do begin 
bcrit=amri/apar-1.d/apar*alog(10.d^(-1.d*i))
;print, i, ' & 1e-',i, '&', bcrit, ' & ',amp[j],'\\'
PRINT, FORMAT='(I2, " & 1e-", I0, "  & " ,F5.1, " & " ,F5.1, " \\" )', i+6*j,i, bcrit, amp[j]
endfor
endfor
end
