cal_sentiment <- function(x) {
  x |>
    dplyr::filter(value == 0) |>
    dplyr::pull(value) |>
    length() -> neu

  x |>
    dplyr::filter(value > 0) |>
    dplyr::pull(value) |>
    sum() -> pos

  x |>
    dplyr::filter(value < 0) |>
    dplyr::pull(value) |>
    sum() -> neg

  result <- c(neu, pos, neg) |>
    as.character()

  names(result) <- c("neu", "pos", "neg")

  return(result)
}

get_sentiment_word <- function(text) {
  purrr::map_vec(
    text,
    purrr::possibly(
      function(x) {

        result <- x |>
          dplyr::tibble(text = _, id = 1) |>
          tidytext::unnest_tokens(word, text) |>
          dplyr::filter(!word %in% stopwords::stopwords(source = "stopwords-iso")) |>
          dplyr::left_join(tidytext::get_sentiments("afinn"), by = "word") |>
          tidyr::replace_na(list(value = 0)) |>
          tidyr::nest(data = !id) |>
          dplyr::mutate(sentiment = purrr::map(data, cal_sentiment)) |>
          dplyr::pull(sentiment)

        if(length(result) == 0) {
          result <- tibble::tribble(
            ~neu, ~pos, ~neg,
            "0", "0", "0"
          )
        } else {
          result <- result |>
            unlist() |>
            tibble::as_tibble_row()
        }

        return(result)

      },
      otherwise = tibble::tribble(
        ~neu, ~pos, ~neg,
        "error!", "error!", "error!"
      )
    )
  )
}

get_sentiment_sentence <- Vectorize(
  purrr::possibly(
    function(x) {
      container <- x |>
        sentimentr::get_sentences() |>
        sentimentr::sentiment_by()

      result <- tibble::tibble(
        sentiment = purrr::pluck(container, "ave_sentiment") |>
          as.character(),
        sd = purrr::pluck(container, "sd") |>
          as.character()
      )

      return(result)

    },
    otherwise = tibble::tribble(
      ~sentiment, ~sd,
      "error!", "error!"
    )
  )
)

get_sentimentR <- function(text, method = "sentence", multisession = FALSE, optional_arg = NULL) {

  if(multisession == TRUE) {
    future::plan(future::multisession)
  }

  if(method == "sentence") {
    result <- get_sentiment_sentence(text)

    if(multisession == TRUE) {
      result <- text |>
        tibble::tibble(text = _) |>
        tibble::rownames_to_column(var = "id") |>
        dplyr::mutate(sentiment = furrr::future_map(text, get_sentiment_sentence, .progress = TRUE)) |>
        tidyr::unnest(sentiment)

      future::plan(future::sequential)
    }
  }

  if(method == "word") {
    result <- get_sentiment_word(text)

    if(multisession == TRUE) {
      result <- text |>
        tibble::tibble(text = _) |>
        tibble::rownames_to_column(var = "id") |>
        dplyr::mutate(sentiment = furrr::future_map(text, get_sentiment_word, .progress = TRUE)) |>
        tidyr::unnest(sentiment)

      future::plan(future::sequential)
    }

  }

  return(result)

}


