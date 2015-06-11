FUNCTION aver,a,axis,array=array,sum=sum
;+
; FUNCTION aver,a
;  Calculate the average.  Avoid accumulation roundoff by
;  using the /double key word.
;-
  sz=size(a)
  if keyword_set(axis) then begin
    if max(axis) gt sz[0] then begin                                            ; guard against last index having been dropped
      w = where(axis le sz[0], nw)                                              ; ignore axes which are not there
      if nw gt 0 then axis=axis(w) else return, a                               ; if no axis left we are done
    end
  end
  ;if keyword_set(cm) then a=arg(3:s(1)-5,*,*)
  s=size(a)

  if n_elements(axis) le 0 then begin
    ;a=reform(a)
    n=n_elements(a)
    if keyword_set(sum) then av=total(a,/double) else av=total(a,/double)/n
  end else if n_elements(axis) eq 1 then begin
    if keyword_set(sum) then begin
      av=total(a,axis,/double)
    end else begin
      av=total(a,axis,/double)/product(s[axis])
    end
  end else if n_elements(axis) gt 1 then begin
    av = total(a,axis[0])/sz[axis[0]]
    return, aver(av,axis[1:*]-1,array=array,sum=sum)
  end
  if s(s(0)+1) ne 5 then av=float(av)

  if keyword_set(array) then begin
    if keyword_set(axis) then begin
      if s(0) eq 2 then begin
        if axis eq 1 then av=rebin(reform(av,1,s(2)),s(1),s(2))
        if axis eq 2 then av=rebin(reform(av,s(1),1),s(1),s(2))
      end else if s(0) eq 3 then begin
        if axis eq 1 then av=rebin(reform(av,1,s(2),s(3)),s(1),s(2),s(3))
        if axis eq 2 then av=rebin(reform(av,s(1),1,s(3)),s(1),s(2),s(3))
        if axis eq 3 then av=rebin(reform(av,s(1),s(2),1),s(1),s(2),s(3))
      end
    end else begin
      av=rebin(reform([av],1,1,1),s(1),s(2),s(3))
    end
  endif

  return,av
END
