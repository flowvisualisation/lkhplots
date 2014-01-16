#!/usr/bin/env python

from numpy import *
from numpy.fft import *
from matplotlib import pyplot as plt

# 2D FFT in the shearing sheet.
# (This assumes that f is periodic at t=0)
def fft_sheet (f, t):
    # Transform along y
    fk = fft (f, axis=0) 
    # Phase shift (to make periodic in x)
    fk *= exp (1j*S*t*ky*x)
    # Transform along x
    return fft (fk, axis=1)

# Inverse FFT
def ifft_sheet (fk, t):
    # Transform along x
    f = ifft (fk, axis=1) 
    # Phase shift
    f *= exp (-1j*S*t*ky*x)
    # Transform along x
    return ifft (f, axis=0)

# Box size
Lx, Ly = 1.0, 1.0
# Number of grid points
nx, ny = 128, 128

# Rate of shear
S = 1.

# Grid spacing
dx = Lx/nx
dy = Ly/ny

# Coordinates
x = (arange (nx) - 0.5*(nx - 1))*dx
y = (arange (ny) - 0.5*(ny - 1))*dy
x, y = meshgrid (x, y)

# Wave numbers
kx = 2*pi*fftfreq (nx)/dx
ky = 2*pi*fftfreq (ny)/dy
kx, ky = meshgrid (kx, ky)

# Initial wave numbers (these should be integer)
ix, iy = 2, 1

# Turn on interactive mode and clear figure
plt.ion ()
plt.clf ()

# Initial wave profile
t = 0.0
f = sin (kx[iy,ix]*x + ky[iy,ix]*y)
image = plt.imshow (f)

# Time
tmax = 4/S
dt = 1.0/32
#omega = 1e-3
#dt = omega * 1
nt = int (tmax/dt)
#nt=6

import pyPLUTO as pp
# Animate wave as it's advected by the background shear
for it in range (nt):
    # Increment time
    t += dt
    # Advance radial wave number
    kx -= S*dt*ky
    # New wave profile
    testarr = sin (kx[iy,ix]*x + ky[iy,ix]*y)
    D=pp.pload(it)
    sim=D.vx1[:,:,0]
    f=sim
    fft_test = fft_sheet (testarr, t)
    sim =D.vx1[:,:,0]
    fft_sim = fft_sheet (sim, t)
    fft_test_p=log(abs(roll(roll(fft_test,64,axis=0),64,axis=1 ) ))
    fft_sim_p=log(abs(roll(roll(fft_sim,64,axis=0),64,axis=1 ) ))


    #plt.imshow(f)
    # Array of Fourier amplitudes
    fk = fft_sheet (f, t)
    # Print out wave numbers and amplitude at ix and iy
    ampl = abs (fk[iy,ix])*2/(nx*ny)
    print 'kx = %.05f, ky = %.05f, ampl = %g' % (kx[iy,ix], ky[iy,ix], ampl)
    # Update figure
    #image.set_data (f)
    #plt.imshow(abs(fk))
    #plt.plot(abs(fk[0,:]))
    f, axarr = plt.subplots(2, 2)
    axarr[0, 0].imshow( testarr)
    axarr[0, 0].set_title('Testarr')
    axarr[0, 1].imshow( sim)
    axarr[0, 1].set_title('Sim')
    axarr[1, 0].imshow( fft_test_p)
    axarr[1, 0].set_title('Sheared FFT of test')
    axarr[1, 1].imshow( fft_sim_p)
    axarr[1, 1].set_title('Sheared FFT of Sim')
 
    plt.draw ()

# Turn off interactive mode
plt.ioff ()
