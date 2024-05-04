test_that("bad url throws error", {
  expect_error(get_api_request(query_url = "foo"))
})
