class UsersController < ApplicationController

def show
  # Find the user by ID
  @user = User.find(params[:id])

  # Set @name to the user's name
  @name = @user.name

  # Set @prototypes to the user's prototypes
  @prototypes = @user.prototypes

  # If you want to find a specific prototype associated with this user, use find_by or another query
  # For example, to find the first prototype associated with this user:
  @prototype = @user.prototypes.first
end
