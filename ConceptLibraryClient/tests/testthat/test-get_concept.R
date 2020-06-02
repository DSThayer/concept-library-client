context("Tests for retrieving concept");

credentials=create_auth();

codes_latest          = get_concept_codes(url='https://conceptlibrary.saildatabank.com',id=631, auth=credentials);
codes_latest_explicit = get_concept_codes(url='https://conceptlibrary.saildatabank.com',id=631,version=1375, auth=credentials);
codes_previous        = get_concept_codes(url='https://conceptlibrary.saildatabank.com',id=631,version=1374, auth=credentials);

#To do: test getting multiple concepts.

test_that("Retrieve a concept",{
  expect_equal( nrow(codes_latest_explicit), 2      );
  expect_equal( nrow(codes_previous), 3      );
  expect_equal( codes_latest$code,codes_latest_explicit$code      );
  expect_equal( "11542" %in% codes_latest$code   , TRUE );
  expect_equal( "11542" %in% codes_previous$code   , FALSE );
  expect_equal( "1252." %in% codes_latest$code   , FALSE );
  expect_equal( "1252." %in% codes_previous$code   , TRUE );
});

#codes_latest_explicit = get_working_set(url='https://conceptlibrary.saildatabank.com',id=631,version=1375, auth=credentials);
#codes_previous        = get_concept_codes(url='https://conceptlibrary.saildatabank.com',id=631,version=1374, auth=credentials);

#test_that("Retrieve a working set",{
#  expect_equal( nrow(codes_latest), 2      );
#  expect_equal( nrow(codes_latest_explicit), 2      );
#  expect_equal( nrow(codes_previous), 3      );
#  expect_equal( codes_latest$code,codes_latest_explicit$code      );
#  expect_equal( "11542" %in% codes_latest$code   , TRUE );
#  expect_equal( "11542" %in% codes_previous$code   , FALSE );
#  expect_equal( "1252." %in% codes_latest$code   , FALSE );
#  expect_equal( "1252." %in% codes_previous$code   , TRUE );
#});
