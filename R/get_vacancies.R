#' get_vacancies
#'
#' Returns filtered list of job vacancies. You can combine filters.
#' @param skill
#' @param company
#' @param canton
#' @param limit
#'
#' @returns
#' @export
#'
#' @examples
#' \dontrun{
#' get_vacancies(skill = "skill_python", canton = "Luxembourg")
#' }
get_vacancies <- function(skill = NULL, company = NULL, canton = NULL, limit = 100){
    # Parameters
    ## skill: character
    # company: integer
    # canton: character
    # limit: integer

    # Returns
    ## data.frame with vacancy_id, company_id, occupation, canton, year, month
    return(NULL)
}
