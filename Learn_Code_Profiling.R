# Code profiling is the practice of running a script,
# and timing each bit in regular intervals.
# This allows you to determine which single part(s) are slowing down the script as a whole.

# Rprof() is a built-in funciton allowing you to profile you code.
# It is not user-friendly though.
##### Tyler- come back at some point and look into Rprof()

# Load movies dataframe from ggplot2movies
library("ggplot2movies")
library("profvis")
data(movies, package = "ggplot2movies")

profvis({
# Extract a single row
christmas_vacation <- movies[9996, ]
  
# Create a subst of comedy movies
comedy_movies <- subset(movies, Comedy == 1)
  
# Plot the rating of comedy movies over time
plot(comedy_movies$year, comedy_movies$rating, xlab="Year", ylab="Rating")
  
# Fit a regression line to the plot
model <- loess(rating ~ year, data = comedy_movies)
  
# Plot the regression line and mark the movie Christmas Vacation
j <- order(comedy_movies$year)
lines(comedy_movies$year[j],
      model$fitted[j],
      col="red")
points(christmas_vacation$year,
       christmas_vacation$rating,
       pch=21,
       bg="steelblue",
       cex=2)
})

# From the results, we can see the line that uses the most time is
#model <- loess(rating ~ year, data = comedy_movies)
# To speed up our code, we can either rewrite this line,
# or determine whether it's really neccessary for what we want to show in our plot.