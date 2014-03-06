pro reystressanisotropytensor, u1,u2,u3, rey

a=[u1, u2, u3]
rey=a#a
; turbulent kinetic energy
ke=total(a*a)
iden3=identity(3)/3.0d
rey=rey/ke-iden3

end
