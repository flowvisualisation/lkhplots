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
Lx, Ly = 2.0, 2.0
# Number of grid points
nx, ny = 128, 128

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
ix, iy = 1, 1

# Turn on interactive mode and clear figure
plt.ion ()
plt.clf ()
plt.close('all')

# Initial wave profile
t = 0.0
f = sin (kx[iy,ix]*x + ky[iy,ix]*y)
#image = plt.imshow (f)

# Rate of shear
omega = 1e-3
q=1.5
S = q *omega

# Time
tmax = 4/S
dt = 1.0/32
dt =  1000
nt = int (tmax/dt)
nt=4

t=0
import pyPLUTO as pp
# Animate wave as it's advected by the background shear
for it in range (nt):
    # Increment time
    # Advance radial wave number
    # New wave profile
    testarr = sin (kx[iy,ix]*x + ky[iy,ix]*y)
    #testarr = sin (ky[iy,ix]*y )
    #testarr = sin (kx[ix,iy]*x + ky[ix,iy]*y)
    D=pp.pload(it)
    sim=D.vx3[:,:,0]
    # I am transposing here since the python script is in y,x not x,y
    #sim=transpose(D.vx3[:,:,0])
    f=sim
    fft_test = fft_sheet (testarr, t)
    fft_sim = fft_sheet (sim, t)

    fft_test_p=log(abs(roll(roll(fft_test,64,axis=0),64,axis=1 ) ))
    fft_sim_p=log(abs(roll(roll(fft_sim,64,axis=0),64,axis=1 ) ))

    ifft_test = ifft(ifft(fft_test,axis=0),axis=1)
    ifft_sim = ifft(ifft(fft_sim,axis=0),axis=1)

    ifft_test_p=real(ifft_test)
    ifft_sim_p=real(ifft_sim)

    t += dt
    kx -= S*dt*ky
    #ky = S*ky

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
#    fig = plt.figure(figsize=(2,2))
    f, axarr = plt.subplots(2, 3)
    axarr[0, 0].imshow( testarr)
    axarr[0, 0].set_title('Testarr')
    axarr[1, 0].imshow( sim)
    axarr[1, 0].set_title('Sim')

    axarr[0, 1].imshow( fft_test_p)
    axarr[0, 1].set_title('Sheared FFT of test')
    axarr[1, 1].imshow( fft_sim_p)
    axarr[1, 1].set_title('Sheared FFT of Sim')

    axarr[0, 2].imshow( ifft_test_p)
    axarr[0, 2].set_title('Sheared IFFT of FFT')
    axarr[1, 2].imshow( ifft_sim_p)
    axarr[1, 2].set_title('IFFT of Sheared FFT')

    fname = '_tmp%03d.png'%it
    print 'Saving frame', fname
    f.savefig(fname)
 
    plt.draw ()

# Turn off interactive mode
plt.ioff ()
