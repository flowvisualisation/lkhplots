

pro alf2, br,bz,bth,vr,vz,d,p,mf,ma,ms
va=sqrt(br^2+bz^2)/sqrt(d)
va2=va^2

vs2=((5./3.)* p /d)
vs=sqrt(vs2)

btot2 = br^2 +  bz^2 + bth^2 

cfast2 = 0.5*( vs2 +btot2/d + sqrt( (vs2 +btot2/d)^2  -4.0*vs2*va2 )  )

cslow2 = 0.5*( vs2 +btot2/d - sqrt( (vs2 +btot2/d)^2  -4.0*vs2*va2 )  )
cfast=sqrt(cfast2)
cslow=sqrt(cslow2)

vpol=sqrt(vr^2 + vz^2)

mf=vpol/cfast
ma=vpol/va
ms=vpol/cslow

print, min(abs(mf)),min(mf), max(mf)
print, min(abs(ma)),min(ma), max(ma)
print, min(abs(ms)),min(ms), max(ms)
end
