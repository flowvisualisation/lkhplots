pro bin2d, r1,r2,n1, grid, nx,ny


minr1=min(r1)
maxr1=max(r1)
minr2=min(r2)
maxr2=max(r2)
;nq=n1[0]
nq=n1
;nq=10
;help,n1

for i=0L,nq-1L do begin


; fix converts float to integer 
; find position on grid in total space and multiply by grid cell number
xpt=fix((r1(i)-minr1)/(maxr1-minr1)*(nx)+.99)
ypt=fix((r2(i)-minr2)/(maxr2-minr2)*(ny)+.99)
xpt=xpt<nx-1
ypt=ypt<ny-1
xpt=xpt>0
ypt=ypt>0

;print, xpt,ypt,r1(i),maxr1,minr1,r2(i),maxr2,minr2
grid[xpt,ypt] =grid[xpt,ypt]+1

endfor

end

