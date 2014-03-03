
pro reystressanisotropytensor, u1,u2,u3, rey

rey=[ [u1*u1, u1*u2, u1*u3],[u2*u1, u2*u2, u2*u3],[u3*u1, u3*u2, u3*u3]]



; turbulent kinetic energy
k=u1*u1+u2*u2+u3*u3
iden3=identity(3)/3.0d

rey=rey/k-iden3

end
