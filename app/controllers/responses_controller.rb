class ResponsesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_response, only: [:show, :edit, :update, :destroy]

  # GET /responses
  # GET /responses.json
  def index
    if current_user.present? && current_user.dealership_id?
      @responses = Response.where("user_id = ?", current_user.id)
    elsif 
      redirect_to root_url
    end
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
    @response = Response.find(params[:id])
    @user = current_user
  end

  # GET /responses/new
  def new
    if current_user.present? && current_user.dealership_id?
      if Proposal.find(params[:id]).car_make_id == current_user.dealership.car_make_id
        @response = Response.new
      else
        redirect_to root_url
      end
    end
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = current_user.responses.build(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: 'Response was successfully created.' }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reviews
    if Response.find(params[:id]).proposal.user_id == current_user.id
      @review = Review.new
      @response = Response.find(params[:id])
      @proposal = Response.find(params[:id]).proposal
      @seller = Response.find(params[:id]).user
    else
      redirect_to root_url
    end
  end

  def create_reviews
    @review = current_user.reviews.build(review_params)
    @review.buyer_id = current_user.id

    if @review.save
      flash[:alert] = "Thanks for your review."
      redirect_to root_path
    else
      flash[:alert] = "Could not save review."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(:user_id, :proposal_id, :car_year_id, :car_make_id, :car_model_id, :car_color_id, :add_ons, :price, :down_payment, :lease_length, :mileage_limit, :closing_cost, :financing, :apr, :deadline)
    end
end
