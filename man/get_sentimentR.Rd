\name{get_sentimentR}
\alias{get_sentimentR}
\title{Sentence-level with \code{sentimentr} and word-level with dictionary \code{afinn}}
\usage{
get_sentimentR(text, method = "sentence", multisession = FALSE)
}
\description{
Calculate sentence-level sentiment scores using the \code{sentimentr} and dictionary \code{afinn}. This function supports vectorization, multithreading, and is robust to errors.
}
\arguments{
\item{text}{Character vector to be analyzed.}
\item{method}{Character vertor specifying which method to use. \code{sentence} or \code{word}}
\item{multisession}{Logical vector specifying whether to use all available CPU cores. Default is \code{FALSE}}
}
\value{
A tibble consisting of result.
}


