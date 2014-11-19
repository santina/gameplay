# Note to myself
# This is where you do all kinds of test cases
# save it in the main folder, not the R folder
# save with the title "test_somethig" always start with "test"

# case ignores
test_that("case is ignored", {
	expect_equal(gday("canucks"), gday("CANUCKS"))
	expect_equal(score("canucks"), score("CANUCKS"))
})


test_that('should fail', {
	expect_false(gday("seattle"))
})

# expecting errors thrown from checDate()

test_that("bad date format", {
	expect_error(score("2014-11-111"))
})
