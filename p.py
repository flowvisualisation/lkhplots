import pyPLUTO as pp
wdir = './'
D = pp.pload(1,w_dir=wdir)
I = pp.Image()
f1 = pp.figure()
ax1 = f1.add_subplot(111)
I.pldisplay(D.vx2,x1=D.x1,x2=D.x2,cbar=(True,'vertical'),title='Velocity')
pp.show()

import matplotlib.pyplot as plt
plt.imshow(D.vx2)

plt.show()

