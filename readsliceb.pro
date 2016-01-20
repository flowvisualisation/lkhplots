pro readsliceb, dir, num,image 
t1=systime(1)
file=dir+'/usr'+string(num, format='(I06)')+'.h5'
print, file


print, num, ' , ',file
    ;PRO readslice
    ; Open the HDF5 file.
    ;file = 'usr076380.h5'
    grd_ctl, model=num, g,c, dir=dir
    
    file_id = H5F_OPEN(file)
    ; Open the image dataset within the file.
    dataset_id1 = H5D_OPEN(file_id, '/magnetic_field' )
     
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


t2=systime(1)
elap=t2-t1
if (elap lt 60) then begin
print, 'wtime = ', (t2-t1) , ' seconds'
endif else begin
print, 'wtime = ', (t2-t1)/60. , ' minutes'
endelse
END
