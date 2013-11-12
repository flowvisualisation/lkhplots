function chebypol ,x,n
sz=size(x, /dim)
x1=sz(0)
x2=sz(1)
cheby=fltarr(x1,x2)

if ( n le 1 ) then begin 
if ( n eq 0 ) then begin 
cheby(*,*)=1
endif else begin
cheby =x
endelse 
endif else begin
tn=fltarr(n+1,x1,x2)
tn[0,*,*]=1
tn[1,*,*]=x
for i=2,n do begin
tn[i,*,*]=2*x*tn[i-1,*,*] - tn[i-2,*,*] 

endfor
cheby=reform(tn[n,*,*])
endelse

return, cheby

end
