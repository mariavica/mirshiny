# Example Shiny app

This is an example application for Shiny.
The main purpose of this example is to illustrate how to run Shiny apps from a remote source.
There are many ways to download and run it:

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("mirshiny", "mariavica")

# Run a tar or zip file directly
runUrl("https://github.com/mariavica/mirshiny/archive/master.tar.gz")
runUrl("https://github.com/marivica/mirshiny/archive/master.zip")
```

Or you can clone the git repository, then use `runApp()`:

```R
# First clone the repository with git. If you have cloned it into
# ~/shiny_example, first go to that directory, then use runApp().
setwd("~/mirshiny")
runApp()
```
