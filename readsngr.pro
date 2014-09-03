
t=fltarr(1)
vxmax=fltarr(1)
vzmax=fltarr(1)
for i=0,600,10 do begin
sload,i

t=[[t],[time]]
vxmax=[[vxmax],[max(vx)]]
vzmax=[[vzmax],[max(vz)]]

cgplot, t, vxmax, color='red', /ylog, yrange=[1e-1,2]
cgplot, t, vzmax, /overplot, color='green'
endfor
end
