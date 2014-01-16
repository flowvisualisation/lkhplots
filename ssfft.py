#!/usr/bin/env python

class Grid ():

    def __init__ (self, **kwds):

        from numpy import arange, meshgrid

        class MissingKeyword (Exception):
            def __init__ (self, name):
                self.msg = 'You need to set keyword argument "%s"' % name
            def __str__ (self):
                return self.msg

        def setAttr (name):
            try:
                setattr (self, name, kwds[name])
            except KeyError:
                raise MissingKeyword (name)

        setAttr ('Lx')
        setAttr ('Ly')
        setAttr ('nx')
        setAttr ('ny')

        self.dx = self.Lx/self.nx
        self.dy = self.Ly/self.ny

        x = (arange (self.nx) - 0.5*(self.nx - 1))*self.dx
        y = (arange (self.ny) - 0.5*(self.ny - 1))*self.dy

        self.x, self.y = meshgrid (x, y)

class ShearingSheetFFT ():

    def __init__ (self, grid):

        from numpy import pi, meshgrid
        from numpy.fft import fftfreq

        kx = 2*pi*fftfreq (grid.nx)/grid.dx
        ky = 2*pi*fftfreq (grid.ny)/grid.dy

        self.kx, self.ky = meshgrid (kx, ky)
        self.phase = self.ky*grid.x

    def forward (self, f, St):

        from numpy import exp
        from numpy.fft import fft

        fk = fft (f, axis=0) 
        fk *= exp (1j*St*self.phase)
        return fft (fk, axis=1)

    def backward (self, f):

        from numpy import exp
        from numpy.fft import ifft

        f = ifft (fk, axis=1) 
        f *= exp (-1j*St*self.phase)
        return ifft (f, axis=0)

import numpy as np
from matplotlib import pyplot as plt

# Computational grid
grid = Grid (Lx = 1.0, Ly = 1.0, nx = 128, ny = 128)
# Instatiate FFT class
fft = ShearingSheetFFT (grid)

# Coordinates
x = grid.x
y = grid.y

# Wave numbers
kx = fft.kx
ky = fft.ky

# Initial wave numbers (these should be integer)
ix, iy = 2, 1

# Initial wave profile
ampl = 2.6
phase = -0.3
f = ampl*np.cos (kx[iy,ix]*x + ky[iy,ix]*y + phase)

# Compute discrete Fourier transform
fk = fft.forward (f, 0.0)

# Normalization for Fourier amplitudes
norm = 2.0/(grid.nx*grid.ny)

# Diagnostic message
diag = 'kx = %.05f, ky = %.05f, ampl = %g'

# Print out Fourier amplitude at (iy,ix).
print diag % (kx[iy,ix], ky[iy,ix], abs (norm*fk[iy,ix]))

# Turn on interactive mode and clear figure
plt.ion ()
plt.clf ()

# Plot initial wave profile
image = plt.imshow (f)

# Rate of shear
S = 1.0

# Time
tend = 4.0/S
dt = 1.0/32

# Animate wave as it's advected by the background shear
t = 0.0
while t < tend:

    # Increment time
    t += dt

    # Advance radial wave number
    kx -= S*dt*ky

    # New wave profile
    f = ampl*np.cos (kx[iy,ix]*x + ky[iy,ix]*y + phase)

    # Compute discrete Fourier transform
    fk = fft.forward (f, S*t)

    # Print out Fourier amplitude at (ix,iy)
    print diag % (kx[iy,ix], ky[iy,ix], abs (norm*fk[iy,ix]))

    # Update plot
    #image.set_data (np.log(abs(np.roll(np.roll(fk,64,axis=0),64,axis=1) )))
    plt.draw ()
    plt.pause(0.01)

# Turn off interactive mode
plt.ioff ()
