class Account::DashboardController < AccountController
  
  def home
    @title = "Account Dashboard"
    # @accommondations = current_account.accommondations
    @total_stock = current_account.books.sum(:stock)
  end

end
