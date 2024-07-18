class Account::DashboardController < AccountController
  
  def home
    @title = "Account Dashboard"
    # @accommondations = current_account.accommondations
  end

end
