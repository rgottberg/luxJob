#' get_learning_track_by_id
#'
#' Returns one learning track and all its linked skills. Returns NULL if not found.
#'
#' @param track_id
#' integer
#'
#' @returns
#' list(track, skills)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_learning_track_by_id(71)
#' }
get_learning_track_by_id <- function(track_id){
    tryCatch({
        # check parameter
        if (!is.numeric(track_id)) stop("Invalid input: the track_id must be an integer number")
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # SQL command
        query <- glue::glue_sql("SELECT l.title, t.skill_id
                                FROM adem.learning_tracks AS l
                                JOIN adem.track_skills AS t
                                ON l.track_id = t.track_id
                                WHERE l.track_id = {track_id}",
                                .con = con)
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns list(track, skills)
        return(list(query_result))
    }, error = function(e) return(e$message))
}
