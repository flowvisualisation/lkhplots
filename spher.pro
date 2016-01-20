
xs=1300
ys=xs/3
cgdisplay, xs=xs,ys=ys
; Define a data cube (N x N x N)
n = 41L
a = 60*FINDGEN(n)/(n-1) - 29.999  ; [-1,+1]
x = REBIN(a, n, n, n)              ; X-coordinates of cube
y = REBIN(REFORM(a,1,n), n, n, n)  ; Y-coordinates
z = REBIN(REFORM(a,1,1,n), n, n, n); Z-coordinates
; Convert from rectangular (x,y,z) to spherical (phi, theta, r)
spherCoord = CV_COORD(FROM_RECT= $
 TRANSPOSE([[x[*]],[y[*]],[z[*]]]), /TO_SPHERE)
phi = REFORM(spherCoord[0,*], n, n, n)
theta = REFORM(!PI/2 - spherCoord[1,*], n, n, n)
r = REFORM(spherCoord[2,*], n, n, n)


; Find electron probability density for hydrogen atom in state 3d0
; Angular component
L = 2   ; state "d" is electron spin L=2
M = 0   ; Z-component of spin is zero
sh = SPHER_HARM(theta, phi, L, M)


pos=cglayout([3,1])


ash=abs(sh)
datarr=ptrarr(3)
datarr[0]=ptr_new(reform(ash(*,*,n/2)))
datarr[1]=ptr_new(reform(ash(*,n/2,*)))
datarr[2]=ptr_new(reform(ash(n/2,*,*)))

for i=0,2 do begin
r=*datarr[i]
cgcontour, r, /fill, nlev=32, pos=pos[*,i], /noerase
endfor
end
