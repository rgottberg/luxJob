% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_learning_tracks.R
\name{get_learning_tracks}
\alias{get_learning_tracks}
\title{get_learning_tracks}
\usage{
get_learning_tracks(skill_id = NULL)
}
\arguments{
\item{skill_id}{character (optional)}
}
\value{
data.frame with track_id, title, description, url
}
\description{
Returns learning tracks. If skill_id is given, returns only tracks teaching that skill.
}
\examples{
\dontrun{
get_learning_tracks(skill_id = "skill_r")
}
}
