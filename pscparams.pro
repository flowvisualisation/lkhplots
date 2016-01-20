
      qq=1.6021e-19
      mm=9.1091e-31
      tt=1.602176487e-14
      cc=3.0e8
      eps0=8.8542e-12
      pi=3.1415927

  n0=2e10*mm*eps0/qq^2
      wp=sqrt(qq^2*n0/eps0/mm)
     lw=2*pi*cc/wp

    massrat=250.
        wpi=wp/sqrt(massrat)

     print,'wp', wp
     print,'wpi', wpi
     print, 'n0', n0

     print, 'electron skin depth', cc/wp
     print, 'ion skin depth', cc/wpi


     vb=0.6268
     vthelec=0.825*vb
     vthion=vthelec/sqrt(massrat)

     print, 'vb', vb
     print, 'vthelec', vthelec
     print, 'vthion', vthion

     print, 'electron debye length', vthelec*cc/wp
     print, 'ion debye depth', vthion*cc/wpi


           wl=2.0*pi*cc/lw
      ld=cc/wl
      e0=mm*cc*wp/qq
      b0=e0/cc


      print, 'b0',b0

      end
