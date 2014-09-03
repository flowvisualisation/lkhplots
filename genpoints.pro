openw,lun, 'idlkpoints.txt' , /get_lun
nc=15
r=0.04
for j=0,nc do begin
th=j*2.*!DPI/nc
a=r*cos(th)
b=r*sin(th)
;print, r*cos(th), ',',r*sin(th)

c45=cos(!DPI/4.)
s45=sin(!DPI/4.)
;; problem
x=0.37+a*c45+b*s45
y=x
z=0.25+b
printf,lun,  x,',',y,',',z
;; problem
x=0.41+a*c45+b*s45
y=x
z=0.30+b
printf,lun,  x,',',y,',',z

;; ok
x=0.15+a*c45+b*s45
y=x
z=-0.25+b
printf,lun, x,',',y,',',z

;; problem
x=-0.34+a*c45+b*s45
y=x
z=-0.25+b
printf,lun, x,',',y,',',z

;;ok
x=-0.15+a*c45+b*s45
y=x
z= 0.25+b
printf,lun, x,',',y,',',z
endfor

close, lun
end
