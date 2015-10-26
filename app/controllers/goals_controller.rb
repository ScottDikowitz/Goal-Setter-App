class GoalsController < ApplicationController

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

  private
  def goal_params
    self.params.require(:goal).permit(:body, :private)
  end
end
