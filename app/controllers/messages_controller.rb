class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      if @message.sentby == 1
        @quest = Quest.where(id: @message.quest_id).first
        ProposalMailer.message_email(@quest).deliver_later
        redirect_to edit_quest_path(@message.quest_id)
      elsif @message.sentby == 2
        redirect_to proposal_quest_path(@message.quest_id)
      else
        redirect_to quests_path, notice: "Something went wrong"
      end
    else
      redirect_to edit_quest_path(@message.quest_id), notice: "Something went wrong"
    end
  end

  def edit
    @message = Message.find(params[:id])
    @messages = Message.all
  end

  def update
    @message = Message.find(params[:id])

    if @message.update_attributes(message_params)
      @duke = Duke.where(id: @message.duke_id).first
      client = Twilio::REST::Client.new(ENV["twilio_account_sid"], ENV["twilio_auth_token"])
      client.messages.create from: ENV["twilio_phone_number"], to:@duke.phonenumber, body:@message.body
      redirect_to edit_quest_path(@message.quest_id), notice: "Your message has been sent"
    else
      redirect_to edit_quest_path(@message.quest_id), notice: "Something went wrong"
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to quests_path, notice:"Your message has been deleted"
  end

  def message_params
    params.require(:message).permit(:title, :body, :squire_id, :duke_id, :sentby, :quest_id)
  end
end
