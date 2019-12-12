#' arts_overview
#' search artworks by defining parameters
#' All parameters require a quotation and case sensitive except "q" and numbers.
#' @param q The main query.
#' @param isOnView "true" or "false".
#' @param medium eg. "Ceramics", "Furniture", "Quilts|Silk|Bedcovers"
#' @param hasImages "true" or "false"
#' @param geoLocation eg. "Europe", "France", "Paris", "China"
#' @param dateBegin Positive for A.D, negative for B.C
#' @param dateEnd Same as "dateBegin"
#' @return A dataframe with 15 columns
#' The output is a tidy dataframe including columns "objectID", "objectName", "culture", ect.
#'
#' @importFrom utils head write.csv
#' @export


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

  requireNamespace("dplyr")
  requireNamespace("httr")
  requireNamespace("stringr")

  results <- httr::GET(endpoint, query = query_params) %>%
    content()

  ## check if the result is ZERO or not
  if (results[[1]] == 0) {
    cat("No object matched, try again :D")} else {
      ## objectIDs that match the parameters' conditions
      objectIDs <- results[[2]] %>%
        unlist()
      ## collect urls
      urls <- stringr::str_c("https://collectionapi.metmuseum.org/public/collection/v1/objects/", objectIDs)

      ## collect raw observations
      obs <- c()
      for(url in urls){
        request_result <- httr::GET(url)
        cont <- httr::content(request_result)
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

}
