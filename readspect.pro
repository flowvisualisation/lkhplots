; Number of 'k' bins are printed only once in the beginning - the first row
; Number of total modes in a k bin is in the second row
; 21 different spectra are printed but each entry begins with the time
; from ReadSpectrum.m file for MATLAB
;spectrum.vx=spectruml(3:nspec:end,2:end);
;spectrum.vy=spectruml(4:nspec:end,2:end);
;spectrum.vz=spectruml(5:nspec:end,2:end);
;spectrum.bx=spectruml(6:nspec:end,2:end);
;spectrum.by=spectruml(7:nspec:end,2:end);
;spectrum.bz=spectruml(8:nspec:end,2:end);
;spectrum.th=spectruml(9:nspec:end,2:end);
;spectrum.vxvy=spectruml(10:nspec:end,2:end);
;spectrum.bxby=spectruml(11:nspec:end,2:end);
;spectrum.ad_vx=spectruml(12:nspec:end,2:end);
;spectrum.ad_vy=spectruml(13:nspec:end,2:end);
;spectrum.ad_vz=spectruml(14:nspec:end,2:end);
;spectrum.tr_bx=spectruml(15:nspec:end,2:end);
;spectrum.tr_by=spectruml(16:nspec:end,2:end);
;spectrum.tr_bz=spectruml(17:nspec:end,2:end);
;spectrum.tr_vx=spectruml(18:nspec:end,2:end);
;spectrum.tr_vy=spectruml(19:nspec:end,2:end);
;spectrum.tr_vz=spectruml(20:nspec:end,2:end);
;spectrum.hel=spectruml(21:nspec:end,2:end)+spectruml(22:nspec:end,2:end)+spectruml(23:nspec:end,2:end);
;spectrum.t=transpose(spectruml(4:nspec:end,1));

; FN: June 13th, 2015
; MATLAB's 1:n:end translates into IDL 0:*:n, where n is the gap between indices.

pro readspect,fname=fname,stspec ; stspec is the structure with all the spectra

nspec = 21; the number of total different spectra quantities calculated at run time by snoopy

openr,lun,fname,/get_lun

nlines = file_lines(fname)
rows = (nlines - 2); divided by nspec will give the total number of time snapshots
print, 'nlines', nlines
print, 'rows', rows


;header = strarr(2)
;readf,lun,header


kk = dblarr(36)
nn = dblarr(36)

readf,lun,kk
readf,lun,nn

print, 'kk'
print, kk
print, 'nn'
print, nn

point_lun,-lun,currentlocation

lll = ""
readf,lun,lll
cols = n_elements(strsplit(lll,/regex,/extract)) ; Total number of columns (bins in k shell average)
print, 'cols', cols
print, 'row*cols', rows*cols

specdata = dblarr(cols,rows)

;line1=dblarr(37)
;readf, lun, line1
;print, line1
;stop
point_Lun,lun,currentlocation
readf,lun,specdata

tt = specdata[0,0:*:nspec]
vx = specdata[1:*,0:*:nspec]
vy = specdata[1:*,1:*:nspec]
vz = specdata[1:*,2:*:nspec]
bx = specdata[1:*,3:*:nspec]
by = specdata[1:*,4:*:nspec]
bz = specdata[1:*,5:*:nspec]
; th = specdata[1:*,6:*:nspec]
vxvy = specdata[1:*,7:*:nspec]
bxby = specdata[1:*,8:*:nspec]
advx = specdata[1:*,9:*:nspec]
advy = specdata[1:*,10:*:nspec]
advz = specdata[1:*,11:*:nspec]
trbx = specdata[1:*,12:*:nspec]
trby = specdata[1:*,13:*:nspec]
trbz = specdata[1:*,14:*:nspec]
trvx = specdata[1:*,15:*:nspec]
trvy = specdata[1:*,16:*:nspec]
trvz = specdata[1:*,17:*:nspec]
adotb = specdata[1:*,18:*:nspec] + specdata[1:*,19:*:nspec] + specdata[1:*,20:*:nspec]

free_lun,lun

stspec = {kk:kk, nn:nn, tt:tt, vx:vx, vy:vy, vz:vz, bx:bx, by:by, bz:bz, vxvy:vxvy, bxby:bxby, advx:advx, advy:advy, advz:advz, trbx:trbx, trby:trby, trbz:trbz, trvx:trvx, trvy:trvy, trvz:trvz, adotb:adotb}

end

;   OpenR, lun, file, /Get_Lun
;   header = StrArr(3)
;   ReadF, lun, header
;   Point_Lun, -lun, currentLocation

   ; Read the first line and parse it into column units.
;   line = ""
;   ReadF, lun, line

   ; Find the number of columns in the line.
;   cols = N_Elements(StrSplit(line, /RegEx, /Extract))

   ; Create a variable to hold the data.
;   data = FltArr(cols, rows-N_Elements(header))

   ; Rewind the data file to the start of the data.
;   Point_Lun, lun, currentLocation

   ; Read the data.
;   ReadF, lun, data
;   Free_Lun, lun
