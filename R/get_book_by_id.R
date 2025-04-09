#' get_book_by_id
#'
#' Returns a list of recommended books.
#'
#' @param book_id
#' integer
#'
#' @returns
#' data.frame with one row
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_book_by_id(101)
#' }
#'
#'
get_book_by_id <- function(book_id){
    tryCatch({
        # check parameter
        if (!is.numeric(book_id)) stop("Invalid input: the book_id must be an integer number")
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # SQL command
        query <- glue::glue_sql("SELECT *
                                FROM adem.book_recommendations
                                WHERE book_id = {book_id}",
                                .con = con)
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns data.frame with one row
        return(query_result)
    }, error = function(e) return(e$message))
}
