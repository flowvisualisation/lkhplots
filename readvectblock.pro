PRO readvectblock,fp,vectx,vecty,vectz
COMMON SHARE1,nx,ny,nz,nvar,nscalars
; VECTORS block

var=fltarr(3,nx,ny,nz)
readu,fp,var
var=SWAP_ENDIAN(temporary(var),/SWAP_IF_LITTLE_ENDIAN)

vectx=temporary(reform(var[0,*,*,*]))
vecty=temporary(reform(var[1,*,*,*]))
vectz=temporary(reform(var[2,*,*,*]))

END
