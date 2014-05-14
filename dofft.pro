
a=randomn(0,64L*64L*64L)

b=reform(a,64L,64L,64L)

b=vx3
print, max(b)

fb=fft(b)

b2=fft(fb, /inverse)

print, max(b2)

end
