
### matlab scxript to fit data
###
#   
#   
#
#####




n=10

xmax=1.0

x=0:xmax/n:xmax

a=exp(x)+rand(1,n+1)





p=polyfit(x,a,6)



f=polyval(p,x)

residuals=f-a


plot(x,a, 'o')
hold on

plot(x,f)

plot(x,residuals)

