
readcol,'3d_mri_kx_ky_384_init/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm
var=bzmax
print, max(var)
cgplot, t,bzmax, /ylog, color='red', xrange=[0,0.7], yrange=[10,40]
readcol,'3d_mri_kx_ky_512_init/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm
var=bzmax
print, max(var)
cgplot, t,bzmax, /overplot, color='green'
end
