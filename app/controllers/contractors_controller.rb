class ContractorsController < ApplicationController

  def index
    @contractors = User.where(q_contractor: true)
  end

  def show
    @contractor = User.find_by_slug(params[:slug])
    return redirect_to contractors_path , alert: '' if @contractor.blank?
  end
end
