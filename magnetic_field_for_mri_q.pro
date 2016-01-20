
q=3.d/2.d

for i=1,9 do begin
q=1.+i*.1
kmax=q/2.d*sqrt(4.d/q-1.d)
b= 1.d/2.d/!DPI/kmax

print, q,1/q, b
endfor
end
