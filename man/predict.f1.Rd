% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/genetics.R
\name{predict.f1}
\alias{predict.f1}
\title{Predict genotype of an F1 individual given genotypes of its parents}
\usage{
\method{predict}{f1}(object, na.rm = FALSE, ...)
}
\arguments{
\item{object}{a \code{genotypes} object}

\item{na.rm}{logical; should missing genotypes be ignored?}

\item{...}{ignored}
}
\value{
a new \code{genotypes} object containing predicted genotypes for all possible F1s between
	the parents in \code{object}
}
\description{
Predict genotype of an F1 individual given genotypes of its parents
}
\details{
Each column in the input is assumed to be either a representative individual from an inbred
	line, or a consensus genotype across several such individuals.  No checks are performed on the homzygosity
	of the parents, but parents with high heterozygosity will result in F1 predictions with mostly missing
	genotypes.
	
	When \code{na.rm = TRUE}, a missing genotype in either parent causes an \code{NA} to be emitted for
	the F1; when \code{na.rm = FALSE}, the non-missing parental genotype (if any) is emitted. Heterozygous
	calls in either parent always generate an \code{NA} in the F1.

	F1s are named like "parent1::parent2".

	Sex chromosomes and mitochonria receive no special treatment, so genotypes there will probably be bogus
	(except for the case of chrX in F1 females.)
}
\seealso{
\code{\link{segregating}}, \code{\link{fixed.diffs}}
}

