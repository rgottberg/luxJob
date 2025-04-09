#' get_skill_by_id
#'
#' Returns a single skill based on its ID.
#'
#' @param skill_id
#' character
#'
#' @returns
#' data.frame with skill_id, skill_label
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_skill_by_id("skill_r")
#' }
get_skill_by_id <- function(skill_id){
    tryCatch({
        # check parameter
        if (!is.character(skill_id)) stop("Invalid input: the skill_id must be a string")
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # SQL command
        query <- glue::glue_sql("SELECT skill_id, skill_label
                                FROM adem.skills
                                WHERE skill_id = {skill_id}",
                                .con = con)
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # data.frame with skill_id, skill_label
        return(query_result)
    }, error = function(e) return(e$message))
}
