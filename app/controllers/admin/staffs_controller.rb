class Admin::StaffsController < AdminController
  def index 
    @title = "Admin staffs"
    @q = User.ransack(search_params)
    @pagy, @staffs = pagy(@q.result(distinct: true).order(id: :desc), items: 8)
  end

  def create 
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    role = params[:role]

    User.create!(
      first_name: first_name,
      last_name: last_name,
      email: email,
      role: role,
      password: "password"
    )

    redirect_to admin_staffs_path, notice: "Staff added successfully!"
  end

  private

  def search_params
    search_query = if params[:q].present?
      query = params[:q]
      { combinator: 'or', email_or_first_name_or_last_name_cont: query }
    else
      params[:q]
    end

    search_query || {} # Ensure it returns a hash
  end
end