
q=3.d/2.d
q=1.8d
q=1.4d

kmax=q/2.d *sqrt(4.d/q -1.d)

lz=2.d*!DPI/kmax

bcrit=1/kmax/2./!DPI
print, 'q    =' ,q
print, 'kmax =' , kmax
print, 'lz   =' , lz
print, 'bcrit=' , bcrit

end
