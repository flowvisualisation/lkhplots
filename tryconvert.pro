
n=10
r=findgen(n)/n+1
phi=findgen(n)/n*2*!PI
z=findgen(n)/n
; cv_coord

cylin=[[phi],[r],[z]]
cylin=transpose(cylin)
help,cylin
rect_coord=cv_coord(from_cylin=cylin, /to_rect, /degrees, /double)



end
