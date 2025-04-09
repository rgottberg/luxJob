#' get_vacancy_by_id
#'
#' Returns full vacancy info + required skills. Returns NULL if not found.
#'
#' @param vacancy_id
#' integer
#'
#' @returns
#' list(vacancy, skills)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_vacancy_by_id(123456)
#' }
get_vacancy_by_id <- function(vacancy_id){
    tryCatch({
        # check parameter
        if (!is.numeric(vacancy_id)) stop("Invalid input: the vacancy_id must be an integer number")
        # Start the connection (here to avoid issues with the query command)
        con <- connect_db()
        # SQL command
        query <- glue::glue_sql("SELECT *
                                FROM adem.vacancies AS v
                                JOIN adem.vacancy_skills AS vs
                                ON v.vacancy_id = vs.vacancy_id
                                WHERE v.vacancy_id = {vacancy_id}",
                                .con = con)
        # Execute the SQL query and store results
        DBI::dbExecute(con, "SET search_path TO adem")
        # save query result into object
        query_result <- DBI::dbGetQuery(con,query)
        # Close the database connection
        DBI::dbDisconnect(con)
        # Returns list(vacancy, skills)
        return(list(query_result))
    }, error = function(e) return(e$message))
}
