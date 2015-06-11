# Visit 2.6.3 log file
ScriptVersion = "2.6.3"
if ScriptVersion != Version():
    print "This script is for VisIt %s. It may not work with version %s" % (ScriptVersion, Version())
ShowAllWindows()
<<<<<<< local
Source("/Users/gmurphy/idl/lkhplots/func.py")
=======
SetWindowArea(2147, 1352 ,413, 0)
ShowAllWindows()
SetWindowLayout(1)
Source("thetab.py")
>>>>>>> other
