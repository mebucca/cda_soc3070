# Shared data and visual infrastructure for SOC3070.

prepare_bikeshare <- function() {
  if (!requireNamespace("ISLR2", quietly = TRUE)) {
    stop("The ISLR2 package is required to use the course data.")
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("The dplyr package is required to prepare the course data.")
  }

  data <- dplyr::as_tibble(ISLR2::Bikeshare)
  p75 <- stats::quantile(data$bikers, 0.75, na.rm = TRUE)
  tertiles <- unique(stats::quantile(
    data$bikers,
    probs = c(0, 1 / 3, 2 / 3, 1),
    na.rm = TRUE
  ))

  dplyr::mutate(
    data,
    high_demand = as.integer(bikers > p75),
    demand = factor(
      ifelse(high_demand == 1, "alta", "baja"),
      levels = c("baja", "alta")
    ),
    demand_level = cut(
      bikers,
      breaks = tertiles,
      labels = c("baja", "media", "alta"),
      include.lowest = TRUE,
      ordered_result = TRUE
    ),
    hour = as.integer(as.character(hr)),
    day_type = factor(
      ifelse(workingday == 1, "hábil", "no hábil"),
      levels = c("no hábil", "hábil")
    ),
    weather = droplevels(weathersit)
  )
}

.course_shared_dir <- local({
  source_file <- tryCatch(sys.frame(1)$ofile, error = function(e) NULL)
  if (is.null(source_file)) getwd() else dirname(normalizePath(source_file))
})

course_css_path <- function() {
  candidates <- c(
    file.path(.course_shared_dir, "course.css"),
    "../_shared/course.css",
    "slides/_shared/course.css"
  )
  existing <- candidates[file.exists(candidates)]
  if (!length(existing)) stop("Cannot locate slides/_shared/course.css.")
  normalizePath(existing[1])
}

# CSS is the single source of truth for palettes used by both HTML and R.
course_palette <- function(team, css_path = course_css_path()) {
  selector <- paste0("body.theme-", gsub("_", "-", team))
  css <- readLines(css_path, warn = FALSE)
  start <- grep(paste0("^", gsub("\\.", "\\\\.", selector), "\\s*\\{"), css)
  if (length(start) != 1L) stop("Unknown or duplicated football palette: ", team)

  block <- css[start]
  tokens <- regmatches(
    block,
    gregexpr("--course-[a-z0-9-]+\\s*:\\s*#[0-9A-Fa-f]{6}", block, perl = TRUE)
  )[[1]]
  keys <- sub("^--course-([a-z0-9-]+)\\s*:.*$", "\\1", tokens)
  values <- sub("^.*:\\s*", "", tokens)
  palette <- stats::setNames(values, keys)

  required <- c("primary", "secondary", "accent", paste0("series-", 1:6))
  if (!all(required %in% names(palette))) {
    stop("Incomplete football palette in course.css: ", team)
  }
  palette[required]
}

active_course_palette <- function() {
  getOption("soc3070.palette", course_palette("barcelona"))
}

course_colors <- function(palette = active_course_palette(), n = 6) {
  colours <- unname(palette[paste0("series-", 1:6)])
  if (n <= length(colours)) return(colours[seq_len(n)])
  grDevices::colorRampPalette(colours, space = "Lab")(n)
}

ensure_dejavu_sans <- function() {
  if (!requireNamespace("systemfonts", quietly = TRUE)) {
    stop("Install the R package 'systemfonts' to use DejaVu Sans.")
  }

  registered <- systemfonts::system_fonts()
  if (any(registered$family == "DejaVu Sans")) return(invisible(TRUE))

  candidates <- path.expand(c(
    "~/Library/Fonts/DejaVuSans.ttf",
    "/Library/Fonts/DejaVuSans.ttf",
    "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
    "/opt/homebrew/share/fonts/DejaVuSans.ttf",
    "C:/Windows/Fonts/DejaVuSans.ttf"
  ))
  font_path <- candidates[file.exists(candidates)][1]
  if (is.na(font_path)) {
    stop("DejaVu Sans is not installed. Install the font before rendering.")
  }

  systemfonts::register_font("DejaVu Sans", plain = font_path)
  matched <- systemfonts::match_fonts("DejaVu Sans")$path[1]
  if (!identical(path.expand(matched), path.expand(font_path))) {
    stop("DejaVu Sans registration failed; refusing a silent font fallback.")
  }
  invisible(TRUE)
}

# Julia-like theme requested for every course plot.
theme_julia <- function(base_size = 7.5, base_family = "DejaVu Sans") {
  ensure_dejavu_sans()
  ggplot2::`%+replace%`(
    ggplot2::theme_classic(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      # Panel and grids
      panel.background = ggplot2::element_rect(fill = "white", color = NA),
      panel.border = ggplot2::element_rect(color = "black", fill = NA, linewidth = 0.8),
      panel.grid.major = ggplot2::element_line(color = "grey80", linewidth = 0.4, linetype = "dotted"),
      panel.grid.minor = ggplot2::element_line(color = "grey90", linewidth = 0.3, linetype = "dotted"),

      # Axes
      axis.line = ggplot2::element_line(color = "black", linewidth = 0.8),
      axis.ticks = ggplot2::element_line(color = "black", linewidth = 0.6),
      axis.ticks.length = grid::unit(3, "pt"),
      axis.text = ggplot2::element_text(color = "black", size = base_size * 0.9),
      axis.title = ggplot2::element_text(color = "black", size = base_size),

      # Facets
      strip.background = ggplot2::element_rect(fill = "white", color = "white"),
      strip.text = ggplot2::element_text(size = base_size, face = "plain"),

      # Legend
      legend.position = "right",
      legend.background = ggplot2::element_rect(fill = "white", color = "white", linewidth = 0),
      legend.key = ggplot2::element_rect(fill = "white", color = "white"),

      # Plot
      plot.title = ggplot2::element_text(size = base_size * 1.1, face = "plain"),
      plot.margin = ggplot2::margin(10, 10, 10, 10)
    )
  )
}

theme_course <- theme_julia

course_number <- function(x, digits = 3) {
  formatC(x, format = "f", digits = digits)
}

course_format_output <- function(x, digits = 3) {
  pattern <- "(?<![[:alnum:]_])[-+]?[0-9]+\\.[0-9]+(?:[eE][-+]?[0-9]+)?"
  locations <- gregexpr(pattern, x, perl = TRUE)
  values <- regmatches(x, locations)
  replacements <- lapply(values, function(matches) {
    vapply(matches, function(value) {
      course_number(as.numeric(value), digits = digits)
    }, character(1))
  })
  regmatches(x, locations) <- replacements
  x
}

install_course_knitr_hooks <- function() {
  if (!requireNamespace("knitr", quietly = TRUE)) return(invisible(FALSE))
  if (isTRUE(getOption("soc3070.knitr_hooks"))) return(invisible(TRUE))

  default_output <- knitr::knit_hooks$get("output")
  knitr::knit_hooks$set(
    output = function(x, options) default_output(course_format_output(x), options),
    inline = function(x) {
      if (is.numeric(x)) course_number(x) else course_format_output(as.character(x))
    }
  )

  options(soc3070.knitr_hooks = TRUE)
  invisible(TRUE)
}

scale_colour_course <- function(..., palette = active_course_palette()) {
  ggplot2::discrete_scale(
    aesthetics = "colour", scale_name = "course",
    palette = function(n) course_colors(palette, n), ...
  )
}

scale_color_course <- scale_colour_course

scale_fill_course <- function(..., palette = active_course_palette()) {
  ggplot2::discrete_scale(
    aesthetics = "fill", scale_name = "course",
    palette = function(n) course_colors(palette, n), ...
  )
}

scale_colour_course_continuous <- function(..., palette = active_course_palette()) {
  ggplot2::scale_colour_gradientn(colours = course_colors(palette, 9), ...)
}

scale_color_course_continuous <- scale_colour_course_continuous

scale_fill_course_continuous <- function(..., palette = active_course_palette()) {
  ggplot2::scale_fill_gradientn(colours = course_colors(palette, 9), ...)
}

use_course_style <- function(team, base_size = 7.5) {
  palette <- course_palette(team)
  ensure_dejavu_sans()
  install_course_knitr_hooks()
  if (requireNamespace("knitr", quietly = TRUE) && requireNamespace("ragg", quietly = TRUE)) {
    # The ragg device resolves registered font files through systemfonts.  This
    # avoids the silent Helvetica fallback used by the macOS base PNG device.
    knitr::opts_chunk$set(dev = "ragg_png")
  }
  options(
    soc3070.palette = palette,
    soc3070.team = team,
    ggplot2.discrete.colour = function(...) {
      ggplot2::scale_colour_manual(values = course_colors(palette), ...)
    },
    ggplot2.discrete.fill = function(...) {
      ggplot2::scale_fill_manual(values = course_colors(palette), ...)
    }
  )

  if (requireNamespace("ggplot2", quietly = TRUE)) {
    colours <- course_colors(palette)
    ggplot2::theme_set(theme_julia(base_size = base_size))
    ggplot2::update_geom_defaults("point", list(colour = colours[1]))
    ggplot2::update_geom_defaults("line", list(colour = colours[1], linewidth = 0.9))
    ggplot2::update_geom_defaults("path", list(colour = colours[1], linewidth = 0.9))
    ggplot2::update_geom_defaults("smooth", list(colour = colours[2], fill = colours[1]))
    ggplot2::update_geom_defaults("bar", list(fill = colours[1], colour = NA))
    ggplot2::update_geom_defaults("col", list(fill = colours[1], colour = NA))
    ggplot2::update_geom_defaults("histogram", list(fill = colours[1], colour = "white"))
    ggplot2::update_geom_defaults("density", list(colour = colours[1], fill = colours[1]))
  }

  invisible(palette)
}

use_course_data <- function(team, base_size = 7.5) {
  palette <- use_course_style(team, base_size = base_size)
  list(data = prepare_bikeshare(), palette = palette)
}

# Shared design matrix and chronological split for the demand-prediction
# classes (regularization and neural networks). Returns the expanded model
# matrix, the train/validation/test indices built from a temporal partition,
# and the high-demand outcome learned only from the training window. Classes
# apply their own scaling on top of `x_all` (Ridge/LASSO standardize inside
# glmnet; the neural network standardizes with training statistics).
bikeshare_learning_setup <- function(data = prepare_bikeshare(),
                                     prop_train = 0.60,
                                     prop_valid = 0.20,
                                     demand_quantile = 0.75) {
  data <- dplyr::mutate(data, month = as.integer(mnth))

  features <- ~ temp + atemp + I(temp^2) + hum + I(hum^2) + windspeed +
    holiday + month + sin(2 * pi * month / 12) + cos(2 * pi * month / 12) +
    factor(weathersit) + factor(hr) * workingday
  x_all <- stats::model.matrix(features, data)[, -1]

  days <- sort(unique(data$day))
  n_train_days <- floor(prop_train * length(days))
  n_valid_days <- floor(prop_valid * length(days))
  train_days <- days[seq_len(n_train_days)]
  valid_days <- days[n_train_days + seq_len(n_valid_days)]
  test_days <- days[-seq_len(n_train_days + n_valid_days)]
  id_train <- which(data$day %in% train_days)
  id_valid <- which(data$day %in% valid_days)
  id_test <- which(data$day %in% test_days)

  demand_cutoff <- stats::quantile(data$bikers[id_train], demand_quantile)
  high_demand <- as.integer(data$bikers > demand_cutoff)

  list(
    data = data,
    features = features,
    x_all = x_all,
    days = days,
    train_days = train_days,
    valid_days = valid_days,
    test_days = test_days,
    id_train = id_train,
    id_valid = id_valid,
    id_test = id_test,
    demand_cutoff = demand_cutoff,
    high_demand = high_demand
  )
}
