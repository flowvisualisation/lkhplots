
; --- various general utility functions

pro stat, x0, x1, x2

  if n_params() ge 1 then begin
     help, x0 &  print, min(x0), mean(x0), max(x0) & endif
  if n_params() ge 2 then begin
     help, x1 &  print, min(x1), mean(x1), max(x1) & endif
  if n_params() ge 3 then begin
     help, x2 &  print, min(x2), mean(x2), max(x2) & endif

  return
end

; ---

PRO undef, x0, x1, x2, x3, x4
  if n_params() ge 1 then dummy = size(temporary(x0))
  if n_params() ge 2 then dummy = size(temporary(x1))
  if n_params() ge 3 then dummy = size(temporary(x2))
  if n_params() ge 4 then dummy = size(temporary(x3))
  if n_params() ge 5 then dummy = size(temporary(x4))
  return
END

; ---

pro dots
  print, fo='(%".",$)'
  return
end

; ---

function degr_label, axis, index, value
  return, string(value, format='(%"%d")')+tex2idl('\circ')
end

; ---

function tex2idl, str
  return, textoidl(str)
end

; ---

function range, rng, nel=nel
  sz=size(rng)
  if (sz[0] eq 0) then rng = [0,rng]
  if not keyword_set(nel) then nel=32
  return, findgen(nel)/(nel-1)*(rng[1]-rng[0]) + rng[0]
end

; ---

pro outs, st, pos=pos, ox=ox, oy=oy, _ref_extra=ext

  sg = [ +1, -1 ]
  if not keyword_set(ox)  then ox=0.15
  if not keyword_set(oy)  then oy=0.05
  if not keyword_set(pos) then pos=[1,0]

  xyouts, !x.window[pos[0]] + sg[pos[0]]*ox * (!x.window[1]-!x.window[0]), $
          !y.window[pos[1]] + sg[pos[1]]*oy * (!y.window[1]-!y.window[0]), $
          st, /normal, _extra=ext
  return
end

; ---

function def, x=x, default
  if not keyword_set(x) then return, default $
  else return, x
end

; ---

pro empty_keyboard_buffer
   repeat begin
      ans = get_kbrd(0)
   endrep until ans eq ''
   return
end

; ---

function get_mrange, t0, t1, dir=dir

   ; --- determine model range

   dir = def(x=dir, './')
   fr=(read_ascii(dir+'freq')).field1 
   nt=long(fr[0]) & it=long(fr[6]) & nt=nt/it*it

   it0=0 & repeat begin & it0+=it & grd_ctl, g,c,model=it0,dir=dir & endrep $
     until ( c.time ge t0*2.*!pi and it0 lt nt-1 ) 

   it1=nt & repeat begin & it1-=it & grd_ctl, g,c,model=it1,dir=dir & endrep $
     until ( c.time lt t1*2.*!pi and it1 gt 0 )

   return, [it0,it1,it]
end

; ---

pro pad_z, var, g, vec=vec, nz=nz

  nz = def(x=nz, 1)
  if((size(var))[0] eq 0) then return

  if (nz eq 1) then begin     ; pad with extra dimension

     if keyword_set(vec) then var = reform(var,[3,g.nz,g.ny,g.nx]) $
                         else var = reform(var,[g.nz,g.ny,g.nx])

  endif else begin            ; extend data axisymmetrically

     if keyword_set(vec) then begin
        new = dblarr(3,nz,g.ny,g.nx)
        for iv=0,2 do for iz=0,nz-1 do new[iv,iz,*,*] = var[iv,*,*]
     endif else begin
        new = dblarr(nz,g.ny,g.nx)
        for iz=0,nz-1 do new[iz,*,*] = var[*,*]
     endelse

     var=new
  endelse

  return
end

; ---

pro kontour, var,x,y, nl=nl, _ref_extra=ext

  nl=def(x=nl, 64)
  yr=def(x=yr, [min(var),max(var)])

  lvl = range(yr, nel=nl)
  wdg = lvl # [1,1]
  contour, wdg,lvl,[0,1], /fill, nl=nl, pos=[0.5,0.96,0.99,0.99], $
           /xsty, /ysty, xticklen=0.25, yticks=1, ytickn=[' ',' '], chars=1.5

  contour, var,x,y, /fill, lev=lvl, /xsty,/ysty, $
           xmar=[7,1], ymar=[4,4], _extra=ext, /noerase
end


; ---

pro colorbar, dta_r, nl=nl, key=key, bar_pos=bar_pos

  nl = def(x=nl, 32)
  key = def(x=key, '')
  bar_pos = def(x=bar_pos, [0.05,0.04,0.35,0.06])

  fn = 1.
  rn = max(abs(dta_r))
  if (rn lt .1) then $
     while (rn lt 1.) do begin & fn/=10. & rn*=10. & end
  if (rn gt 100.) then $
     while (rn gt 1.) do begin & fn*=10. & rn/=10. & end

  if (fn le .1 or fn ge 10.) then begin
     xfact = string(alog10(fn), fo='(%"\!MX!X 10!U%d!N")') 
  endif else xfact=' '

  ramp = dta_r[0] + (dta_r[1]-dta_r[0]) * findgen(nl+1)/nl & ramp /= fn
  bar = ramp # replicate(1.,2)
  contour, bar, ramp, [0,0.01]*ramp, charsize=1., $
           /fill, levels=ramp, xsty=1, ysty=1, $
           title=tex2idl(key), xtitle=xfact, position=bar_pos, $
           xticklen=0.15, yticks=1, ytickn=[' ',' '], /noerase
  return
end

; ---

pro infer_mean, fname, cidx, tmin=tmin

  tmin=def(x=tmin, 0)
  d=(read_ascii(fname)).field1 
  t=d[0,*] & nt=n_elements(t)

  it=0 & while( (it lt nt) and t[it] lt tmin ) do it++

  mn = mean(d[cidx,it:*])
  sd = stddev(d[cidx,it:*])

  plot, t, d[cidx,*], /nodata
  oplot, t, d[cidx,*], color=128, th=2
  oplot, t[it:*], 0*t[it:*]+mn
  oplot, t[it:*], 0*t[it:*]+mn-sd, lin=2
  oplot, t[it:*], 0*t[it:*]+mn+sd, lin=2

  print, mn, sd, fo='(%"%5.3f (%5.3f)")'

  return
end

; ---
  
pro infer_mean_ratio, fname, cidx0, cidx1, tmin=tmin, dump=dump

  tmin=def(x=tmin, 0)
  d=(read_ascii(fname)).field1 
  t=d[0,*] & nt=n_elements(t)

  it=0 & while( (it lt nt) and t[it] lt tmin ) do it++

  mn0 = mean(d[cidx0,it:*])
  sd0 = stddev(d[cidx0,it:*])

  mn1 = mean(d[cidx1,it:*])
  sd1 = stddev(d[cidx1,it:*])

  mn = mean((d[cidx0,it:*]/d[cidx1,it:*]))
  sd = stddev((d[cidx0,it:*]/d[cidx1,it:*]))

  plot, t, (d[cidx0,1:*]/d[cidx1,1:*]), /nodata, /ylog
  oplot, t, (d[cidx0,1:*]/d[cidx1,1:*]), color=128, th=2
  oplot, t[it:*], 0*t[it:*]+mn
  oplot, t[it:*], 0*t[it:*]+mn-sd, lin=2
  oplot, t[it:*], 0*t[it:*]+mn+sd, lin=2

  print, mn0,sd0, mn1,sd1, mn,sd, fo='(6e15.6)'

  if keyword_set(dump) then begin
     openw, lun, '../ratio.dat', /get_lun, /append
     printf,lun, mn0,sd0, mn1,sd1, mn,sd, fo='(6e15.6)'
     free_lun, lun
  endif

  return
end

; ---
  
pro infer_mean_stddev, data, mn=mn, sd=sd, nsub=nsub

  sz = size(data)

  if (sz[0] ne 2) then message, "only support 2D data"
  if not arg_present(mn) then message, "use 'mn=...' keyword"
  if not arg_present(sd) then message, "use 'sd=...' keyword"

  nsub = def(x=nsub, 4)

  nt=sz[1]
  nz=sz[2]

  ni = nt/nsub
  mn = fltarr(nsub,nz)
  sd = fltarr(nsub,nz)

  ; --- compute mean
  
  for isub=0,nsub-1 do $
     sd[isub,*] = total( data[isub*ni:(isub+1)*ni-1,*], 1 ) / ni

  mn = total(sd,1) / nsub

  ; --- compute standard deviation
  
  for isub=0,nsub-1 do $
     sd[isub,*] = ( mn[isub,*] - mn )^2

  sd = sqrt( total(sd,1) / nsub )

  return
end

; ---

function roll2d, dta, dn0, dn1

  sz = size(dta)
  n0 = sz[1] &  ne0 = n0/2*2
  n1 = sz[2] &  ne1 = n1/2*2

  dummy = dta[0:ne0-1,0:ne1-1]
  ret = fltarr(n0,n1)
  for i0=0,ne0-1 do $
     for i1=0,ne1-1 do $
        ret[i0,i1] = dummy[(i0+dn0) mod ne0,$
                           (i1+dn1) mod ne1]

  ; --- extend periodically

  if (ne0 ne n0) then ret[ne0,*] = ret[0,*]
  if (ne1 ne n1) then ret[*,ne1] = ret[*,0]

  return, ret
end

; ---

pro theta_calc, scale_heights

  print, scale_heights*[-1,1]*0.05/!pi+0.5, $
         fo='(%"%+12.8fe+00 %+12.8fe+00")'
  return
end

; ---
