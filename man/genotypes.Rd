% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/package.R
\name{genotypes}
\alias{genotypes}
\title{Constructor for a \code{genotypes} object}
\usage{
genotypes(G, map, ped = NULL, alleles = c("auto", "native", "01",
  "relative"), intensity = NULL, normalized = FALSE, filter.sites = NULL,
  filter.samples = NULL, check = TRUE, ...)
}
\arguments{
\item{G}{a genotype matrix with markers in rows and samples in columns, with both row and column names}

\item{map}{a valid marker map (see Deatils) corresponding to \code{G}, with row names}

\item{ped}{a valid "pedigree" (dataframe containing sample metadata)}

\item{alleles}{character vector describing allele encoding (see \code{\link{argyle}} for details); \code{"auto"}
lets the package try to guess the encoding}

\item{intensity}{a list with elements \code{x} and \code{y} containing hybridization intensities; each
is a matrix with same dimensions and same row/column names as \code{G}}

\item{normalized}{logical; have intensities been normalized?}

\item{filter.sites}{character vector of filters attached to markers}

\item{filter.samples}{character vector of filters attached to samples}

\item{check}{logical; if \code{TRUE}, do sanity checks on input}

\item{...}{ignored}
}
\value{
a new \code{genotypes} object
}
\description{
Constructor for a \code{genotypes} object
}
\details{
The input matrix \code{G} *must* have row and column names to help the package keep the marker
	map, sample metadata, and genotypes themselves in sync.
}
\section{The \code{genotypes} class}{

	This class is designed to be a lightweight container for genotype data on a set of samples typed for a
	panel of biallelic SNP markers on a microarray.  The object inherits from base-\code{R}'s class \code{matrix},
	so any code which accepts a matrix (including the \code{apply} family) will work on a \code{genotypes} object.
	
	Attributes of \code{genotypes} objects include:
\itemize{
\item \code{map} -- marker metadata in PLINK format (chr, marker, cM, pos, A1, A2, ...)
\item \code{ped} -- pedigree/sample metadata in PLINK format (individual ID, family ID,
	mom ID, dad ID, sex, phenotype, ...)
\item \code{intensity} -- \code{list}(\code{x} = [X-intensities], \code{y} = [y-intensities])
\item \code{normalized} -- have intensities been normalized?
\item \code{baf} -- matrix of B-allele frequencies (BAFs; see \code{\link{tQN}})
\item \code{lrr} -- matrix of log2 intensity rations (LRRs; see \code{\link{tQN}})
\item \code{filter.sites} -- homage to the FILTER field in VCF format, a flag for suppresing
	sites (rows) in downstream analyses
\item \code{filter.samples} -- same as above, but along other dimension (columns)
\item \code{alleles} -- manner in which alleles are encoded: "native" (ACTGHN),
"01" (allele dosage wrt ALT allele), "relative" (allele dosage wrt MINOR allele)
	}
All attributes are maintained "parallel" to the genotypes matrix itself, and additionally have names
to avoid ambiguity.

Note that missing values (NAs/NaNs) are used for no-calls, in order to take advantage of R's behaviors on missing data.
}

\section{The marker map}{

A valid marker map is a required attribute of a \code{genotypes} object.  It is a dataframe with (at least)
the following columns, in the following order.  Columns followed by an asterisk (*) are optional but may be
required for some downstream operations.
\itemize{
\item \code{chr} -- (character, factor) chromosome identifier; use \code{NA} for missing
\item \code{marker} -- (character, factor) *globally-unique* marker name, cannot be missing
\item \code{cM} -- (numeric) genetic position of this marker in cM; use zero for missing
\item \code{pos} -- (integer) position of this marker in basepairs; use zero for missing
\item \code{A1}* -- (character, factor) REFERENCE allele, case-insensitive, cannot be missing
\item \code{A2}* -- (character, factor) ALTERNATE allele, case-insensitive, cannot be missing
}
Rownames must be present and must match the contents of column "marker".
}

\section{The "pedigree"}{

Although "pedigree" is used in homage to the nomenclature of the PLINK package, this attribute simply contains
sample metadata even if true pedigrees are unknown.  It is a dataframe with (at least) the following columns,
the first 6 of which are for PLINK compatibility, in the following order.
 \itemize{
\item \code{fid} -- (character, factor) "family" ID (aka group ID); can indicate family, population, batch...
\item \code{iid} -- (character, factor) *globally-unique* individual ID
\item \code{mom} -- (character, factor) individual ID of this sample's mother; use zero for missing
\item \code{dad} -- (character, factor) individual ID of this sample's father; use zero for missing
\item \code{sex} -- (integer) 1=male, 2=female, 0=unknown/missing
\item \code{pheno} -- (numeric) phenotype; 0/-9=missing, 1=control, 2=case, any other values allowed
	are taken to be a quantitative trait
}
Rownames must be present and must match the contents of column "iid".  The pedigree is auto-generated
when missing, and in that case every sample is assigned an "fid" identical to its "iid".
}

\section{Filters}{

The \code{filter.*} fields are character vectors describing the filter(s), if any, with which to mark markers
or samples.  An empy string (\code{""}) indicates a "passing" marker or sample.  Filters are appended to the
filter string as single characters: \code{H} for excess heterozygosity; \code{N} for excess no-call rate;
\code{I} (for sampes only) for abnormal intensity pattern; \code{F} (for markers only) for abberrant allele frequency.
}

