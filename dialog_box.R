library(rstudioapi)

demo <- c("blah",
          "blah2",
          "blah3",
          "blah4")

response_quest <- showQuestion(
  title = "Title of the box", # title is required
  message = paste0(
    "Text message.  \n\n",
    paste(demo, collapse = "\n"),
    "\n\n",
    "Press \"cool\" to continue.\n",
    "Press \"not cool\" to stop.\n"
  ),
  ok = "cool", # custom text for the OK button
  cancel = "not cool" # custom text for the cancel button
)
# returns TRUE or FALSE


showDialog(
  title = "Title of the box", # title is required
  message = paste0(
    "Showing <b>bold</b> text in the message.  ",
    "Press OK to continue. "
  )
)
# the message is not as dynamic as winDialog() on Windows
# it seems helpful for very short messages that do not take info from
# a vector.