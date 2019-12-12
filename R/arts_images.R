#' arts_images
#' extract the primary picture of artworks matching parameters
#' Input the objectIDs from the previous function that you're interested
#' @param objectIDs eg. c(13875, 229930) for multiple IDs
#'
#' @return A table with the object ID, name, and photo
#'
#' @importFrom utils head write.csv
#' @export


arts_images <- function(objectIDs) {

  ## collect urls
  urls <- stringr::str_c("https://collectionapi.metmuseum.org/public/collection/v1/objects/", objectIDs)

  ## collect raw observations
  obs <- c()
  for(url in urls){
    request_result <- GET(url)
    cont <- content(request_result)
    obs[[length(obs)+1]] <- unlist(cont)
  }

  ## collect focused observations
  images <- c()
  for (i in 1:length(obs)) {
    df <- obs[[i]] %>%
      t() %>%
      as.data.frame()

    images[[length(images)+1]] <- df[ , c("objectID",
                                          "objectName",
                                          "primaryImageSmall")]
  }

  ## neat dataframe
  table <- do.call(rbind, images)

  ## build links to images
  table$primaryImageSmall <- stringr::str_c("![](", table$primaryImageSmall, ")")

  ## print
  table %>% knitr::kable()

}
