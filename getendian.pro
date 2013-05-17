function getendian
; if on juvis, need bigendian data
spawn, "hostname ", hoststring

I=0
   I = STRPOS(hoststring, 'zam', I)

littleendian=1
if (I ne -1) then begin
littleendian=0
endif

return, littleendian
end
