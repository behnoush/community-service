#Open a connection to the old version of my blog: http://simplystatistics.tumblr.com/ , read the first 150 lines of the file and assign them to a vector simplyStats. Apply the nchar() function to simplyStats to count the characters in each element of simplyStats. How many characters long are the lines 2, 45, and 122?
fileURL <- "http://simplystatistics.tumblr.com/"
con <- url(fileURL, "r")
simplyStats <- readLines(con, n =150)
close(con)
nchar(simplyStats[c(2,45,122)])