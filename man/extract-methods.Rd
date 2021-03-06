% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gbFeature-class.R, R/gbFeatureTable-class.R, R/gbRecord-class.R
\docType{methods}
\name{[[,gbFeature,character,missing-method}
\alias{$,gbFeature-method}
\alias{[,gbFeatureTable,character,missing-method}
\alias{[,gbFeatureTable,logical,missing-method}
\alias{[,gbFeatureTable,missing,missing-method}
\alias{[,gbFeatureTable,numeric,missing-method}
\alias{[,gbRecord,ANY,missing-method}
\alias{[,gbRecord,missing,missing-method}
\alias{[[,gbFeature,character,missing-method}
\alias{[[,gbFeatureTable,ANY,ANY-method}
\alias{[[,gbRecord,ANY,ANY-method}
\title{Method extensions to extraction operator for gbRecord objects.}
\usage{
\S4method{[[}{gbFeature,character,missing}(x, i, j)

\S4method{$}{gbFeature}(x, name)

\S4method{[}{gbFeatureTable,character,missing}(x, i, j, ..., drop = TRUE)

\S4method{[}{gbFeatureTable,numeric,missing}(x, i, j, ..., drop = TRUE)

\S4method{[}{gbFeatureTable,logical,missing}(x, i, j, ..., drop = TRUE)

\S4method{[}{gbFeatureTable,missing,missing}(x, i, j, ..., drop = TRUE)

\S4method{[[}{gbFeatureTable,ANY,ANY}(x, i, j, ...)

\S4method{[}{gbRecord,ANY,missing}(x, i, j, ..., drop = TRUE)

\S4method{[}{gbRecord,missing,missing}(x, i, j, ..., drop = TRUE)

\S4method{[[}{gbRecord,ANY,ANY}(x, i, j, ...)
}
\arguments{
\item{x}{A \code{\linkS4class{gbFeature}}, \code{\linkS4class{gbFeatureTable}},
or \code{\linkS4class{gbRecord}} object.}

\item{i}{indices specifying elements to extract. With \code{gbFeatureTable}s
and \code{gbRecord}s, a \code{character} index is matched against feature keys;
\code{gbFeature}s a \code{character} index is matched against qualifiers.}

\item{j}{Not used.}

\item{name}{The name of the element to extract.}

\item{...}{Not used.}

\item{drop}{Not used.}
}
\value{
A \code{\linkS4class{gbFeatureTable}} object or elements of a
\code{\linkS4class{gbFeature}} object.
}
\description{
See the documentation for the \code{\link[base]{Extract}} generic,
defined in the R \code{\link[base]{base-package}} for the expected behavior.
}
\examples{
load(system.file("extdata", "marine_metagenome.rda", package = "biofiles"))

## Extract a gbFeatureTable from a gbRecord:
x[1:4]

## Extract a gbFeature
x[[1]]

## Extract ggFeatures by Feature Key
x["CDS"]

}
\seealso{
\code{\link[base]{Extract}}
}

