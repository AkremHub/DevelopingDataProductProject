library(shiny)  
shinyUI(pageWithSidebar(
# The page title
  headerPanel("Automatic clustering based on digital image (2-D data) thresholding"),
# Use  sidebarPanel
   sidebarPanel(h5('Automatic clustering based on digital image thresholding is the process in which  a grey-level image is clustered into two classes:object and bakground. This can be done by calculating  an optimum threshold separating the two classes.'),
              h5('This App is designed to illustrate  the automatic clustering based on image thresholding using the well-known Otsu algorithm [1].'),
              h5('Otsu algorithm automatically select an optimum threshold  value (T) (between 0 and 255). Then the threshold value is  used to threshold  the gray level image into two colors 0( black) and 255(White). In other words, it reduces a gray level image to a binary image.'),
              h5('After you select an image you will see the result of Otsu algorithm in the left lower corner. After you try all the images you will notice that Otsu algorithm succeed to automatically cluster the objects and the background in the first three images. However, Otsu algorithm failed in the last three images'),
              h5('You can use try and error and manually select your threshold value using the sliderInput. To make it easy, each time you select a threshold value you can see your result in the lower right corner and compare it to the original gray-level image and Otsu result.'), 
              h5('The best threshold value is the one that segment the objects from their background without merging part of them with the background.'),
# Define the radioButtons with six inputs             
              radioButtons('imageName','Select an Image ',list('Aircraft','Fingerprint','Bacteria','Image with non-uniformly illumination','Image with multi objects','Image with noise')),
# Define the sidebar with one input
               sliderInput("obs", "Select a manual threshold value",
                min = 0, max = 255,  value = 0),
   h5('Note: Have a look at the Image histogram to narrow down your search.'),
    h5('Usually the best threshold value is within the valley of the image histogram '),br(),h5('REFERENCE',h5('[1]-https://en.wikipedia.org/wiki/Otsus_method'))
    
  ),
#Define the mainPanel  
  mainPanel(
    
    # Use imageOutput to place the image on the page
    splitLayout(cellWidths = c("40%", "40%"),h5('Original Gray Level Image'),
                h5('Image histogram')),
    splitLayout(cellWidths = c("40%", "40%"),imageOutput("grayLevelImage"),
    imageOutput("imageHistogram")),
    splitLayout(cellWidths = c("40%", "40%"),h5('Automatic image clustering using Otsu algorithm'),h5('Your result:Change the slider input to see the manual Image clustering')
                ),
    splitLayout(cellWidths = c("40%", "40%"),imageOutput("automaticSegmentedImage"),imageOutput("maualSegmentedImage"))
  )
))