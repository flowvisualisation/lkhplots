
pro invariants, tensor, invii, inviii


; calculate trace

tra=trace(tensor)
traa=trace(tensor^2)

invii=0.5d*(tra^2-traa)

inviii=determ(tensor)


end
