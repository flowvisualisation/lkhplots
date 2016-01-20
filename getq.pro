
function getq, n

spawn, 'basename ${PWD}', dirtag
qtag=strmid(dirtag,1,2)
qq=fix(qtag)
q=qq[0]/10.

return,q

end
