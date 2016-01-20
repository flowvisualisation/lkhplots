 a=[1,2,7]
 b=[2,2,7]
 max=a#a       
 maxave=a#a+b#b
 print, determ((max)/trace(max)-identity(3))      
 print, determ((maxave)/trace(maxave)-identity(3))
 end
