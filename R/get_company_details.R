#' get_company_details
#'
#' Returns company info and all its vacancies. Returns NULL if not found.
#'
#' @param company_id
#' integer
#'
#' @returns
#' list(company, vacancies)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_company_details(42)
#' }
get_company_details <- function(company_id){
    tryCatch({
        # check parameter
        if (!is.numeric(company_id)) stop("Invalid input: the company_id must be an integer number")
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # SQL command
        query <- glue::glue_sql("SELECT c.name, v.vacancy_id
                                FROM adem.companies AS c
                                JOIN adem.vacancies AS v
                                ON c.company_id = v.company_id
                                WHERE c.company_id = {company_id}",
                                .con = con)
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns list(company, vacancies)
        return(list(query_result))
    }, error = function(e) return(e$message))
}
