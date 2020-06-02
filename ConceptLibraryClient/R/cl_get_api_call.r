#'cl_get_api_call
#'
#'Internal function to call the CL API to get data. Wrapped by functions that get concepts/working sets.
#'@param url URL of the concept library application
#'@param id A vector of one or more concept IDs to return
#'@param auth A crul::auth object. Will prompt for credentials if not supplied.
#'@return A data frame with id and codes
#'@import GetoptLong
#'@import dplyr
#'@examples
#'get_concept(url='',id=c(90,91,4),user='username', password='*password*')

cl_get_api_call=function(
  url,
  endpoint,
  auth
)
{
  if (is.na(auth)) { auth = create_auth(); }
  
  #remove a trailing slash if there is one, for consistency.
  url = sub("/$","",url,perl=TRUE);

  full_url=qq("@{url}/api/@{endpoint}");
    
  result = crul::HttpClient$new(url=full_url,auth=auth);
    
  result_content = result$get();

  if (result_content$status_code != 200) {
      error=paste(result_content$status_http(),collapse=' ');
      stop(qq("Error calling @{full_url}: @{error}"));
  }
    
  result_df = data.frame(jsonlite::fromJSON(result_content$parse("UTF-8")));
    
  return(result_df);
}
