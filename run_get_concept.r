library(ConceptLibraryClient);

code_table = get_concept("http://192.168.50.23/",c(94,15,95,96),user='dans',password='Sail#2019');

ws_table = get_working_set("http://192.168.50.23/",id=1,user='dans',password='Sail#2019');

head(ws_table);