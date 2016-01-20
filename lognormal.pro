
nx=100
x=findgen(nx)/nx*3.0


sig=1

sig=stddev(x)
mu=mean(x)
mu=0
sig=1
fx=1/(x*sig)*exp(-(alog(x)-mu)^2/(2*sig^2) )


cgplot, x,fx
end
