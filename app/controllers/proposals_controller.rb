class ProposalsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update]
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]
  # before_action :set_search
  
  # GET /proposals
  # GET /proposals.json
  def set_search
    @q = Proposal.search(params[:q])
  end

  def index
    # @makes = HTTParty.get('https://jsonplaceholder.typicode.com', :headers => {'Content-Type' => 'application/json'})
    # @makes.to_json
    @q = Proposal.search(params[:q])

    # Dealer sees all proposals for their car make
    if current_user.present? && current_user.dealership_id?
      @q.sorts = ['car_model_id asc', 'price desc'] if @q.sorts.empty?
      @proposals = Proposal.where("car_make_id = ?", current_user.dealership.car_make_id).near([current_user.latitude, current_user.longitude], 20)
      
      # Dealer sees all responses s/he made
      @responses = Response.where("user_id = ?", current_user.id)

      if params[:q].present?
        @proposals = @q.result.where("car_make_id = ?", current_user.dealership.car_make_id)
      end
    # Customer sees all proposals s/he made
    elsif current_user.present?
      @q.sorts = ['car_model_id asc', 'price asc'] if @q.sorts.empty?
      @proposals = Proposal.where("user_id = ?", current_user.id)

      # Customer sees all proposals s/he made
      @responses = Response.all
      
      # Proposals by customers' car models
      @proposals_nav = Proposal.where("user_id = ?", current_user.id).uniq { |p| p.car_model_id }

      if params[:q].present?
        # @proposals = @q.result.paginate(page: params[:page], per_page: $pagination_count).where("market_id = ? AND (products.expire_date IS null OR products.expire_date > ?)", @market.id, Time.now)
        @proposals = @q.result.where("user_id = ?", current_user.id)
      end
    end
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
  end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
  end

  # GET /proposals/1/edit
  def edit
  end

  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = current_user.proposals.build(proposal_params)
    @dealerships = Dealership.where("car_make_id = ?", @proposal.car_make_id)

    respond_to do |format|
      if @proposal.save
        # Deliver the signup email
        @dealerships.each do |dealership|
          @user = User.where("dealership_id = ?", dealership.id)
          NewProposalNotifier.send_new_proposal_notifier_email(@user).deliver
        end

        format.html { redirect_to @proposal, notice: 'Proposal was successfully created.' }
        format.json { render :show, status: :created, location: @proposal }
      else
        format.html { render :new }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    respond_to do |format|
      if @proposal.update(proposal_params)
        format.html { redirect_to @proposal, notice: 'Proposal was successfully updated.' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: 'Proposal was successfully destroyed.' }
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
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      params.require(:proposal).permit(:user_id, :purchase_option_id, :car_quality_id, :car_year_id, :car_make_id, :car_model_id, :car_trim_id, :car_color_id, :add_ons, :price, :over_under_price, :down_payment, :lease_length, :mileage_limit, :closing_cost, :financing, :apr, :deadline, :street, :city, :state, :zipcode, :country, :latitude, :longitude)
    end

    def review_params
      params.require(:review).permit(:buyer_id, :seller_id, :response_id, :proposal_id, :review, :rating, :created_at, :updated_at)
    end
end
