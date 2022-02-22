class SessionsController < ApplicationController

    def new
    end

    def create
        entered_email = params["email"]
        entered_password = params["password"]

        # checking email
        @user = User.find_by({email: entered_email})

        if @user # yes, email matches
            # check password
            if BCrypt::Password.new(@user.password) == entered_password
                cookies["user_id"] = @user.id 
                flash[:notice] = "Welcome!"
                redirect_to "/companies"
            else
                flash[:notice] = "Password is incorrect"
                redirect_to "/session/new"
            end
        else
            flash[:notice] = "No user with that email address"
            redirect_to "/session/new"
        end
    end

    def destroy
        session["user_id"] = nil
        flash[:notice]= "You have been logged out"
        redirect_to "/session/new"
    end

end
