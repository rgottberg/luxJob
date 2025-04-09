#' get_companies
#'
#' Returns all companies from adem.companies.
#'
#' @param limit
#' integer
#'
#' @returns
#' data.frame with company_id, name, sector
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_companies(limit = 50)
#' }
get_companies <- function(limit = 100){
    tryCatch({
        # check parameter
        if (!is.numeric(limit)) stop("Invalid input: the limit must be an integer number")
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # SQL command
        query <- glue::glue_sql("SELECT company_id, name, sector
                                FROM adem.companies
                                LIMIT {limit}",
                                .con = con)
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns data.frame with company_id, name, sector
        return(query_result)
    }, error = function(e) return(e$message))
}
