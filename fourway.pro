function fourway, arr


arr[0,*]=arr[1,*]
arr[*,0]=arr[*,1]
arr4=[ [ reverse(reverse(arr, 2) )  , reverse(arr, 2) ] , [  reverse(arr)  , arr] ]
sz=size (arr4, /dimension)

nx=sz[0]
ny=sz[1]

arr4[nx/2-2,*]= 0.5*(arr4[nx/2-4,*]  + arr4[nx/2+4, *]  )
arr4[nx/2-1,*]= 0.5*(arr4[nx/2-4,*]  + arr4[nx/2+4, *]  )
arr4[nx/2,*]= 0.5*(arr4[nx/2-4,*]  + arr4[nx/2+4, *]  )
arr4[nx/2+1,*]= 0.5*(arr4[nx/2-4,*]  + arr4[nx/2+4, *]  )

return, arr4
end
