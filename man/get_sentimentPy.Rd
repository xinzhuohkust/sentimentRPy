\name{get_sentimentPy}
\alias{get_sentimentPy}
\title{Sentence-level sentiment with \code{asent}}
\usage{
get_sentimentPy(text)
}
\description{
Calculate sentence-level sentiment scores using the Python module \code{asent}. This function supports vectorization and is robust to errors.
}
\arguments{
\item{text}{Character vector to be analyzed.}

}
\value{
A tibble consisting of \code{neg}, \code{neu}, \code{pos}, and \code{compound}
}


