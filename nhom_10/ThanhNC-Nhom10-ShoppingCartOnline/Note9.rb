25/06/2012

1. shortcut for setting flash[:notice] by passing an options hash to the redirect_to function
    Code:  
      redirect_to signin_path, notice: "Please sign in." unless signed_in?

      # Replace for 
      flash[:notice] = "Please sign in."
      redirect_to signin_path