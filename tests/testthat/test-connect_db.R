test_that("Returns a PostgreSQL connection (S4 object)", {
    con <- connect_db()
    expect_s4_class(con,"PqConnection")
})
