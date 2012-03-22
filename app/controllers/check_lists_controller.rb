class CheckListsController < ApplicationController
  def index
    @checklists = CheckList.all
  end
  
  def show
    @checklist = CheckList.find(params[:id])
    @checklists = CheckList.by_name.select { |check_list| check_list.check_items.count > 0 }
    @checkitems = CheckItem.by_item_order.find_all_by_check_list_id(params[:id])
    @checkitemtemplatescount = CheckItemTemplate.count
  end

  def new
    @check_list = CheckList.new
  end

  def edit
  end

  def destroy
  end
  
  def create
    @check_list = CheckList.new(params[:check_list])
    if @check_list.save
      redirect_to(check_list_path(@check_list.id), :notice => "List Saved")
    else
      flash[:error]
    end
  end
  
  def clone
    checks_from_clone = CheckItem.find_all_by_check_list_id(params[:clone_check_list_id])
    checks_from_clone.each do |check_item|
      CheckItem.create({
        name: check_item.name,
        area: check_item.area,
        check_list_id: params[:check_list_id],
        item_order: check_item.item_order,
      })
    end
    
    redirect_to(check_list_path(params[:check_list_id]))
  end
end
