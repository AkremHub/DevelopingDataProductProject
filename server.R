library(shiny)
library(EBImage)
# Load all the gray-level images
Aircraft = readImage("aircraft.JPG")
Fingerprint =readImage("fingerprint.JPG")
Bacteria = readImage("bacteria.JPG")
nonuniformlyIllumination = readImage("nonuniformlyIllumination.JPG")
ImageWithMultiObjects = readImage("ImageWithMultiObjects.JPG")
ImageWithNoise= readImage("ImageWithNoise.JPG")
threshold=-1

# This function is to get the image based on the user selection
getImage <- function(selectedImage) {
  if (selectedImage=='Aircraft')
    img=Aircraft
  else if (selectedImage =='Fingerprint')
    img=Fingerprint
  else if(selectedImage =='Bacteria')
    img=Bacteria
  else if(selectedImage=='Image with non-uniformly illumination')
    img=nonuniformlyIllumination
  else if(selectedImage=='Image with multi objects')
    img=ImageWithMultiObjects
  else if(selectedImage =='Image with noise')
    img=ImageWithNoise
}

#This function calculate the optimum threshold based on Otsu algorithm
calculateThreshodlValueBasedOnOtsu <- function(grayimage){
  threshold = otsu(grayimage)
}

shinyServer(function(input, output, session) {
  
 # Using Reactive method
   selectedImage<-reactive({getImage(input$imageName)})

# Figure 1  
  output$grayLevelImage <- renderImage({
    
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext='.png')
    img=selectedImage()
    writeImage(img,"img.jpeg",quality = 100)
    filename <- normalizePath(file.path('./',paste0('img','.jpeg')))
    # Return a list containing the filename
    list(src = filename)
  })
  
# Figure 2   
  output$imageHistogram <- renderImage({
    
    outfile <- tempfile(fileext='.png')
    img=selectedImage()
    grayimage<-channel(img,"gray")
    grayLevel=as.vector(grayimage)
    #Map the image from (0 to 1) To (0 to 255)
    grayLevel=grayLevel*255
    png(outfile, width=400, height=400)
    hist(grayLevel,breaks=50,col='red',main=NULL,xlab="Gray Level")
    dev.off()
    list(src = outfile)
  }, deleteFile = TRUE)
  
# Figure 3 
  output$maualSegmentedImage <- renderImage({
    outfile <- tempfile(fileext='.png')
    img=selectedImage()
    grayimage<-channel(img,"gray")
    threshold=input$obs
    img1 = grayimage >= (threshold/255)
    writeImage(img1,"img.jpeg",quality = 100)
    filename <- normalizePath(file.path('./',paste0('img','.jpeg')))
    list(src = filename)
  }, deleteFile = TRUE)
  
# Figure 4  
  output$automaticSegmentedImage <- renderImage({
    outfile <- tempfile(fileext='.png')
    img=selectedImage()
    grayimage<-channel(img,"gray")
    threshold=calculateThreshodlValueBasedOnOtsu(grayimage)
    img1 = grayimage > threshold
    writeImage(img1,"img.jpeg",quality = 100)
    filename <- normalizePath(file.path('./',paste0('img','.jpeg')))
    list(src = filename)
  }, deleteFile = TRUE)
  
})