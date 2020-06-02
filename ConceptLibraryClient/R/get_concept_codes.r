#'get_concept_codes
#'
#'Retrieve a concept or set of concepts from Concept Library
#'@param url URL of the concept library application
#'@param id A vector of one or more concept IDs to return
#'@param id A vector defining the version of each concept to return (if the entire vector is NA, get the latest version of all; if individual items are NA, get the latest version of that concept, but specify versions for others)
#'@param auth A crul::auth object (use create_auth to create); if blank will popup asking for authentication
#'@return A dataframe with id and codes
#'@export
#'@import GetoptLong
#'@import dplyr
#'@examples
#'get_concept_codes(url='',id=c(90,91,4),user='username', password='*password*')

get_concept_codes=function(
  url,
  id,
  version=NA,
  auth=NA
)
{

  if(!is.na(version) && length(version) != length(id)) {
    stop("The length of the version and id vectors must match if version is supplied.");
  }

  results = data.frame(
    id = integer(),
    code = character(),
    description = character()
  );

  mapply(i=id,v=version, FUN=function(i,v) {
    if(is.na(v)) {
      endpoint = qq("export_concept_codes/@{i}/?format=json");
    } else {
      endpoint = qq("export_concept_codes_byVersionID/@{i}/version/@{v}/?format=json");
    }

    concept_table = cl_get_api_call(url,endpoint,auth);

    #adding the two columns to the table(concept_name and concept_id)
    if (is.na(version)) {
      concept_table = mutate (concept_table, i);
    } else {
      concept_table = mutate (concept_table, i, v);
    }

    colnames(concept_table)[1] = "code";

    #add version

    #having the finalDataFrame
    concept_data_frame = data.frame(concept_table);

    results <<- rbind(results, concept_data_frame);

  });

  return(results);
}
