\name{wordwrap}
\alias{wordwrap}
\alias{strfit}

\title{
  Wrap or break strings into lines of specified width
}
\description{
  strfit does hard wrapping, i.e. break within long words, wordwrap is a
  wrapper of strfit but also provides soft wrapping option, i.e. break
  only between words, and keep long words intact.
}
\usage{
wordwrap(s, width = 20, break.word = FALSE)
strfit(s, width = 20)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{s}{
    characcter, strings to be wrapped or broken down.
  }
  \item{width}{
    integer, target line width in terms of number of characters. d
    width=20.
  }
  \item{break.word}{
    logical, whether to break within words or only between words as to fit
    the line width. Default break.word=FALSE, i.e. keep words intact and only
    break between words. Therefore, some line may exceed the \code{width}
    limit.
  }
}
\details{
These functions are called as to wrap long node labels into shorter
  lines on pathway graphs in \code{keggview.graph} function (when
  keggview.native=FALSE). They are equally useful for wrapping long
  labels in other types of graphs or output formats.
}
\value{
character of the same length of \code{s} except that each element has
been wrapped softly or hardly.
}
\references{
  Luo, W. and Brouwer, C., Pathview: an R/Bioconductor package for
  pathway based data integration and visualization. Bioinformatics,
 2013, 29(14): 1830-1831, doi: 10.1093/bioinformatics/btt285
}
\author{
  Weijun Luo <luo_weijun@yahoo.com>
}

\seealso{
\code{strwrap} in R base. 
}
\examples{
long.str="(S)-Methylmalonate semialdehyde"
wr1=wordwrap(long.str, width=15)
#long word intact
cat(wr1, sep="\n")
wr2=strfit(long.str, width=15)
#long word split
cat(wr2, sep="\n")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
