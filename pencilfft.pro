
varfile='VAR0'
for i=0,8,2 do begin
varfile='VAR'+strtrim(i,2)
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
;display, cgscalevector(f0.uu[*,*,0,2],2,254), ims=5
display, cgscalevector((abs(shift(fft(f0.uu[*,*,0,0]),(mx-6)/2,(my-6)/2))),2,254), ims=5

endfor


end
