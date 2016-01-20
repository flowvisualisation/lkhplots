;
; seek for appropriate H5-file

function H5_fname, model=model, dir=dir

  dir = def(x=dir, './')

  if keyword_set(model) then md=model else md=0l 

  if (md lt 1000000) $
    then fname = dir + 'usr' + string(md, format='(%"%06d")') $
    else fname = dir + 'usr' + string(md, format='(%"%07d")') 

  suf = [ '', '.1', '.01', '.001', '.0001', '.00001' ] & i=5

  while i gt 0 and not file_test(fname+suf[i]+'.h5') do i--

  return, fname+suf[i]+'.h5'
end

;
; check if we have AMR data

function is_amr, model=model

  if keyword_set(model) then md=model else md=0l 

  fname = H5_fname(model=md)
  file_id = H5F_open(fname)

  stat = H5G_get_objinfo(file_id, 'density')
  if (stat.type eq 'DATASET') then amr = 0 else amr = 1
  h5f_close, file_id

  return, amr
end

;
; load grid/control information from HDF5-file

pro grd_ctl, g, c, model=model, dir=dir, fake3d=fake3d, fake_nz=fake_nz

  fname = H5_fname(model=model, dir=dir)
  file_id = H5F_open(fname) 

  stat = H5G_get_objinfo(file_id, 'density')
  if (stat.type eq 'DATASET') then dset_id = H5D_open(file_id, 'density') $
                              else dset_id = H5D_open(file_id, '/density/L0/B0')
  
  dspc_id = H5D_get_space(dset_id)
  rank    = H5S_get_simple_extent_ndims(dspc_id)
     
  dims = H5A_read(H5A_open_name(dset_id, 'domain'))
  orig = H5A_read(H5A_open_name(dset_id, 'origin'))
  spac = H5A_read(H5A_open_name(dset_id, 'spacings'))

  H5S_close, dspc_id
  H5D_close, dset_id

  dset_id = H5D_open(file_id, '_header')
  c = H5D_read(dset_id)
  if(c.unit>3e+16) then c.unit=1.
  H5D_close, dset_id
  H5F_close, file_id

  if (rank eq 2) then begin
      nx = dims[0]  &  ny = dims[1]     
      dx = spac[0]  &  dy = spac[1]  
      Lx = (nx-1) * dx  &  Ly = (ny-1) * dy     
      
      g = { _2D, nx:nx, ny:ny, nz:1, Lx:Lx, Ly:Ly, dx:dx, dy:dy, $
            x: dblarr(nx), y: dblarr(ny), xa: dblarr(nx-1), ya: dblarr(ny-1) }

      if keyword_set(fake3d) then begin ; extend grid axisymmetrically

         fake_nz = def(x=fake_nz, 17)

         Lz = 2.*!pi & dz = 2.*!pi/fake_nz  
         g = { _3D, inherits _2D, Lz:Lz, dz:dz, $
               z:dblarr(fake_nz), za:dblarr(fake_nz-1) }
         g.nx = nx & g.ny = ny & g.nz=fake_nz 
         g.Lx = Lx & g.Ly = Ly
         g.dx = dx & g.dy = dy

         g.z = range([0,Lz], nel=fake_nz)
         g.za = range([0,Lz], nel=fake_nz-1) + 0.5*dz

         g.Lz *= c.unit & g.z *= c.unit & g.za *= c.unit & g.dz *= c.unit
      endif
     
      g.x[0]=orig[0]  &  for ix=1,nx-1 do  g.x[ix] = g.x[ix-1] + dx
      g.y[0]=orig[1]  &  for iy=1,ny-1 do  g.y[iy] = g.y[iy-1] + dy

      g.xa[0]=orig[0]+0.5*dx  &  for ix=1,nx-2 do  g.xa[ix] = g.xa[ix-1] + dx
      g.ya[0]=orig[1]+0.5*dy  &  for iy=1,ny-2 do  g.ya[iy] = g.ya[iy-1] + dy

      g.Lx *= c.unit &  g.Ly *= c.unit
      g.x  *= c.unit &  g.y  *= c.unit
      g.xa *= c.unit &  g.ya *= c.unit
      g.dx *= c.unit &  g.dy *= c.unit

  endif else begin
      nx = dims[0]  &  ny = dims[1]  &  nz = dims[2]
      dx = spac[0]  &  dy = spac[1]  &  dz = spac[2]   
      Lx = (nx-1) * dx  &  Ly = (ny-1) * dy  &  Lz = (nz-1) * dz
      
      g = { nx:nx, ny:ny, nz:nz,  Lx:Lx, Ly:Ly, Lz:Lz, dx:dx, dy:dy, dz:dz, $
            x: dblarr(nx),  y: dblarr(ny),  z: dblarr(nz), $
            xa: dblarr(nx-1), ya: dblarr(ny-1), za: dblarr(nz-1) }

      g.x[0] = orig[0]  &  for ix=1,nx-1 do  g.x[ix] = g.x[ix-1] + dx
      g.y[0] = orig[1]  &  for iy=1,ny-1 do  g.y[iy] = g.y[iy-1] + dy
      g.z[0] = orig[2]  &  for iz=1,nz-1 do  g.z[iz] = g.z[iz-1] + dz

      g.xa[0]=orig[0]+0.5*dx  &  for ix=1,nx-2 do  g.xa[ix] = g.xa[ix-1] + dx
      g.ya[0]=orig[1]+0.5*dy  &  for iy=1,ny-2 do  g.ya[iy] = g.ya[iy-1] + dy
      g.za[0]=orig[2]+0.5*dz  &  for iz=1,nz-2 do  g.za[iz] = g.za[iz-1] + dz

      g.Lx *= c.unit &  g.Ly *= c.unit &  g.Lz *= c.unit
      g.x  *= c.unit &  g.y  *= c.unit &  g.z  *= c.unit
      g.xa *= c.unit &  g.ya *= c.unit &  g.za *= c.unit
      g.dx *= c.unit &  g.dy *= c.unit &  g.dz *= c.unit
 
  endelse
  return
end 
    
