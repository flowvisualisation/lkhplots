



import matplotlib.pyplot as plt
import numpy as np

# Simple data to display in various forms
x = np.linspace(0, 2 * np.pi, 400)
y = np.sin(x ** 2)


H = np.array([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]) 

testarr = sin (kx[iy,ix]*x + ky[iy,ix]*y)
fft_test = fft_sheet (testarr, t)
sim =D.vx1[:,:,0]
fft_sim = fft_sheet (sim, t)
fft_test_p=log(abs(np.roll(np.roll(fk2,64,axis=0),64,axis=1 ) ))
fft_sim_p=log(abs(np.roll(np.roll(fk3,64,axis=0),64,axis=1 ) ))



# Four axes, returned as a 2-d array
f, axarr = plt.subplots(2, 2)
axarr[0, 0].imshow( testarr)
axarr[0, 0].set_title('Axis [0,0]')
axarr[0, 1].imshow( sim)
axarr[0, 1].set_title('Axis [0,1]')
axarr[1, 0].imshow( fft_test_p)
axarr[1, 0].set_title('Axis [1,0]')
axarr[1, 1].imshow( fft_sim_p)
axarr[1, 1].set_title('Axis [1,1]')


plt.show()
