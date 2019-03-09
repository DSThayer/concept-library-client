#'get_working_set
#'
#'Retrieve a single working set from the Concept Library
#'@param url URL of the concept library application
#'@param id A vector of one or more concept IDs to return
#'@param user User name for authentication (if username and password left blank, will pop up a login box)
#'@param password Password for authentication
#'@return A data frame with working set contents
#'@export
#'@import GetoptLong
#'@import dplyr
#'@examples
#'get_working_set(url='',id=1,user='username', password='*password*')

get_working_set=function(url,id,user=NA,password=NA)
{
  if (is.na(user) || is.na(password))
  {
    details=getLogin(userName=user);
    user=details[1];
    password=details[2];
  }  

  
  #The URL might already have the API address, or it may or may not have an ending /.
  #Use a replace to make sure we have a consistent URL.
  url = sub("(/api(/workingsetcodes)?)?/?$","/api/workingsetcodes/",url,perl=TRUE);

  ws_url=qq("@{url}@{id}?format=json");
  
  ws = crul::HttpClient$new(url=ws_url,auth = crul::auth(user = user, pwd = password));

  json_ws = ws$get();
  ws_df = data.frame(jsonlite::fromJSON(json_ws$parse("UTF-8")));
  
  #To do error handling.
  
  return(ws_df);
}
