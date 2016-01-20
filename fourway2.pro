function fourway2, arr


arr[0,*]=arr[1,*]
arr[*,0]=arr[*,1]
arr4=[ [ -reverse(reverse(arr, 2) )  , -reverse(arr, 2) ] , [  reverse(arr)  , arr] ]
sz=size (arr4, /dimension)

nx=sz[0]
ny=sz[1]

;arr4[nx/2,*]= 0.5*(arr4[nx/2-1,*]  + arr4[nx/2+1,*]  )
;arr4[*,ny/2]= 0.5*(arr4[*,ny/2-1]  + arr4[*, ny/2+1]  )

return, arr4
end
