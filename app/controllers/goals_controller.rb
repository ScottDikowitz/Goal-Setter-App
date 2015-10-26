class GoalsController < ApplicationController
  before_action :block_private_goal_page, only: [:show]
  def create
    goal = Goal.new(goal_params)
    goal.user_id = current_user.id
    if goal.save
      redirect_to user_url(goal.user_id)
    else
      flash.now[:error] = goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end
  def show
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:error] = @goal.errors.full_messages
      redirect_to user_url(@goal.user_id)
    end
  end

  private
  def goal_params
    self.params.require(:goal).permit(:body, :private)
  end
end
