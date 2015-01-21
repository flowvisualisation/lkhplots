
for i=0,90,5 do begin

fname="ang"+string(i, format='(I04)')
 slice = EXTRACT_SLICE( e, 400, 400, 200, 200, 200, !DPI/2, !DPI/2-!DPI/180.*i, 0, OUT_VAL=0B, /radians)
bb=slice[201:399,*]
 display, alog10 (bb+1e-13), title='t'+string(90-i)+' degrees', /hbar, label1='k', label2='z', ims=[1100,1100]
im=cgsnapshot(filename=fname, /jpeg, /nodialog)
endfor
end
