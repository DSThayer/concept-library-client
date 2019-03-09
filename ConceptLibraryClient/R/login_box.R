#' getLogin
#'
#' This function pops up a login box for username and password, with masking of the password field. It returns a vector where the first item is the username and the second is the password. Clear this as soon as it is used, to avoid password existing in your environment.
#' 
#' This can be used for any purpose. If you want to connect to SAIL, try SAILConnect instead, which
#' uses this function and also connects to PR_SAIL and returns a database connection.
#'
#' Note that the login box may appear behind your active window.
#' @param userName A user name (optional). If provided, the login box will be prepopulated with this user name.
#' @keywords SAILDBUtils 
#' @export
#' @examples details = getLogin();
#' @import tcltk

getLogin<-function(userName=''){  
	wnd<-tktoplevel();
	tclVar(userName)->user;
	tclVar("")->passVar;
	#Label  

	#Username box  
	tkgrid(tklabel(wnd,text="Username:"));  
	tkgrid(tkentry(wnd,textvariable=user)->passBox);  

	#Password box  
	tkgrid(tklabel(wnd,text="Password:"));  
	tkgrid(tkentry(wnd,textvariable=passVar,show="*")->passBox);  
	#Hitting return will also submit password  
	tkbind(passBox,"<Return>",function() tkdestroy(wnd));  
	#OK button  
	tkgrid(tkbutton(wnd,text="OK",command=function() tkdestroy(wnd)));  
	#Wait for user to click OK  
	tkwait.window(wnd);  
	password<-tclvalue(passVar);
	userName<-tclvalue(user);
	return(c(userName,password));  
} 