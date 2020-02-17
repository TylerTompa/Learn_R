# You can check the class of a variable with the class() function

# R does not differentiate between integers and decinals;
# to R they are both just numeric
integer <- 4
class(integer)

decimal <- 4.5
class(decimal)

character <- "4"
class(character)

# R recognizes a vector of a certain class as that class itself.
# Instead of a vector of numerics, R just sees numeric.
vector_of_numbers <- c(1, 2, 3)
class(vector_of_numbers)

vector_of_characters <- c("1", "2", "3")
class(vector_of_characters)

# Similarly, R only sees a list as a list, not as a list of a certain class.
list_of_numbers <- list(1, 2, 3, 4, 5)
class(list_of_numbers)

list_of_characters <- list("1", "2", "3", "4", "5")
class(list_of_characters)

list_of_mixed_classes <- list(1, c("1", "2", "3"), "4", FALSE)
class(list_of_mixed_classes)
