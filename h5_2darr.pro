pro h5_2darr, arr1, arr2, tag, idstr
 ;; add to hdf5 file

datptr=ptrarr(2)
datptr[0]=ptr_new(arr1)
datptr[1]=ptr_new(arr2)
file = tag+'.h5'
;FILE_DELETE,  file
fid = H5F_CREATE(file)

;; create data
for q=0,1 do begin
data = *datptr[q]
help, data
;; get data type and space, needed to create the dataset
datatype_id = H5T_IDL_CREATE(data)
dataspace_id = H5S_CREATE_SIMPLE(size(data,/DIMENSIONS))
;; create dataset in the output file
dataset_id = H5D_CREATE(fid,$
idstr[q],datatype_id,dataspace_id)
;; write data to dataset
H5D_WRITE,dataset_id,data
;; close all open identifiers
H5D_CLOSE,dataset_id
H5S_CLOSE,dataspace_id
H5T_CLOSE,datatype_id
delvar,dataset_id
delvar,dataspace_id
delvar,datatype_id
endfor


H5F_CLOSE,fid


end
