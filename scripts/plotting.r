# plotting, requires `cairo`

# Load the mtcars dataset (if not already loaded)
data(mtcars)

# Create a scatter plot of mpg vs. hp
plot(mpg ~ hp, data = mtcars, main = "Scatter Plot: mpg vs. hp", xlab = "Horsepower", ylab = "Miles per Gallon")


# Load the tidyverse package (if not already loaded)
library(tidyverse)
# library(ggplot2)

# Create the scatter plot using ggplot2
ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  labs(title = "Scatter Plot: mpg vs. hp",
       x = "Horsepower",
       y = "Miles per Gallon")
