class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]
  before_action :set_guest, only: [:show, :edit, :new, :create, :update, :destroy]
  layout "admin"

  respond_to :html

  def index
    @rsvps = Rsvp.all
    respond_with(@rsvps)
  end

  def show
    respond_with(@rsvp)
  end

  def new
    @rsvp = @guest.build_rsvp
    respond_with(@rsvp)
  end

  def edit
  end

  def create
    @rsvp = @guest.build_rsvp(rsvp_params)
    respond_to do |format|
      if @rsvp.save
        if admin_signed_in?
          format.html { redirect_to [@guest, @rsvp], notice: 'RSVP was successfully created.' }
          format.json { render :show, status: :created, location: [@guest, @rsvp] }
        else # guest is submitting RSVP
          NotificationsMailer.rsvp_created(@rsvp.id).deliver
          format.html { redirect_to root_path, notice: @rsvp.create_message_on_submit }
          format.json { render :show, status: :created, location: [@guest, @rsvp] }
        end
      else
        if admin_signed_in?
          format.html { render :new }
          format.json { render json: @rsvp.errors, status: :unprocessable_entity }
        else
          @rsvp_code = @rsvp.custom_rsvp_code
          flash[:error] = "Oops! Please verify the information below."
          format.html { render :new, layout: "form_only" }
          format.json { render :show, status: :created, location: [@guest, @rsvp] }
        end
      end
    end
  end

  def update
    flash[:notice] = @rsvp.update_message_on_submit if @rsvp.update(rsvp_params)
    if admin_signed_in?
      respond_with([@rsvp.guest, @rsvp])
    else
      NotificationsMailer.rsvp_updated(@rsvp.id).deliver
      redirect_to root_path
    end
  end

  def destroy
    @rsvp.destroy
    redirect_to rsvps_path
  end

  def enter_rsvp_code
    @rsvp_code = params[:rsvp][:custom_rsvp_code].downcase if params[:rsvp] && params[:rsvp][:custom_rsvp_code]

    respond_to do |format|
      if @rsvp_code.present? && @guest = Guest.find_by_custom_rsvp_code(@rsvp_code)
        if @guest.rsvp.present?
          @rsvp = @guest.rsvp
          format.html {render :edit, layout: "form_only"}
        else
          @rsvp = @guest.build_rsvp
          format.html {render :new, layout: "form_only"}
        end
      else
        flash[:notice] = "Hmm, we couldn't find your code. Please try entering your RSVP code again." if @rsvp_code.present?
        format.html {render layout: "form_only"}
      end
    end
  end

  private
    def set_rsvp
      @rsvp = Rsvp.find(params[:id])
    end

    def set_guest
      @guest = Guest.find(params[:guest_id])
    end

    def rsvp_params
      params.require(:guest_id)
      params.require(:rsvp).permit(:confirmed_number, :email, :message)
    end
end
