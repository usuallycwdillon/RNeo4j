library(RNeo4j)
context("Properties")

neo4j = startGraph("http://localhost:7474/db/data/")
clear(neo4j, input=F)

test_that("string properties are added correctly", {
  n = createNode(neo4j, "Person", name="Alice")
  expect_equal(n$name, "Alice")
})

test_that("string properties are retrieved with correct encoding", {
  n = createNode(neo4j, "Bar", location="México")
  expect_equal(n$location, "México")
})

test_that("numeric properties are added correctly", {
  n = createNode(neo4j, "Person", age=23)
  expect_equal(n$age, 23)
})

test_that("boolean properties are added correctly", {
  n = createNode(neo4j, "Person", awesome=TRUE)
  expect_true(n$awesome)
})

test_that("arrays of strings are added correctly", {
  n = createNode(neo4j, "Person", names=c("Alice", "Bob"))
  expect_identical(n$names, c("Alice", "Bob"))
})

test_that("arrays of numerics are added correctly", {
  n = createNode(neo4j, "Person", ages=c(1, 2, 3))
  expect_identical(n$ages, c(1, 2, 3))
})

test_that("arrays of booleans are added correctly", {
  n = createNode(neo4j, "Person", awesome=c(TRUE, FALSE))
  expect_identical(n$awesome, c(TRUE, FALSE))
})

test_that("updateProp works with strings", {
  n = createNode(neo4j, "Person")
  n = updateProp(n, name="Nicole")
  expect_equal(n$name, "Nicole")
})

test_that("updateProp works with numerics", {
  n = createNode(neo4j, "Person")
  n = updateProp(n, age=24)
  expect_equal(n$age, 24)
})

test_that("updateProp works with booleans", {
  n = createNode(neo4j, "Person")
  n = updateProp(n, awesome=TRUE)
  expect_true(n$awesome)
})

test_that("updateProp both replaces and creates new properties", {
  n = createNode(neo4j, "Person", name="Nicole")
  n = updateProp(n, name="Julian", age=100)
  expect_equal(n$name, "Julian")
  expect_equal(n$age, 100)
})

test_that("updateProp works with array properties", {
  n = createNode(neo4j, "Person", name="Nicole")
  n = updateProp(n, ages=c(1, 2, 3))
  expect_equal(n$name, "Nicole")
  expect_identical(n$ages, c(1, 2, 3))
})

test_that("deleteProp works with given property", {
  n = createNode(neo4j, "Person", name="Nicole", age=24)
  n = deleteProp(n, "age")
  expect_null(n$age)
  expect_equal(n$name, "Nicole")
})

test_that("deleteProp works with all=TRUE", {
  n = createNode(neo4j, "Person", name="Nicole", age=24)
  n = deleteProp(n, all=TRUE)
  expect_null(n$age)
  expect_null(n$name)
})