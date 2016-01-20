
d=alog10(abs(fftarr))
e=transpose(d)
 display, e(*,*,0)  ,  nwin=3, /hbar
 display, e(*,0,*)  , /hbar, nwin=2
;ang=0.d
;display, nwin=3, /hbar, ims=[500,500] , EXTRACT_SLICE( e,  800, 800, 200, 200, 200,ang,0,0), title='kx kz plane'
;ang=90.d
;display, nwin=4, /hbar, ims=[500,500] , EXTRACT_SLICE( e,  800, 800, 200, 200, 200,ang,0,0), title='ky kz plane'
ang=35.d
display, nwin=5, /hbar, ims=[500,500] , EXTRACT_SLICE( e,  400, 400/cos(ang*!DTOR), 200, 200, 200, ang, 0 , 0), title='k45 plane'
ang=65.d
display, nwin=4, /hbar, ims=[500,500] , EXTRACT_SLICE( e,  400, 400/sin(ang*!DTOR), 200, 200, 200, ang, 0 , 0), title='k'+string(ang)+' plane'
end

