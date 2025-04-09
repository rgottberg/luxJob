#' get_learning_tracks
#'
#' Returns learning tracks. If skill_id is given, returns only tracks teaching that skill.
#'
#' @param skill_id
#' character (optional)
#'
#' @returns
#' data.frame with track_id, title, description, url
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_learning_tracks(skill_id = "skill_r")
#' }
get_learning_tracks <- function(skill_id = NULL){
    tryCatch({
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # check parameter
        if(is.null(skill_id)){
            # SQL command
            query <- glue::glue_sql("SELECT l.track_id, l.title, description, url
                                    FROM adem.learning_tracks AS l
                                    JOIN adem.track_skills AS t
                                    ON l.track_id = t.track_id",
                                    .con = con)
        }
        else{
            # SQL command
            query <- glue::glue_sql("SELECT l.track_id, l.title, description, url
                                    FROM adem.learning_tracks AS l
                                    JOIN adem.track_skills AS t
                                    ON l.track_id = t.track_id
                                    WHERE t.skill_id = {skill_id}",
                                    .con = con)
        }
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns data.frame with track_id, title, description, url
        return(query_result)
    }, error = function(e) return(e$message))
}
get_learning_tracks()
