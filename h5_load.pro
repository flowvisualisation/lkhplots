;
; --- load datasets from HDF5-file written by NIRVANA's dataHDF5()
;

function H5_read, model, dir=dir, w_bgr=w_bgr, remap=remap, $
                  rho=rho, p=p, T=T, v=v, B=B, gra=gra, eta=eta, $
                  ead=ead, ecr=ecr, $
                  mk3d=mk3d, fake3d=fake3d, fake_nz=fake_nz

  all = ( keyword_set(rho) + keyword_set(p) + keyword_set(T)        $
        + keyword_set(v)   + keyword_set(B) + keyword_set(phi)      $
        + keyword_set(eta) + keyword_set(ead) + keyword_set(ecr) ) 

  if not keyword_set(dir) then dir='./'
  if (model lt 1000000) $
    then fname = 'usr' + string(model, format='(%"%06d")') + '.h5' $
    else fname = 'usr' + string(model, format='(%"%07d")') + '.h5'
  file_id = H5F_open(dir+'/'+fname)

  if (all eq 0) then begin

      rho=0 & p=0 & T=0 & v=0 & B=0 & phi=0 & eta=0 & eta_ad=0 & ecr=0
      n = H5G_GET_NMEMBERS(file_id, '/')
      for i=1,n-1 do begin
          name = H5G_GET_MEMBER_NAME(file_id, '/', i)
          dset_id = H5D_open(file_id, name)
          case name of
              'density':             rho = H5D_read(dset_id)  
              'pressure':             p  = H5D_read(dset_id)  
              'temperature':          T  = H5D_read(dset_id)  
              'velocity':             v  = H5D_read(dset_id)  
              'magnetic_field':       B  = H5D_read(dset_id)  
              'potential':           phi = H5D_read(dset_id)  
              'eta':                 eta = H5D_read(dset_id)  
              'eta_ad':           eta_ad = H5D_read(dset_id)  
              'cosmic_ray_energy':   ecr = H5D_read(dset_id)  
          endcase
          H5D_close, dset_id
      end

  endif else begin

      if ( keyword_set(rho) ) then begin
          dset_id = H5D_open(file_id, 'density')
          rho = H5D_read(dset_id) 
          H5D_close, dset_id
      endif else rho=0

      if ( keyword_set(p) ) then begin
          dset_id = H5D_open(file_id, 'pressure')
          p = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else p=0

      if ( keyword_set(T) ) then begin
          dset_id = H5D_open(file_id, 'temperature')
          T = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else T=0

      if ( keyword_set(v) ) then begin
          dset_id = H5D_open(file_id, 'velocity')
          v = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else v=0

      if ( keyword_set(B) ) then begin
          dset_id = H5D_open(file_id, 'magnetic_field')
          B = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else B=0

      if ( keyword_set(gra) ) then begin
          dset_id = H5D_open(file_id, 'potential')
          phi = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else phi=0

      if ( keyword_set(eta) ) then begin
          dset_id = H5D_open(file_id, 'eta')
          eta = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else eta=0

      if ( keyword_set(ead) ) then begin
          dset_id = H5D_open(file_id, 'eta_ad')
          eta_ad = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else eta_ad=0

      if ( keyword_set(ecr) ) then begin
          dset_id = H5D_open(file_id, 'cosmic_ray_energy')
          ecr = H5D_read(dset_id)  
          H5D_close, dset_id
      endif else ecr=0

  endelse
  H5F_close, file_id
  grd_ctl, g, c, model=model+0, dir=dir ; read grid data and control parameters

  shear = c.user[2]*c.user[3]          ; according to macros in User.dec

  if keyword_set(remap) then begin     ; remap to closest periodic point
      remap_PPP, rho, g, c
      remap_PPP, p,   g, c
      remap_PPP, T,   g, c
      remap_PPP, v,   g, c, /vec
      remap_PPP, B,   g, c, /vec
      remap_PPP, phi, g, c
      remap_PPP, eta, g, c
      remap_PPP, eta_ad, g, c
      remap_PPP, ecr, g, c
  endif

  ; --- transform velocity to Lagrangian frame 
  if not keyword_set(w_bgr) then begin

      ; make sure we operate on Cartesian data

      spawn, "grep 'geo' nirvana.in | awk '{print $1}'", ret

      if ( stregex(ret[0],'CART|1') ge 0 ) then begin
         s = size(v)
         case s[0] of       
          0 : v = 0
          3 : for ix=0, g.nx-1 do  v[1,*,ix] = v[1,*,ix] - g.x[ix] * shear
          4 : for ix=0, g.nx-1 do  v[1, *,*,ix] = v[1,*,*,ix] - g.x[ix] * shear
         endcase
      endif ;else print, "info: non-cartesian data"
  endif

  if (keyword_set(mk3d) or keyword_set(fake3d)) $
     and (g.nz eq 1) then begin ; pad with z dimension
 
      fake_nz = def(x=fake_nz, 17)
      nz = keyword_set(fake3d) ? fake_nz : 1
      pad_z, rho, g, nz=nz
      pad_z, p,   g, nz=nz
      pad_z, T,   g, nz=nz
      pad_z, v,   g, nz=nz, /vec
      pad_z, B,   g, nz=nz, /vec
      pad_z, phi, g, nz=nz
      pad_z, eta, g, nz=nz
      pad_z, eta_ad, g, nz=nz
      pad_z, ecr, g, nz=nz
  endif 

  d = { rho:rho, p:p, T:T, v:v, B:B, phi:phi, $
        eta:eta, eta_ad:eta_ad, ecr:ecr }
  return, d
end

;
;  --- wrapper for old call as a procedure
;

pro H5_load, model, d, rho=rho, p=p, T=T, v=v, B=B, gra=gra, remap=remap

  d = H5_read(model, rho=rho, p=p, T=T, v=v, B=B, gra=gra, remap=remap)
  return
end

;
;  --- read z-slab from single dataset in 'usr.h5' file
;

function H5_read_slab_z, imd, dset_name, iz0

  ; --- read in data slab

  fn = H5_fname(model=imd)
  file_id = H5F_open(fn)
  dset_id = H5D_open(file_id, dset_name)

  fspc_id = H5D_get_space(dset_id)
  dims = H5S_get_simple_extent_dims(fspc_id)

  start = [ iz0, 0, 0 ]
  count = [ 1, dims[1], dims[2] ]
  stride= [ 1, 1, 1 ]

  H5S_select_hyperslab, fspc_id, start, count, stride=stride, /reset
  mspc_id = H5S_create_simple(count)

  data = H5D_read(dset_id, file_space=fspc_id, memory_space=mspc_id)
  H5D_close, dset_id
  H5F_close, file_id

  ; --- remove unused dimension
  sz = size(data)
  dim = (sz[0] eq 4) ? [sz[1],sz[3],sz[4]] : [sz[2],sz[3]]

  return, reform( data, dim )

end

;
;  --- shortcuts for space/time axes
;

function H5_x, kpc=kpc, nx=nx
  if not file_test('slices.h5') then return, 0
  x = H5d_read(H5d_open(H5f_open('slices.h5'), 'x'))
  if keyword_set(kpc) then x*=1.0e-03
  if arg_present(nx) then nx=n_elements(x)
  return, x
end

function H5_y, kpc=kpc, ny=ny
  if not file_test('slices.h5') then return, 0
  y = H5d_read(H5d_open(H5f_open('slices.h5'), 'y'))
  if keyword_set(kpc) then y*=1.0e-03
  if arg_present(ny) then ny=n_elements(y)
  return, y
end

function H5_z, kpc=kpc, nz=nz, fn=fn, vn=vn

  fn = def(x=fn, 'profile.h5')
  vn = def(x=vn, 'z')

  if not file_test(fn) then return, 0

  z = H5d_read(H5d_open(H5f_open(fn), vn))
  if keyword_set(kpc) then z*=1.0e-03
  if arg_present(nz) then nz=n_elements(z)
  return, z
end

function H5_t, myr=myear, gyr=gyear, it=it, nt=nt, fn=fn
  @astro_const

  fn = def(x=fn, 'profile.h5')
  if not file_test(fn) then return, 0

  time = H5d_read(H5d_open(H5f_open(fn),'time'))
  if keyword_set(myear) then time /= Myr
  if keyword_set(gyear) then time /= Myr*1000.
  if keyword_set(it) then time = time[it[0]:it[1]:it[2]]
  if arg_present(nt) then nt=n_elements(time)
  
  return, time
end

;
; --- thin out data while reading 'profile.h5'
;

function H5_pr, var, it=it, fname=fname, gname=gname, dir=dir

  if not keyword_set(fname) then fname='profile.h5'
  if not keyword_set(gname) then gname='/'
  if keyword_set(dir) then fname=dir+fname

  file_id = H5f_open(fname)
  group_id = H5g_open(file_id,gname)
  dset = H5d_open(group_id, var)

  if keyword_set(it) then begin
      fspc = H5d_get_space(dset)
      dims = H5s_get_simple_extent_dims(fspc)

      start = [ it[0], 0 ]
      count = [ (it[1]-it[0])/it[2]+1, dims[1] ]
      stride= [ it[2], 1 ]

      H5s_select_hyperslab, fspc, start, count, stride=stride, /reset
      mspc = H5s_create_simple(count)

      dta = H5d_read(dset, file_space=fspc, memory_space=mspc)
  endif else begin
      dta = H5d_read(dset)
  endelse

  H5d_close, dset
  H5g_close, group_id
  H5f_close, file_id
  return, dta
end

;
; --- select subblock from file 'slices.h5'
;

function H5_sl, var, it=it, fname=fname, dir=dir, id=id, x=x, y=y, z=z

  fname= def(x=fname, 'slices.h5')
  dir  = def(x=dir,   '/xy')
  id   = def(x=id,    0)

  file_id = H5f_open(fname)
  group_id = H5g_open(file_id,dir)

  res = H5G_get_member_name(group_id, dir, id)
  dset_id = H5D_open(group_id, dir+'/'+res+'/'+var)

  if keyword_set(it) then begin
      fspc = H5d_get_space(dset_id)
      dims = H5s_get_simple_extent_dims(fspc)

      start = [ it[0], 0, 0 ]
      count = [ (it[1]-it[0])/it[2]+1, dims[1], dims[2] ]
      stride= [ it[2], 1, 1 ]

      H5s_select_hyperslab, fspc, start, count, stride=stride, /reset
      mspc = H5s_create_simple(count)

      dta = H5d_read(dset_id, file_space=fspc, memory_space=mspc)
  endif else begin
      dta = H5d_read(dset_id)
  endelse

  H5d_close, dset_id
  H5g_close, group_id
  H5f_close, file_id

  if arg_present(x) then x = h5_dread(fname, 'x')
  if arg_present(y) then y = h5_dread(fname, 'y')
  if arg_present(z) then z = h5_dread(fname, 'z')

  return, dta
end

;
; --- generic "read dataset 'x' from file 'y' routine"
;

function H5_dread, fname, dname
  f_id = H5f_open(fname)  &  d_id = H5d_open(f_id, dname)
  dta = H5d_read(d_id)  &  H5d_close, d_id  &  H5f_close, f_id
  return, dta
end

;
; --- generic "read attribute 'x' from file 'y' routine"
;

function H5_aread, fname, aname
  f_id = H5f_open(fname)  &  g_id = H5g_open(f_id, '/')
  a_id = H5a_open_name(g_id, aname)
  dta = H5a_read(a_id)  
  H5a_close, a_id  &  H5g_close, g_id  &  H5f_close, f_id
  return, dta
end

;
; --- create data structure from file 'units'
;

function code_units

   if not file_test('units') then begin
       print, "warning: file 'units' not found"
       return, { l:1., t:1., rho:1., m:1., v:1., f:1.}

   endif else begin
       f=dblarr(6)
       openr, lun, 'units', /get_lun
       readf, lun, f & close, lun & free_lun, lun
       return, { l:f[0], t:f[1], rho:f[2], m:f[3], v:f[4], $
                 f:f[5], B:sqrt(f[3]/f[0])/f[1] }
   endelse
end

;
; --- generic "write dataset 'x' to file 'y' routine"
;
pro H5_fwrite, fname, dname, data

  sz=size(data)  

  dims=sz[1:sz[0]]
  if file_test(fname+'.h5') then begin
     fileID = H5F_open(fname+'.h5', /write) 
  endif else begin
     fileID = H5F_create(fname+'.h5')
  endelse

  spacID = H5S_create_simple(dims)
  typeID = H5T_IDL_CREATE(data[0,0])
  dataID = H5D_create(fileID, dname, typeID, spacID)
  H5D_write, dataID, data
  H5S_close, spacID  &  H5D_close, dataID
  H5F_close, fileID

  return
end

;
; --- generic "write dataset 'x' to file"
;
pro H5_dwrite, fileID, dname, data

  sz=size(data)  

  dims=sz[1:sz[0]]
  spacID = H5S_create_simple(dims)
  typeID = H5T_IDL_CREATE(data[0,0])
  dataID = H5D_create(fileID, dname, typeID, spacID)
  H5D_write, dataID, data
  H5S_close, spacID  &  H5D_close, dataID

  return
end
