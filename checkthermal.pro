
readgenps, 0, 'ionxpx', data2, n1,n2
cgplot, findgen(n2), total(data2,1), xrange=[300,700]
getlast, nend
readgenps, nend, 'ionxpx', data, n1,n2
cgplot, findgen(n2), total(data,1), /overplot, color='red'

end
