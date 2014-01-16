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
S = 1.0

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
#plt.ion ()
#plt.clf ()
plt.close ('all')

# Initial wave profile
t = 0.0
f = sin (kx[iy,ix]*x + ky[iy,ix]*y)
#image = plt.imshow (f)

# Time
tmax = 4/S
dt = 1.0/32
nt = int (tmax/dt)
nt=20

# Animate wave as it's advected by the background shear
for it in range (nt):
    # Increment time
    t += dt
    # Advance radial wave number
    kx -= S*dt*ky
    # New wave profile
    f = sin (kx[iy,ix]*x + ky[iy,ix]*y)
    # Array of Fourier amplitudes
    fk = fft_sheet (f, t)

    
    ifft_test = ifft(ifft(fk,axis=0),axis=1 )

    ifft_test_p=real(ifft_test)

    # Print out wave numbers and amplitude at ix and iy
    ampl = abs (fk[iy,ix])*2/(nx*ny)
    print 'kx = %.05f, ky = %.05f, ampl = %g' % (kx[iy,ix], ky[iy,ix], ampl)
    # Update figure
    f2, (ax1,ax2,ax3) = plt.subplots(1,3)
    ax1.imshow( f)
    ax1.set_title('Testarr')
    fft_test_p=log(abs(roll(roll(fk,64,axis=0),64,axis=1 ) ))
    ax2.imshow( fft_test_p)
    ax2.set_title('Sheared FFT of test')

    ax3.imshow( ifft_test_p)
    ax3.set_title('Sheared FFT of test')
    plt.pause(0.01)

    fname = 'tobi_fft_%03d.png'%it
    print 'Saving frame', fname
    f2.savefig(fname, format='png')
    plt.draw ()

# Turn off interactive mode
#plt.ioff ()
