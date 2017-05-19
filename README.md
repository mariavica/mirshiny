# Example Shiny app

This is an example application for Shiny.
The main purpose of this example is to illustrate how to run Shiny apps from a remote source.
There are many ways to download and run it:

First check the dependencies (you only need to do this once):

```R
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(shiny)) install.packages("shiny")
```

Then load the shiny app:

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("mirtools", "mariavica")
```

Other ways to load the app:

```R
# Run a tar or zip file directly
runUrl("https://github.com/mariavica/mirtools/archive/master.tar.gz")
runUrl("https://github.com/marivica/mirtools/archive/master.zip")

# Using runApp(),  first clone the repository with git. If you have cloned it into
# ~/shiny_example, first go to that directory, then use runApp().
setwd("~/mirtools")
runApp()
```


To run a Shiny app from a subdirectory in the repo or zip file, you can use the `subdir` argument. This repository happens to contain another copy of the app in `additional/mysubdir1`.

```R
runGitHub("mirtools", "mariavica", subdir = "additional/mysubdir1")

runUrl("https://github.com/mariavica/mirtools/archive/master.tar.gz",
  subdir = "additional/mysubdir1")
