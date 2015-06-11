
pro readafort, filename, nx, ny, var


var=fltarr(nx,ny)
openr, lun, filename, /get_lun
skip_it = bytarr(4) ; replace 4 by the actual number of bytes you'd like to skip
 readu, lun, skip_it
 readu,lun, var 
 free_lun, lun

 end
