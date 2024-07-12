# geospatial work with terra and raster
library(raster)
library(terra)

# Create a SpatRaster 'a' with values
a <- rast(ncols = 40, nrows = 40, xmin = -110, xmax = -90, ymin = 40, ymax = 60, crs = "+proj=longlat +datum=WGS84")
values(a) <- 1:ncell(a)

# Define a new CRS for 'b'
newcrs <- "+proj=lcc +lat_1=48 +lat_2=33 +lon_0=-100 +datum=WGS84"

# Create a new SpatRaster 'b' by projecting 'a'
b <- rast(ncols = 94, nrows = 124, xmin = -944881, xmax = 935118, ymin = 4664377, ymax = 7144377, crs = newcrs)
w <- project(a, b)

plot(w)

# test .tiff loading and raster
fl_terra <- terra::rast('data/example.tiff')
fl_raster <- raster::raster('data/example.tiff')

plot(fl_terra)
