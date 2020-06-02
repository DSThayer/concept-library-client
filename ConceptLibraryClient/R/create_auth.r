#'create_auth
#'
#'Function to handle authentication
#'@param user User name for authentication (if username and password left blank, will pop up a login box)
#'@param password Password for authentication
#'@return A crul::auth object for use in API calls.
#'@export
#'@import GetoptLong
#'@import dplyr
#'@examples
#'credentials = create_auth(user='dan', password='fido123');
#'credentials = create_auth();  #popup a login box for user name and password.
#'credentials = create_auth(user='dan');  #popup a login box with user name prepopulated with dan
create_auth=function(
  user=NA,
  password=NA
)
{
  if (is.na(user) || is.na(password))
  {
    details=getLogin(userName=user);
    user=details[1];
    password=details[2];
  }
  
  auth_obj = crul::auth(user = user, pwd = password);
  
  password='';  #Remove password value from environment.

  return(auth_obj);
}
