## update R, uninstall R, where are the packages stored


## the code is coming from those sources :
## http://www.r-statistics.com/2013/03/updating-r-from-r-on-windows-using-the-installr-package/
## http://stackoverflow.com/a/20313683
## http://www.r-statistics.com/2015/03/r-3-1-3-is-released-easy-upgrading-for-windows-users-with-the-installr-package/

# Example from the documentation ?updateR
# 
# ## Not run: 
# updateR(T, T, T, T, T, T, T)
# # # the safest upgrade option: See the NEWS,
# # install R, copy packages, keep old packages,
# # update packages in the new installation,
# # start the Rgui of the new R, and quite current session
# # of R
# 
# updateR() # will ask you what you want at every decision.
# 
# ## End(Not run)

# installing/loading the package:
if(!require(installr)) {
        install.packages("installr"); require(installr)} #load / install+load installr

# using the package:
# updateR() # this will start the updating process of your R installation. 
# It will check for newer versions, and if one is available, 
# will guide you through the decisions you'd need to make.

## if want to update and move packages
library(installr)
updateR(F, T, T, F, T, F, T) # install, move, update.package, quit R.


## from : http://cran.r-project.org/bin/windows/base/rw-FAQ.html
# 2.7 How do I UNinstall R?
# 
# Normally you can do this from the 'Programs and Features' group in the 
# Control Panel. If it does not appear there, run unins000.exe in the 
# top-level installation directory. On recent versions of Windows you may be
# asked to confirm that you wish to run a program from an `unknown' or
#`unidentified' publisher.
# 
# Uninstalling R only removes files from the initial installation, 
# not (for example) packages you have installed or updated.
# 
# If all else fails, you can just delete the whole directory in which R was
# installed.

# 2.8 What's the best way to upgrade?
# 
# That's a matter of taste. For most people the best thing to do is to 
# uninstall R (see the previous Q), install the new version, copy any installed
# packages to the library folder in the new installation, run update.packages
# (checkBuilt=TRUE, ask=FALSE) in the new R and then delete anything left of
# the old installation. Different versions of R are quite deliberately
# installed in parallel folders so you can keep old versions around if you wish.
# 
# For those with a personal library (folder R\win-library\x.y of your home
# directory, R\win64-library\x.y on 64-bit builds), you will need to update
# that too when the minor version of R changes (e.g. from 3.0.2 to 3.1.0).
# A simple way to do so is to copy (say) R\win-library\3.0 to R\win-library\3.1
# before running update.packages(checkBuilt=TRUE, ask=FALSE). 


## where are the packages stored : http://stackoverflow.com/a/2615147
.libPaths()
# [1] "C:/Users/user/Documents/R/win-library/3.1"
# [2] "C:/Program Files/R/R-3.1.3/library"  

