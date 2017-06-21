
## =========================================
## Find Dependent Packages
## =========================================

package.lst <- list("used" =c("abind", "caret", "forecast"))

# Base packages
package.lst$base = installed.packages()
package.lst$base <- package.lst$base[which(package.lst$base[,"Priority"] == "base")]

# Dependencies
package.lst$depends <- package.lst$used

temp <- unlist(lapply(package.lst$depends, tools::package_dependencies, available.packages()))
temp <- unique(c(temp, package.lst$depends))
print(length(temp))

while (length(temp) != length(package.lst$depends)){
  
  package.lst$depends <- temp
  temp <- unlist(lapply(package.lst$depends, tools::package_dependencies, installed.packages(), which = c("Depends", "Imports")))
  temp <- unique(c(temp, package.lst$depends))
  print(length(temp))
}

# Remove duplicates
package.lst$depends <- package.lst$depends[!(package.lst$depends %in% package.lst$base)]
package.lst$depends <- package.lst$depends[!(package.lst$depends %in% package.lst$used)]

# Versions
vers <- lapply(package.lst$depends, function(x)tryCatch(packageVersion(x), error = function(e) NA))
names(vers) <- package.lst$depends
vers

