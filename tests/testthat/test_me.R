# Note to myself
# This is where you do all kinds of test cases
# save it in the main folder, not the R folder
# save with the title "test_somethig" always start with "test"

# case ignores
test_that("case is ignored", {
	expect_equal(gday(team="canucks"), gday(team="CANUCKS"))
	expect_equal(score(team="canucks"), score(team="CANUCKS"))
})


# we know Dubai isn't in North American NHL
test_that("some team isn't playing", {
	expect_true(identical(gday(team="Dubai"), "not playing"))
	expect_true(is.data.frame(score(team = "Dubai")))
})



# expecting errors thrown from checDate()
test_that("bad date format", {
	expect_error(gday(date = "2014-11-111"))
	expect_error(gday(date = 'january 31'))
	expect_error(gday(date = "2014-11-111"))
	expect_error(score(date = 'january 31'))
})

# tell people that information is unavailable

test_that("unavailable info", {
	expect_equal(gday(date = "2033-11-11"), "information not available for this date")
	expect_equal(score(date = "1888-11-11"), "information not available for this date")
})
