
r=h5_parse("particles.h5", /read)   
for i=0, 900,10 do begin

 rad=r.position._DATA[0,i,*]
th=r.position._DATA[1,i,*]
 cgplot, rad*Sin(th), rad*cos(th), psym=3, title=string(i)
wait, 1
endfor
end
