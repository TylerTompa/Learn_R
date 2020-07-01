# One of the easiest ways to optimize your R code is to ensure it is kept up-to-date.
# You can check which version of R you are running with the command "version."
version
# Note that version is a built-in variable, not a function.
version$major
version$minor

# Benchmarking
##################################################

# but it may not be clear whether it would be worth it to change the code.
# Cases like this is where benchmarking comes in.
# Benchmarking is the practice of comparing one piece of code to one more or other pieces,
# and comparig the time it takes each one to run.
# With benchmarking, you can compare multiple pieces of code with small datasets,
# before running the most efficient on the much larger full datasets.
# As an example, consider the following three ways of creating a sequence in R:
# 1. Using a colon operator: 1:n
# 2. Use the sequence function, and use the default step size: seq(1:n)
# 3. Use the sequence function, and explicitly specify the step size: seq(1:n, by=1)
colon <- function(n) 1:n
seq_defualt <- function(n) seq(1, n)
seq_by <- function(n) seq(1, n, by=1)
# Now, to actually time each function, we use the function system.time()
system.time(colon(1e8))
system.time(seq_defualt(1e8))
system.time(seq_by(1e8))
# Results may vary depending on the machine and the time these lines are run.
# As of writing this, the first two lines returned 0, 0, 0,
# while the third line returned 0.77, 0.13, 0.89.
# Therefore, if we had an existing code that used the syntax seq(1, n),
# There is not enough evidence to suggest that changing this code to 1:n would make it any more efficient.
# However, if our existing code used the syntax seq(1, n, by=x),
# we do have evidence that changing the code would make it more efficient.

# The system.time() function returns three numbers: user, system, elapsed.  The rough definitions are:
# user- CPU time charged for the execution of user instructions.
# system- CPU time charged for execution by the system on behalf of the calling process.
# elapsed- Approximately the sum of user and system time.  Typically the number we care about.

# You may time a function, but still want to use the results afterards.
# In this case, assign the results of a function to a variable,
# all within system.time()
# WARNING: It is important to use the assignment operator "<-" in these cases,
# as an equals sign "=" inside a function will be read as a passing in a parameter.
system.time(numbers <- seq(1,1e9))
numbers

system.time(numbers)

# In addition to calculating the elapsed time, it is worth calcualting the relative time of tasks.
default_results <-  system.time(sd(seq(1,1e7)))
specifiy_by_results <-  system.time(sd(seq(1,1e7, by=1)))

default_results["elapsed"]
specifiy_by_results["elapsed"]
# At the time of running this code, the time of the first function was 0.06,
# and the time of the second was 0.18
# Therefore, in this example, specifiying the "by" argument causes the code to take 3 times as long.
specifiy_by_results["elapsed"]/default_results["elapsed"]

# Another way to think of this, is that the code decreased in speed by about 200%.
((specifiy_by_results["elapsed"]  - default_results["elapsed"]) / default_results["elapsed"]) * 100

##################################################

# Microbenchmark
##################################################
# The Microbenchmark package is a wrapper around the function system.time().
# This package makes it straightforward to compare multiple functions.
library(microbenchmark)

# Define three similar functions that achive the same result.
colon <- function(n) 1:n
seq_defualt <- function(n) seq(1, n)
seq_by <- function(n) seq(1, n, by=1)

# Run the function mircrobenchmark(),
# passing in each function you are comparing against each other.
n <- 1e6

microbenchmark(
  colon(n),
  seq_defualt(n),
  seq_by(n),
  times=10
)
##################################################

# Benchmarkme
##################################################
# Benchmarkme is a special library that can be used to test your machine against other.
# First, load the benchmarkme package, then run the benchmark_std function.
# This will run a number of standard R operations,
# and return data on the time it took to run the full function.
# Be sure to save the results of the function to a variable.
library("benchmarkme")
results <- benchmark_std(runs = 3)

# After running the function, you plot the results to get two graphs.
# The first shows the absolute time it took to run the full function,
# and the second graph shows the relative time compared to other machines.
plot(results)

# I ran three loops of this function.

# In the first loop, my machine ranked 80 our of 749 machines.
# I could buy a new machine if I wanted to improve;
# however, my relative time is less than 2 times as slow as the fastest.

# In the second loop, my machine ranked 257 out of 747 machines.
# My relative time was over 5 times slower than the fatest machine.
# This provide more justification for getting a new machine than the first set of results.

# Another useful function in the benchmarkme package is benchmark_io,
# which calculates the time it takes to read and write a file of size X MB.
results_io <- benchmark_io(runs=1, size=50)
plot(results_io)
# Benchmarking
##################################################

# Memory Allocation
##################################################
# When you assign a variable in R, R must allocate memory in RAM, which takes time.
# The R programming language does this automatically.
# Therefore, to make our code run more quickly,
# we can minimize the amount of memory R has to perform

# For example, suppose we want to form a sequence of numbers.
n <- 1e5

# We could do this using the color operator: 1:n
system.time(1:n)

# Alternatively, we could use a for-loop
# Note that we are defining a variable, and specifying it's length.
# The length of our pre-defined vector does not change; only the variable in the vector do.
# Consequently, we define a vector one time, and wait on R to allocate memory one time.
x <- vector("numeric", n) # define vector of length n
system.time(for (i in 1:n) {
  x[i] <- i
})

# Lastly, we could use a third method similar to the second,
# wherein we start with an empty object, and add new elements on each loop.
# The critical difference from the second method,
# is that we are not changing the current element on each loop; we are adding the element.
# The means that we start with a vector of length n.
# On the first loop, we have a vector of length n+1; on the second loop the length is n+2, etc.
# Consequently, we must reallocate memory in RAM each time we change the length of our vector.
y <- NULL
system.time(for (i in 1:n) {
  y <- c(y,i)
})

# The important lesson to learn- for efficiency, never grow a vector.