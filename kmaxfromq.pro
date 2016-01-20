
q=3.d/2.d
q=1.8d
q=1.4d

print, 'q, kmax, lz, bcrit'
for i=1.1,2.0,0.1 do begin
q=i
kmax=q/2.d *sqrt(4.d/q -1.d)

lz=2.d*!DPI/kmax

bcrit=1/kmax/2./!DPI
;print, 'q    =' ,q
;print, 'kmax =' , kmax
;print, 'lz   =' , lz
;print, 'bcrit=' , bcrit
print, q, kmax, lz, bcrit
endfor

end
