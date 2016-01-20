pro readslice, file,image 
t1=systime(1)
spawn, 'ls' , list2
list=grep('usr',list2) 
sz=size(list, /dimensions)
fnum=sz(0)-1
;fnum=0
file=list[fnum]


numstr=strmid(file,3,6)
num=long(numstr)
print, num, ' , ',file
    ;PRO readslice
    ; Open the HDF5 file.
    ;file = 'usr076380.h5'
    grd_ctl, model=num, g,c
    
    file_id = H5F_OPEN(file)
    ; Open the image dataset within the file.
    dataset_id1 = H5D_OPEN(file_id, '/velocity' )
     
    ; Open up the dataspace associated with the Eskimo image.
    dataspace_id = H5D_GET_SPACE(dataset_id1)
     
    ; Now choose our hyperslab. We will pick out only the central
    ; portion of the image.
    start = [ (g.nz-1)/2,0,0]
    count = [ 1,g.ny-1,g.nx-1]
    ; Be sure to use /RESET to turn off all other
    ; selected elements.
    H5S_SELECT_HYPERSLAB, dataspace_id, start, count, $
    STRIDE=[1,1, 1], /RESET
    ; Create a simple dataspace to hold the result. If we
    ; didn't supply
    ; the memory dataspace, then the result would be the same size
    ; as the image dataspace, with zeroes everywhere except our
    ; hyperslab selection.
    memory_space_id = H5S_CREATE_SIMPLE(count)
     
    ; Read in the actual image data.
    image = H5D_READ(dataset_id1, FILE_SPACE=dataspace_id, $
    MEMORY_SPACE=memory_space_id)
    ; Now open and read the color palette associated with
    ; this image.
    ;dataset_id2 = H5D_OPEN(file_id, '/velocity')
    ;palette = H5D_READ(dataset_id2)
    ; Close all our identifiers so we don't leak resources.
    H5S_CLOSE, memory_space_id
    H5S_CLOSE, dataspace_id
    H5D_CLOSE, dataset_id1
    ;H5D_CLOSE, dataset_id2
    H5F_CLOSE, file_id
    ; Display the data.
    DEVICE, DECOMPOSED=0
    WINDOW, XSIZE=800,ys=800
    ;TVLCT, palette[0,*], palette[1,*], palette[2,*]
     
    ; We need to use /ORDER since the image is stored
    ; top-to-bottom.
    nx=g.nx-1
    ny=g.ny-1
    x=findgen(nx)/nx*2-1.
    y=findgen(ny)/ny
    x2d=rebin(reform(x,nx,1),nx,ny)
    y2d=rebin(reform(y,1,ny),nx,ny)
    vx=transpose(reform(image[0,0,*,*]))
    vy0=-x2d*1.5
    vy=transpose(reform(image[1,0,*,*]))-vy0

    cgloadct,0
    display,/hbar,ims=[400,1200], vx , x1=x,x2=y
    q=27
    u=congrid(vx,q,q)
    v=congrid(vy,q,q)
    up=congrid(x2d,q,q)
    vp=congrid(y2d,q,q)
    vpx=congrid(x,q)
    vpy=congrid(y,q)
    velovect,u,v,vpx,vpy, /overplot, color=cgcolor('black')


t2=systime(1)
elap=t2-t1
if (elap lt 60) then begin
print, 'time = ', (t2-t1) , ' seconds'
endif else begin
print, 'time = ', (t2-t1)/60. , ' minutes'
endelse
END
