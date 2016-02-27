class QuestsController < ApplicationController
  def index
    if current_user != nil
      @quests = Quest.where(squire_id: nil)
      @quests2 = Quest.where("squire_id = ? AND is_completed = ? AND is_proofsubmitted = ?", current_user.id, false, false)
      @quests3 = Quest.where("squire_id = ? AND is_completed = ? AND is_proofsubmitted = ?", current_user.id, false, true)
    elsif current_duke != nil
      @quests = Quest.where("duke_id = ? AND is_completed = ?", current_duke.id, false)
    end
    @message = Message.new
  end

  def show
    @quest = Quest.find(params[:id])
    if (current_user != nil && current_user.id == @quest.squire_id) || (current_user != nil && current_user.is_admin == true)
      @user = User.where(id: @quest.squire_id).first
      @duke = Duke.where(id: @quest.duke_id).first
      @items = Item.where(quest_id: @quest.id)
      @review = Review.new
      @reviews = Review.where(squire_id: @user.id)
    elsif current_duke != nil && current_duke.id == @quest.duke_id
      redirect_to proposal_quest_path(@quest)
    else
      redirect_to quests_path, alert: "error"
    end
  end

  def proposal
    @quest = Quest.find(params[:id])
    if current_duke.id == @quest.duke_id
      @user = User.where(id: @quest.squire_id).first
      @duke = Duke.where(id: @quest.duke_id).first
      @message = Message.new
      @messages = Message.where(quest_id: @quest.id)
      @items = Item.where(quest_id: @quest.id)
      @reviews = Review.where(squire_id: @quest.squire_id)
    else
      redirect_to quests_path, alert: "error"
    end
  end

  def new
    @source = params['url']
    if @source != nil
      email = params['user']
      @duke = Duke.where(email: email).first
      @quest = Quest.new(imagesrc: @source, duke_id: @duke.id, submissiontype: 1)
    else
      @quest = Quest.new
    end
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      redirect_to questthanks_quest_path(@quest)
    else
      redirect_to quests_path, notice: "Error"
    end
  end

  def edit
    if current_user != nil
      @quest = Quest.find(params[:id])
      if current_user.id == @quest.squire_id
        @quests = Quest.where(squire_id: nil)
        @quests2 = Quest.where("squire_id = ? AND is_completed = ? AND is_proofsubmitted = ?", current_user.id, false, false)
        @quests3 = Quest.where("squire_id = ? AND is_completed = ? AND is_proofsubmitted = ?", current_user.id, false, true)
        @items = Item.where(quest_id: @quest.id)
        @item = Item.new
        @reviews = Review.where(duke_id: @quest.duke_id)
        @duke = Duke.where(id: @quest.duke_id).first
        @messages = Message.where(quest_id: @quest.id)
        @message = Message.new
      else
        redirect_to quests_path, notice: "This isn't your quest"
      end
    else
      redirect_to quests_path, notice: "Please log in"
    end
  end

  def update
    @quest = Quest.find(params[:id])
    if @quest.update_attributes(quest_params)
      @quest.squirescut = @quest.pricetosquire * 0.04
      @quest.totalprice = (@quest.pricetosquire * 0.04) + @quest.pricetosquire
      @quest.save
      @quest.platformfees = (@quest.totalprice * 0.06) + 0.30
      @quest.save
      @quest.totalprice = @quest.totalprice + @quest.platformfees
      if @quest.save
        redirect_to edit_quest_path(@quest)
      else
        redirect_to quests_path, alert: "Something went wrong"
      end
    else
      redirect_to edit_quest_path(@quest)
    end
  end

  def revision
    @quest = Quest.find(params[:id])
    if @quest.update_attributes(quest_params)
      ProposalMailer.revised_proposal_email(@quest).deliver_later
      @quest.is_proposalsent = false
      @quest.save
      redirect_to quest_path(@quest), notice: "Revision Sent"
    else
      redirect_to quests_path, alert: "Something went wrong"
    end
  end

  def destroy
    @quest = Quest.find(params[:id])
    @quest.destroy
    redirect_to quests_path, notice:"Your quest has been deleted"
  end

  def completed
    @user = User.find(params[:id])
    @quests = Quest.where("squire_id = ? AND is_completed = ?", @user.id, true)
  end

  def completedduke
    @duke = Duke.find(params[:id])
    @quests = Quest.where("duke_id = ? AND is_completed = ?", @duke.id, true)
  end

  def stats
    @user = User.find(params[:id])
    @reviews = Review.where(squire_id: @user.id)
  end

  def questthanks
    @quest = Quest.find(params[:id])
  end

  def miniquestlist
    email = params['User']
    @duke = Duke.where(email: email).first
    @quests = Quest.where("duke_id = ? AND is_completed = ?", @duke.id, false)
  end

  def userquestionnaire
    @user = User.find(params[:id])
  end

  def moreinfo
    @quest = Quest.find(params[:id])
    render json: @quest
  end

  def moretexts
    @quests = Quest.where("squire_id IS ? AND typeofquest = ?", nil, 2)
  end

  def paybill
    @quest = Quest.find(params[:id])
    @duke = Duke.where(id: @quest.duke_id).first

    customer = Stripe::Customer.create(
      :email => @duke.email,
      :card  => params[:stripeToken]
    )

    @quest.stripetoken = customer.id
    @quest.is_proposalaccepted = true
    @duke.customertoken = customer.id
    @quest.save && @duke.save

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to quests_path
  end

  def paycharge
    @quest = Quest.find(params[:id])
    @duke = Duke.where(id: @quest.duke_id).first
    @quest.stripetoken = @duke.customertoken
    @quest.is_proposalaccepted = true
    if @quest.save
      redirect_to paybillreturn_quest_path, notice:"Payment Sent"
    else
      redirect_to paybillreturn_quest_path, notice:"Error"
    end
  end

  def releasepayment
    @quest = Quest.find(params[:id])
    @user = User.where(id: @quest.squire_id).first
    @user.completedquests = @user.completedquests + 1

    Stripe::Charge.create(
      :customer    => @quest.stripetoken,
      :amount      => (@quest.totalprice * 100).to_i,
      :description => 'Squire Stripe Customer',
      :currency    => 'usd',
      :application_fee => (@quest.platformfees * 100).to_i,
      :destination => @user.uid
    )

    @quest.is_completed = true
    if @quest.save && @user.save
      redirect_to quest_path(@quest)
    else
      redirect_to quest_path(@quest), notice:"There was a problem"
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to edit_quest_path(@quest)
  end

  def flagquest
    @quest = Quest.find(params[:id])
    @user = User.where(id: @quest.squire_id).first
    @user.numberofquestsflagged = @user.numberofquestsflagged + 1
    @user.activequests = @user.activequests - 1
    @quest.timesflagged = @quest.timesflagged + 1
    @quest.squire_id = nil
    @quest.is_accepted = false
    @quest.description = nil
    @quest.pricetosquire = nil
    @quest.totalprice = nil
    @quest.squirescut = nil
    @quest.platformfees = nil
    @quest.save
    @user.save
    if @quest.timesflagged > 2
      @quest.squire_id = 0
      @duke = Duke.where(id: @quest.duke_id).first
      @quest.duke_id = nil
      @duke.flagsreceived = @duke.flagsreceived + 1
      ProposalMailer.warning_email(@quest).deliver_later
      if @quest.save && @duke.save
        redirect_to quests_path
      else
        redirect_to quests_path, notice: "There was a problem"
      end
    else
      redirect_to quests_path
    end
  end

  def submitproof
    @quest = Quest.find(params[:id])
    @user = User.where(id: @quest.squire_id).first
    @user.activequests = @user.activequests - 1
    @quest.is_proofsubmitted = true
    if @quest.save && @user.save
      ProposalMailer.proof_email(@quest).deliver_later
      redirect_to edit_quest_path(@quest)
    else
      redirect_to edit_quest_path(@quest), notice: "Something went wrong"
    end
  end

  def submitproposal
    @quest = Quest.find(params[:id])
    @quest.is_proposalsent = true
    if @quest.save
      if @quest.submissiontype == 1
        ProposalMailer.proposal_email(@quest).deliver_later
      elsif @quest.submissiontype == 2
        # the duke should receive a notification from the app that a proposal is ready
      end
      redirect_to edit_quest_path(@quest)
    else
      redirect_to edit_quest_path(@quest), alert: "Something went wrong"
    end
  end

  def dotraining
    @user = User.find(params[:id])
    @user.completedbasictraining = true
    @user.save
    redirect_to quests_path
  end

  def dointerview
    @user = User.find(params[:id])
    @user.completedinterview = true
    @user.save
    redirect_to quests_path
  end

  def getmeaquest
    @user = User.find(params[:id])
    if (@user.completedregistration == true)
      if (@user.activequests < 3)
        if @quest = Quest.where(squire_id: nil).first
          @quest.squire_id = @user.id
          @quest.is_accepted = true
          @user.activequests = @user.activequests + 1
          if (@quest.save && @user.save)
            redirect_to edit_quest_path(@quest)
          else
            redirect_to quests_path, notice:"There was a problem"
          end
        else
          redirect_to quests_path, notice:"No available quests"
        end
      else
        redirect_to quests_path, notice:"You may only have 3 active quests at a time"
      end
    else
      redirect_to quests_path, notice:"You need to complete the registration list before you can take on quests"
    end
  end

  def quest_params
    params.require(:quest).permit(:imagesrc, :submissiontype, :squire_id, :duke_id,
    :is_accepted, :is_proposalsent, :is_proposalaccepted, :is_proofsubmitted,
    :is_completed, :timesflagged, :title, :description, :pricetosquire, :totalprice, :squirescut,
    :platformfees, :proof1, :proof2, :proof3, :revision)
  end
end
