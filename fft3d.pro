FUNCTION fft3d,f,i

;  Return the 3-D Fast Fourier Transform of f

	if n_params() eq 0 then begin
		print,'t=3dfft(f,i)  ; i=-1 f->t, i=1 t->f'
		return,0
	end

	s=size(f)
	t=complexarr(s(1),s(2),s(3))
	for l=0,s(1)-1 do for m=0,s(2)-1 do $
		t(l,m,*)=fft(f(l,m,*),i)
	for m=0,s(2)-1 do for n=0,s(3)-1 do $
		t(*,m,n)=fft(t(*,m,n),i)
	for n=0,s(3)-1 do for l=0,s(1)-1 do $
		t(l,*,n)=fft(t(l,*,n),i)
	return,t
end
