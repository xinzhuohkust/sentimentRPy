get_sentimentPy <- function(text) {
  container <- purrr::map_dfr(
    .x = text,
    purrr::possibly(

      function(text) {

        result <- asent$nlp(text) |>
          asent$polarity() |>
          print() |>
          capture.output() |>
          stringr::str_extract_all("-?0\\.\\d+") |>
          unlist() |>
          as.numeric()

        result <- as.character(result)

        names(result) <- c("neg", "neu", "pos", "compound")

        result <- tibble::as_tibble_row(result)

        return(result)

      },
      otherwise = tibble::tribble(
        ~neg, ~neu, ~pos, ~compound,
        "error!", "error!", "error!", "error!"
      )
    ),
    .progress = TRUE
  )

  return(container)

}







