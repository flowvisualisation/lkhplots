
function aaf, arr
return, alog10(abs(fft(arr, /center))+1e-6)
end
