

for nfile=1,10 do begin


sload,nfile


;; compute global alpha


cs=1e-3
alpha=(vx*vy -bx*by) / cs;-vx*(vy- )


print, total(alpha)/(nx*1.0*ny*nz)

;; compute global or max invii or inviii

;; could just read it in from hdf5 file

;h5_parse, 'inv.h5', /data






endfor





end
