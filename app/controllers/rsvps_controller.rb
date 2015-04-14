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
        format.html { redirect_to [@guest, @rsvp], notice: 'RSVP was successfully submitted.' }
        format.json { render :show, status: :created, location: [@guest, @rsvp] }
      else
        format.html { render :new }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    flash[:notice] = 'Rsvp was successfully updated.' if @rsvp.update(rsvp_params)
    if admin_signed_in?
      respond_with(@rsvp)
    else
      redirect_to root_path
    end
  end

  def destroy
    @rsvp.destroy
    respond_with(@rsvp)
  end

  def enter_rsvp_code
    @rsvp_code = params[:rsvp][:custom_rsvp_code].downcase if params[:rsvp] && params[:rsvp][:custom_rsvp_code]

    respond_to do |format|
      if @rsvp_code.present? && @guest = Guest.find_by_custom_rsvp_code(@rsvp_code)
        puts "GUEST FOUND!!!!!"
        if @guest.rsvp.present?
          @rsvp = @guest.rsvp
          format.html {render :edit, layout: "form_only"}
        else
          @rsvp = @guest.build_rsvp
          format.html {render :new, layout: "form_only"}
        end
      else
        puts "********* No GUEST FOUND *********"
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
