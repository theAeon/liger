% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rliger.R
\name{optimizeALS}
\alias{optimizeALS}
\alias{optimizeALS.list}
\alias{optimizeALS.liger}
\title{Perform iNMF on scaled datasets}
\usage{
optimizeALS(object, ...)

\method{optimizeALS}{list}(
  object,
  k,
  lambda = 5,
  thresh = 1e-06,
  max.iters = 30,
  nrep = 1,
  H.init = NULL,
  W.init = NULL,
  V.init = NULL,
  use.unshared = FALSE,
  lamda.u = NULL,
  rand.seed = 1,
  print.obj = FALSE,
  verbose = TRUE,
  ...
)

\method{optimizeALS}{liger}(
  object,
  k,
  lambda = 5,
  thresh = 1e-06,
  max.iters = 30,
  nrep = 1,
  H.init = NULL,
  W.init = NULL,
  V.init = NULL,
  use.unshared = FALSE,
  rand.seed = 1,
  print.obj = FALSE,
  verbose = TRUE,
  ...
)
}
\arguments{
\item{object}{\code{liger} object. Should normalize, select genes, and scale before calling.}

\item{...}{Arguments passed to other methods}

\item{k}{Inner dimension of factorization (number of factors). Run suggestK to determine
appropriate value; a general rule of thumb is that a higher k will be needed for datasets with
more sub-structure.}

\item{lambda}{Regularization parameter. Larger values penalize dataset-specific effects more
strongly (ie. alignment should increase as lambda increases). Run suggestLambda to determine
most appropriate value for balancing dataset alignment and agreement (default 5.0).}

\item{thresh}{Convergence threshold. Convergence occurs when |obj0-obj|/(mean(obj0,obj)) < thresh.
(default 1e-6)}

\item{max.iters}{Maximum number of block coordinate descent iterations to perform (default 30).}

\item{nrep}{Number of restarts to perform (iNMF objective function is non-convex, so taking the
best objective from multiple successive initializations is recommended). For easier
reproducibility, this increments the random seed by 1 for each consecutive restart, so future
factorizations of the same dataset can be run with one rep if necessary. (default 1)}

\item{H.init}{Initial values to use for H matrices. (default NULL)}

\item{W.init}{Initial values to use for W matrix (default NULL)}

\item{V.init}{Initial values to use for V matrices (default NULL)}

\item{rand.seed}{Random seed to allow reproducible results (default 1).}

\item{print.obj}{Print objective function values after convergence (default FALSE).}

\item{verbose}{Print progress bar/messages (TRUE by default)}
}
\value{
\code{liger} object with H, W, and V slots set.
}
\description{
Perform integrative non-negative matrix factorization to return factorized H, W, and V matrices.
It optimizes the iNMF objective function using block coordinate descent (alternating non-negative
least squares), where the number of factors is set by k. TODO: include objective function
equation here in documentation (using deqn)

For each dataset, this factorization produces an H matrix (cells by k), a V matrix (k by genes),
and a shared W matrix (k by genes). The H matrices represent the cell factor loadings.
W is held consistent among all datasets, as it represents the shared components of the metagenes
across datasets. The V matrices represent the dataset-specific components of the metagenes.
}
\examples{
\dontrun{
# Requires preprocessed liger object (only for objected not based on HDF5 files)
# Get factorization using 20 factors and mini-batch of 5000 cells 
# (default setting, can be adjusted for ideal results)
ligerex <- optimizeALS(ligerex, k = 20, lambda = 5, nrep = 1)
}
}
