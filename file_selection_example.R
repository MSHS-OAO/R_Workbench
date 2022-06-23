default_dir <- paste0("/SharedDrive/data/deans/Presidents/SixSigma/",
                      "MSHS Productivity/Productivity/Volume - Data/CDMs")

all_folders <-
  list.dirs(
    path = default_dir,
    full.names = TRUE
  )

folder_choose <-
  select.list(
    choices = c("None", all_folders),
    title = "CDM Folder Choice",
    multiple = F,
    graphics = T,
    preselect = "None"
  )

all_paths <-
  list.files(
    path = folder_choose,
    pattern = "*.xlsx",
    full.names = TRUE
  )


CDM_file_path <-   select.list(
  choices = c("None", all_paths),
  title = "CDM File Choice",
  multiple = F,
  graphics = T,
  preselect = "None"
)