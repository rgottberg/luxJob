#TRYCATCH BLOCKS HANDLES THE ERRORS AND RETURNS STRING
# test_that("Input must be an integer", {
#     book_id <- "a"
#     expect_error(get_book_by_id(book_id))
# })

test_that("Input must be an integer", {
    book_id <- "a"
    result <- get_book_by_id(book_id)
    expect_match(result, "Invalid input: the book_id must be an integer number")
})

test_that("Returns a data.frame (S3 object)", {
    book_id <-100
    df <- get_book_by_id(book_id)
    expect_s3_class(df,"data.frame")
})
