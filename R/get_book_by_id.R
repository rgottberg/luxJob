#' get_book_by_id
#'
#' Returns a list of recommended books. You can filter them by skill (optional)
#'
#' @param book_id
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
    # Parameters
    ## book_id: integer

    # query1 <- "SELECT sector,COUNT(companies) FROM adem.companies GROUP BY sector;"
    # query2 <- "SELECT adem.vacancies.vacancy_id,adem.vacancies.year,adem.companies.name FROM adem.vacancies JOIN adem.companies ON adem.vacancies.company_id = adem.companies.company_id ORDER BY year DESC, month DESC LIMIT 5;"
    # query3 <- "SELECT * FROM adem.companies;"

    # SQL command
    query <- glue::glue("SELECT * FROM adem.book_recommendations WHERE book_id = {book_id}")

    # Start the connection
    con <- connect_db()

    # Execute the SQL query and store results
    DBI::dbExecute(con, "SET search_path TO adem")

    # save query result into object
    query_result <- DBI::dbGetQuery(con,query)

    # Close the database connection
    DBI::dbDisconnect(con)

    # Returns
    ## data.frame with one row
    return(query_result)
}
book <- get_book_by_id(102)
