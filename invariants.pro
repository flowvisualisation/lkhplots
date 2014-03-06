
pro invariants, tensor, invii, inviii


; calculate trace

tra=trace(tensor)
traa=trace(tensor##tensor)

invii=0.5d*(tra^2-traa)
a=tensor

;invii=a(0,0)*a(1,1) + a(1,1)*a(2,2) + a(0,0)*a(2,2)  -a(0,1)^2 -a(1,2)^2 -a(0,2)^2


inviii=determ(tensor)


end
