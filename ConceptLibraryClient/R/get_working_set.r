#'get_working_set
#'
#'Retrieve a single working set from the Concept Library
#'@param url URL of the concept library application
#'@param id A working set ID to return
#'@param version Version of working set to return (NA = latest version)
#'@param auth Credentials for API call (create with create_auth() or leave blank to be prompted)
#'@return A data frame with working set contents
#'@export
#'@import GetoptLong
#'@import dplyr
#'@examples
#'get_working_set(url='https://conceptlibrary.saildatabank.com',id=1,auth=credentials)

get_working_set=function(url,id,version=NA,auth=NA)
{

  if(is.na(version)) {
    endpoint = qq("export_workingset_codes/@{id}/?format=json");
  } else {
    endpoint = qq("export_workingset_codes_byVersionID/@{id}/version/@{version}/?format=json");
  }
  
  ws_table = cl_get_api_call(url,endpoint,auth);
  
  return(ws_table);
}