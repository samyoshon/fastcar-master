class UsersController < ApplicationController
  
  def dealerships
  	if current_user.present? && current_user.admin?
    	@dealership = Dealership.new
    	@dealerships = Dealership.all
    else 
    	redirect_to root_path
	end
  end

  def create_dealerships
  	if current_user.present? && current_user.admin?
	    @dealership = Dealership.create(dealership_params)

	    respond_to do |format|
	      if @dealership.save
	        format.html { redirect_to :new_dealerships, notice: 'Dealership was successfully created.' }
	        format.json { render :show, status: :created, location: @user }
	      else
	        format.html { render :new }
	        format.json { render json: @dealership.errors, status: :unprocessable_entity }
	      end
	    end
	else 
    	redirect_to root
	end
  end

  private
    def dealership_params
      params.require(:dealership).permit(:name, :car_make_id, :street, :city, :state, :country, :zipcode, :latitude, :longitude)
    end
end