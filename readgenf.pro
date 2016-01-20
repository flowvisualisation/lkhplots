pro readgenf, field, num, fxy
;field='bx'
;num=18000
strnum=string(num, format='(I07)')

nmfc=field+strnum+".dat"



fxy=read_binary(nmfc, $ 
data_dims=[18000],data_type=5,endian='little')

end
