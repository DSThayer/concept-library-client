#Use devtools to be able to install a package from Github
#install.packages("devtools");
library(devtools);

install_github("DSThayer/concept-library-client", subdir="ConceptLibraryClient")

library(ConceptLibraryClient);

#Retrieve the latest version of a concept. You will be prompted for a username and password
copd_icd10 = ConceptLibraryClient::get_concept_codes(
  url='https://conceptlibrary.saildatabank.com',
  id=141
);

#Set your credentials so you don't have to log in for each command.
credentials = create_auth;

#Get a concept, explicitly specifying a particular version.
copd_icd10_20200602 = get_concept_codes(
  url='https://conceptlibrary.saildatabank.com',
  id=141,
  version=392,
  auth=credentials #Supply username and password
);

#Retrieve multiple concepts into a single data frame
comorbidities_primary_care = get_concept_codes(
  url='https://conceptlibrary.saildatabank.com',
  id=c(140,142,144),
  auth=credentials
);


