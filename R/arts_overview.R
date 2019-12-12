#' arts_overview
#' compare the change 1st.
#' compare the change 1st.
#' This is a function mainly used to find masterpieces you may be interested by defining several parameters.
#
#' The parameters consists of "q", "isOnView", "medium", "hasImages", "geoLocation", "dateBegin", and "dateEnd".
#
#' The output is a tidy dataframe including columns "objectID", "objectName", "culture", "period", "reign", "artistDisplayName", "artistDisplayBio", "medium", "dimensions", "city", "country", "region", "excavation", "classification", and "objectURL".
#
#' @export
#
#
#' Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

arts_overview <- function(q,
                          isOnView = NULL,
                          medium = NULL,
                          hasImages = NULL,
                          geoLocation = NULL,
                          dateBegin = NULL,
                          dateEnd = NULL) {
  library(dplyr)
  library(httr)
  endpoint <- c("https://collectionapi.metmuseum.org/public/collection/v1/search?")
  query_params <- list("q" = q,
                       "isOnView" = isOnView,
                       "medium" = medium,
                       "hasImages" = hasImages,
                       "geoLocation" = geoLocation,
                       "dateBegin" = dateBegin,
                       "dateEnd" = dateEnd)

  results <- GET(endpoint, query = query_params) %>%
    content()

  ## objectIDs that match the parameters' conditions
  objectIDs <- results[[2]] %>%
    unlist()

  library(stringr)
  ## collect urls
  urls <- str_c("https://collectionapi.metmuseum.org/public/collection/v1/objects/", objectIDs)

  ## collect raw observations
  obs <- c()
  for(url in urls){
    request_result <- GET(url)
    cont <- content(request_result)
    obs[[length(obs)+1]] <- unlist(cont)
  }

  ## collect focused observations
  dfs <- c()
  for (i in 1:length(obs)) {
    df <- obs[[i]] %>%
      t() %>%
      as.data.frame()

    ## define focused variables
    variables <- c("objectID", "objectName", "culture", "period", "reign",
                   "artistDisplayName", "artistDisplayBio", "medium",
                   "dimensions", "city", "country", "region", "excavation",
                   "classification", "objectURL")
    dfs[[length(dfs)+1]] <- df[ , variables]
  }

  ## neat dataframe
  table <- do.call(rbind, dfs)
  ## save as csv file
  write.csv(table, "arts_overview.csv", row.names=TRUE)
  ## overview
  head(table, 6)

}
