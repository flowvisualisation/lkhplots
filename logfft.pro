function logfft, a
return, alog10(abs(fft(a, /center)))
end
