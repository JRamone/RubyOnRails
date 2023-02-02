class MessagesController < ApplicationController
  before_action :ensure_login, only: %i[index show edit update destroy]
  before_action :set_messages, only: %i[index show edit update destroy]

  def index
    @users = User.all.select { |u| u.id != current_user.id }
  end


  def show
  end

  def new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: "Message sent" }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def ensure_login
    if not current_user
    respond_to do |f|
     f.html { redirect_to root_path, notice: "Please login to view your messages." }
    end
  end

  def set_messages
    @messages = Message.where(receiver_id: current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.permit(:message_field,:title,:receiver_id)
  end
end
end
