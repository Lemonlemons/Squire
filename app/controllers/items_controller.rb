class ItemsController < ApplicationController
  def create
    @item = Item.new(item_params)

    if @item.save
      @quest = Quest.where(id: @item.quest_id).first
      @quest.pricetosquire = @quest.pricetosquire + @item.price
      @quest.save
      @quest.squirescut = @quest.pricetosquire * 0.04
      @quest.totalprice = (@quest.pricetosquire * 0.04) + @quest.pricetosquire
      @quest.save
      @quest.platformfees = (@quest.totalprice * 0.06) + 0.30
      @quest.save
      @quest.totalprice = @quest.totalprice + @quest.platformfees
      @quest.save
      redirect_to edit_quest_path(@item.quest_id)
    else
      redirect_to edit_quest_path(@item.quest_id), notice: "Something went wrong"
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(item_params)
      redirect_to edit_quest_path(@item.quest_id)
    else
      redirect_to edit_quest_path(@item.quest_id), notice: "Something went wrong"
    end
  end

  def item_params
    params.require(:item).permit(:name, :price, :quantity, :brand, :size, :daystoship, :squire_id, :duke_id, :quest_id, :proofimg)
  end
end
