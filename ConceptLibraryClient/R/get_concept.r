#'get_concept
#'
#'Retrieve a concept or set of concepts from Concept Library
#'@param url URL of the concept library application
#'@param id A vector of one or more concept IDs to return
#'@param user User name for authentication (if username and password left blank, will pop up a login box)
#'@param password Password for authentication
#'@return A data frame with id and codes
#'@export
#'@import GetoptLong
#'@import dplyr
#'@examples
#'get_concept(url='',id=c(90,91,4),user='username', password='*password*')

get_concept=function(url,id,user=NA,password=NA)
{
  if (is.na(user) || is.na(password))
  {
    details=getLogin(userName=user);
    user=details[1];
    password=details[2];
  }    
  
  #The URL might already have the API address, or it may or may not have an ending /.
  #Use a replace to make sure we have a consistent URL.
  url = sub("(/api(/groupconceptcodes)?)?/?$","/api/groupconceptcodes/",url,perl=TRUE);

  results = data.frame(
    id = integer(),
    code = character(),
    description = character()
  );

  lapply(id,function(id) {
    concept_url=qq("@{url}@{id}?format=json");
    
    concept = crul::HttpClient$new(url=concept_url,auth = crul::auth(user = user, pwd = password));

    json_concept <- concept$get();
    
    concept_table <- data.frame(jsonlite::fromJSON(json_concept$parse("UTF-8")));
    
    #adding the two columns to the table(concept_name and concept_id)
    concept_table = mutate (concept_table, id);
    colnames(concept_table)[1] = "code";
    
    #having the finalDataFrame
    concept_data_frame = data.frame(concept_table);
    
    #checking there are 4 columns in the dataframe and as well
    #if the columns match the names that we have
    if (ncol(concept_data_frame) == 3 &&
          ("code" %in% colnames(concept_data_frame)) &&
          ("id" %in% colnames(concept_data_frame)) &&
          ("description" %in% colnames(concept_data_frame))
    )
    {
      results <<- rbind(results, concept_data_frame);
    }
    #else output a friendly messagge
    else
    {
      cat(
        "Concept ", id, "was not added due to either permission or different structure.\n"
      )
    }
    
  });
  
  return(results);
}
