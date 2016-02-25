
PRO ex_create_hdf5, data, tag, tag2
file = tag+'hdf5_out.h5'
fid = H5F_CREATE(file)
;; create data
;; get data type and space, needed to create the dataset
datatype_id = H5T_IDL_CREATE(data)
dataspace_id = H5S_CREATE_SIMPLE(size(data,/DIMENSIONS))
;; create dataset in the output file
dataset_id = H5D_CREATE(fid,$
tag2,datatype_id,dataspace_id)
;; write data to dataset
H5D_WRITE,dataset_id,data
;; close all open identifiers
H5D_CLOSE,dataset_id
H5S_CLOSE,dataspace_id
H5T_CLOSE,datatype_id
H5F_CLOSE,fid
END
