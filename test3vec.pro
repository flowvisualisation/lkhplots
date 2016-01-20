; generate 9 random numbers
qq=randomu(1,9, /double)
print, qq

; 3 random vectors
a=qq[0:2]
b=qq[3:5]
c=qq[6:8]

; 3 symmetric dyads
f=a#a
g=b#b
h=c#c


; trace equals only nonnzero eigenvalue
print, 'trace (F)= ' , trace (f), ' =   max lambda (F)=', max(eigenql(f, /double))

; det of sum of 2 
print, 'det |F+G|  =', determ(f+g)
print, 'det |G+H|  =', determ(g+h)
print, 'det |F+H|  =', determ(f+h)
; det of sum of 3
print, 'det |F+G+H|=' , determ(f+g+h)

end
