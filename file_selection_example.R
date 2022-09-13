library(rstudioapi)

default_dir <- "/SharedDrive/deans/Presidents/"

selected_dir <- selectDirectory(
  # caption = "Your custom caption",
  # label = "Your custom label", # for the Select button
  path = default_dir
)

selected_file <- selectFile(
  # caption = "Your custom caption",
  # label = "Your custom label", # for the Select button
  path = default_dir,
  # filter = "Excel Files (*.xlsx)", # see Documentation on how to use the filter
  # existing = FALSE # FALSE allows user to enter a new file name
)
