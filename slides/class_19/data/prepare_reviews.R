#!/usr/bin/env Rscript

# Build a de-identified teaching snapshot from the public Apple App Store RSS
# feed for the Capital Bikeshare app. The raw RSS pages are not committed.
#
# Usage:
#   Rscript prepare_reviews.R /path/to/raw-pages output.csv

suppressPackageStartupMessages({
  library(jsonlite)
  library(tidyverse)
})

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2L) {
  stop("Usage: prepare_reviews.R RAW_DIR OUTPUT_CSV")
}

raw_dir <- normalizePath(args[[1]], mustWork = TRUE)
output_csv <- args[[2]]

files <- file.path(raw_dir, paste0("cabi-review-page-", 1:10, ".json"))
files <- files[file.exists(files)]
if (!length(files)) stop("No RSS pages found in ", raw_dir)

entries <- map(files, function(path) {
  feed <- fromJSON(path, simplifyDataFrame = FALSE)$feed
  if (is.null(feed$entry)) return(list())
  feed$entry
}) %>%
  flatten()

field <- function(entry, name) {
  value <- entry[[name]]
  if (is.null(value) || is.null(value$label)) return(NA_character_)
  as.character(value$label)
}

reviews <- map_dfr(entries, function(entry) {
  tibble(
    review_id = field(entry, "id"),
    date = as.Date(field(entry, "updated")),
    rating = as.integer(field(entry, "im:rating")),
    app_version = field(entry, "im:version"),
    title = field(entry, "title"),
    text = field(entry, "content")
  )
}) %>%
  distinct(review_id, .keep_all = TRUE) %>%
  mutate(
    title = str_squish(str_replace_all(title, "[\r\n\t]+", " ")),
    text = str_squish(str_replace_all(text, "[\r\n\t]+", " ")),
    critical_review = as.integer(rating <= 2)
  ) %>%
  filter(!is.na(date), !is.na(rating), !is.na(text), nchar(text) >= 4) %>%
  arrange(date, review_id)

dir.create(dirname(output_csv), recursive = TRUE, showWarnings = FALSE)
write.csv(reviews, output_csv, row.names = FALSE, na = "")

message(
  "Wrote ", nrow(reviews), " de-identified reviews (",
  min(reviews$date), " to ", max(reviews$date), ") to ", output_csv
)
