#' get_vacancies
#'
#' Returns filtered list of job vacancies. You can combine filters.
#' @param skill
#' character
#'
#' @param company
#' integer
#'
#' @param canton
#' character
#'
#' @param limit
#' integer
#'
#'
#' @returns
#' Returns data.frame with vacancy_id, company_id, occupation, canton, year, month
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_vacancies(skill = "skill_python", canton = "Luxembourg")
#' }
get_vacancies <- function(skill = NULL, company = NULL, canton = NULL, limit = 100){

    # Returns data.frame with vacancy_id, company_id, occupation, canton, year, month
    return(NULL)
}
