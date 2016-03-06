####################################################################
#Calculating Cross-Variogram of Remote Sensing Image Data
#This code is contributed by Milad Mahour for educational purposes
#Email: m.mahour@utwente.nl
####################################################################


#####################################
#Calculating Variogram of Image A
#####################################
rm(list=ls(all=TRUE))
#Loading "rgdal" library for reading image data
require(rgdal)
#Loading "gstat" library for variogram function
require(gstat)

#Defining the root directory
Root <- "D:/Programming"
setwd(Root)

inputfileA <- "ImageA.tif"
A <- readGDAL(inputfileA)	
names(A)<- "ImageA"
head(A@data)
summary(A$ImageA)

#Make spatial point data frame
point_dataA <- as(A, 'SpatialPointsDataFrame')

#Computing Variogram at four main geographical direction 0, 45, 90 and 135 and cutoff value at 6000 m
file1.d4 <- variogram(ImageA~1, data=point_dataA, alpha=c(0,45,90,135), cutoff=6000)
file1.d4

#Plot four directional variogram
plot(file1.d4)


#####################################
#Calculating Variogram of Image B
#####################################
inputfileB <- "ImageB.tif"
B <- readGDAL(inputfileB)	
names(B)<- "ImageB"
head(B@data)
summary(B$ImageB)

#Make spatial point data frame
point_dataB <- as(B, 'SpatialPointsDataFrame')

#Computing Variogram at four main geographical direction 0, 45, 90 and 135 and cutoff value at 6000 m
file2.d4 <- variogram(ImageB~1, data=point_dataB, alpha=c(0,45,90,135), cutoff=6000)
file2.d4

#Plot four directional variogram
plot(file2.d4)


###############################################
#Calculating Cross-variogram ImageA Vs. ImageB
###############################################
g <- gstat(NULL, "ImageA", ImageA~1, point_dataA)
g <- gstat(g, "ImageB", ImageB~1, point_dataB)

#Computing Cross-Variogram between ImageA and ImageB at four main geographical direction 0, 45, 90 and 135 and cutoff value at 6000 m
Cross <- variogram(g, alpha=c(0,45,90,135), cutoff=6000)
Cross

#Plot four directional variogram
plot(Cross)
