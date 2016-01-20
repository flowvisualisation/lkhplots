
pro testcode,  code
s = FILE_TEST('v0000.vtk')
p = FILE_TEST('data.0000.dbl')
n = FILE_TEST('usr000000.h5')

code='snoopy'
if (p eq 1 ) then begin
code='pluto'
endif

if (n eq 1 ) then begin
code='nirvana'
endif


if (s eq 1 ) then begin
code='snoopy'
endif

end
