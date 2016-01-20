;------------------------------------------------------------------------------
PRO readscalarblock,fp,var
COMMON SHARE1,nx,ny,nz,nvar,nscalars
; SCALARS block

string = ' '
readf,fp,string ; "LOOKUP_TABLE default"
var=fltarr(nx,ny,nz)
readu,fp,var
var=SWAP_ENDIAN(temporary(var),/SWAP_IF_LITTLE_ENDIAN)

END
;------------------------------------------------------------------------------
