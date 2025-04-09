#' get_books
#'
#' Returns all recommended books. Filter by skill if needed.
#'
#' @param skill
#' character (optional)
#'
#' @returns
#' data.frame with book_id, title, author, skill_id (replaced by label)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_books(skill = "skill_python")
#' }
get_books <- function(skill = NULL){
    tryCatch({
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # check parameter
        if(is.null(skill)){
            # SQL command
            query <- glue::glue_sql("SELECT b.book_id, b.title, s.skill_label
                                    FROM adem.book_recommendations AS b
                                    JOIN adem.skills AS s
                                    ON b.skill_id = s.skill_id",
                                    .con = con)
        }
        else{
            if (!is.character(skill)) stop("Invalid input: the skill must be a string")
            # SQL command
            query <- glue::glue_sql("SELECT b.book_id, b.title, b.author, s.skill_label
                                    FROM adem.book_recommendations AS b
                                    JOIN adem.skills AS s
                                    ON b.skill_id = s.skill_id
                                    WHERE s.skill_label = {skill}",
                                    .con = con)
        }
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns data.frame with book_id, title, author, skill_id (replaced by label)
        return(query_result)
    }, error = function(e) return(e$message))
}
get_books("Serbian")
