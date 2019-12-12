#' arts_overview
#' search artworks by defining parameters
#' All parameters require a quotation and case sensitive except "q" and numbers.
#' @param q The main query.
#' @param isOnView "true" or "false".
#' @param medium eg. "Ceramics", "Furniture", "Paintings"
#' @param hasImages "true" or "false"
#' @param geoLocation eg. "Europe", "France", "Paris", "China"
#' @param dateBegin Positive for A.D, negative for B.C
#' @param dateEnd Same as "dateBegin"
#' @return A dataframe with 15 columns
#' @examples
#' arts_overview(q = "french", isOnView = "true", hasImages = "true", medium = "Silk")
#' The output is a tidy dataframe including columns "objectID", "objectName", "culture", "period", "reign", "artistDisplayName", "artistDisplayBio", "medium", "dimensions", "city", "country", "region", "excavation", "classification", and "objectURL".
#'
#' @export
#'
#'
#' Some useful keyboard shortcuts for package authoring:
#'
#'   Install Package:           'Cmd + Shift + B'
#'   Check Package:             'Cmd + Shift + E'
#'   Test Package:              'Cmd + Shift + T'


arts_overview <- function(q,
                          isOnView = NULL,
                          medium = NULL,
                          hasImages = NULL,
                          geoLocation = NULL,
                          dateBegin = NULL,
                          dateEnd = NULL) {

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
