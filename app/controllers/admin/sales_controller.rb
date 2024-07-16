class Admin::SalesController < AdminController
  def home
    @title = "Sales Home"
  end

  def sales 
    @title = "Sales"
  end

end
