#' get_skills
#'
#' Returns all skills from adem.skills. Limited by limit.
#'
#' @param limit
#' integer
#'
#' @returns
#' data.frame with skill_id, skill_label
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_skills(limit = 20)
#' }
get_skills <- function(limit = 100){
    tryCatch({
        # check parameter
        if (!is.numeric(limit)) stop("Invalid input: the limit must be an integer number")
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # SQL command
        query <- glue::glue_sql("SELECT skill_id, skill_label
                                FROM adem.skills
                                LIMIT {limit}",
                                .con = con)
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns data.frame with skill_id, skill_label
        return(query_result)
    }, error = function(e) return(e$message))
}
get_skills(3)
