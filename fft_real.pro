filter= butterworth(size(vorty, /dimensions), order=3, cutoff=1)  
vixsm=FFT( FFT( vorty, -1) * filter, 1 ) 

cgloadct,33

display, real_part(vixsm), ims=5
