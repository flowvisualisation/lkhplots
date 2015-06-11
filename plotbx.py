

import pyPLUTO as pp
import pylab as pl


D=pp.pload(1)

print D.bx1.shape


pl.imshow(D.bx1[:,:,0])
pl.draw()
