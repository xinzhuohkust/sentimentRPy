asent_setup <- function(python, model = FALSE) {

  reticulate::use_python(python)

  if(model == TRUE) {

    cmd = sprintf("cmd.exe /c %s -m %s install %s", python, "pip", "https://github.com/explosion/spacy-models/releases/download/en_core_web_lg-3.5.0/en_core_web_lg-3.5.0-py3-none-any.whl")

    system(cmd, intern = TRUE)
  }


  spacy <- reticulate::import("spacy")

  asent <- reticulate::import("asent")

  nlp <- spacy$load("en_core_web_lg")

  nlp$add_pipe("asent_en_v1")

  result <- list(
    "polarity" = nlp("sentiment")$get_extension("polarity")[[3]],
    "nlp" = nlp
  )

  return(result)
}



