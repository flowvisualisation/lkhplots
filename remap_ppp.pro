;
; --- remap shearingbox-data to closest periodic point
;     cf. Hawley et. al. (1995) ApJ 440

pro remap_PPP, data, g, c, vec=vec, ism=ism
  @astro_const

  s = size (data)
  if (not keyword_set(vec)) then begin  ; scalars

      case s[0] of        
          0 : return        
          2 : begin    ; --- create NIRVANA-type pseudo-3D-arrays for 2D
              dummy= fltarr(1, s[1], s[2])   
              dummy[0,*,*]= data[*,*]
              data = fltarr(1, s[1], s[2])   
          end
          3 : dummy = data
      endcase   

  endif else begin  ; --- vectors

      case s[0] of
          0 : return        
          3 : begin    ; --- dito for vector-quantities
              dummy = fltarr(s[1], 1, s[2], s[3])      
              dummy[*,0,*,*] = data[*,*,*]  
              data = fltarr(s[1], 1, s[2], s[3])   
          end
          4 : dummy = data
      endcase
  endelse

  shear = double(c.user[2]*c.user[3])
  if keyword_set(ism) then shear /= mks.pc
  time_mod = c.time mod ( g.Ly/double(shear*g.Lx) )

  for ix=0, g.nx-1 do begin  

      ym =  g.x[ix] * shear * time_mod
      idy = long( (ym-g.y[0]) / g.dy )
      ddy = ( ym mod g.dy ) / g.dy      
      pm  = ( ddy gt 0.0 ) ? +1 : -1
      ddy = abs(ddy)
      ady = 1.0-ddy

      if keyword_set(vec) then begin    ; --- vectors
        for iy=0, g.ny-1 do begin
          iyr = (iy+idy+g.ny) mod g.ny
          iy0 = (iyr+pm+g.ny) mod g.ny

          data[*,*,iy,ix] = ady *dummy[*,*,iyr,ix] $
                          + ddy *dummy[*,*,iy0,ix] 
        endfor

      endif else begin                  ; --- scalars
        for iy=0, g.ny-1 do begin
          iyr = (iy+idy+g.ny) mod g.ny
          iy0 = (iyr+pm+g.ny) mod g.ny

          data[*,iy,ix] = ady *dummy[*,iyr,ix] $
                        + ddy *dummy[*,iy0,ix] 
        endfor
      endelse
  endfor

  return
end
