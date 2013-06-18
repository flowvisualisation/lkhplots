function applyfilt, vx0, filter
return, real_part( FFT( FFT(vx0, -1) * filter, 1 ) )
end

