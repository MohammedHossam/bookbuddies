class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    def json_response(object, status = :ok)
        render json: object, status: status
      end
  # GET /users
  def index
    @users = User.all
    json_response(@users)
  end

  # POST /users
  def create
    @user = User.find_by(google_id: user_params['id'])
    if(@user==nil) then
        @user = User.create!(email: user_params['email'],
                             family_name: user_params['familyName'],
                            given_name: user_params['givenName'],
                            google_id: user_params['id'],
                            name: user_params['name'],
                            photo_url: user_params['photoUrl']
        );
    end
   json_response(@user, :created)  
  end

  # GET /users/:id
  def show
    json_response(@user)
  end

  # PUT /users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    # whitelist params
    params.permit(:phone_number,:name,:email,:familyName,:givenName,:id,:photoUrl)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
