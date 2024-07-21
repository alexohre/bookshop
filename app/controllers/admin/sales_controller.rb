class Admin::SalesController < AdminController
  before_action :set_student, only: [:sales, :create, :show]
  def home
    @title = "Sales Home"
    @q = Student.ransack(search_params)
    if params[:q].present?
      @students = @q.result(distinct: true)
      if @students.empty?
        flash.now[:alert]= "No student found for search query: #{params[:q]}"
      end
    else
      @students = Student.none
    end
  end

  def sales 
    @title = "Sales"
    # @student = Student.find_by(mat_no: params[:mat_no])

    @pending_orders = session[:pending_orders] || []
    # @total_books = @pending_orders.size
    # @total_amount = @pending_orders.sum { |order| order[:amount] }

    if @student.nil?
      redirect_to admin_bookshop_path, alert: "Student not found"
    else
      @book_search = Book.ransack(book_search_params)
      if params[:q].present?
        @books = @book_search.result(distinct: true)
        if @books.empty?
          flash.now[:alert]= "No book found! for search query: #{params[:q]}"
        end
      else
        @books = Book.none
      end
    end
  end

  def create
    @pending_orders = session[:pending_orders] || []

    if @pending_orders.empty?
      flash[:notice] = "No pending orders to create a sale."
      redirect_to root_path and return
    end

    total_amount = @pending_orders.sum { |order| order.transform_keys(&:to_sym)[:amount].to_f }
    cashier_name = "#{current_user.first_name} #{current_user.last_name}"

    @sale = Sale.new(total_amount: total_amount, student: @student, cashier_name: cashier_name)

    Sale.transaction do
      if @sale.save
        @pending_orders.each do |order|
          order.transform_keys!(&:to_sym)
          SaleItem.create!(
            sale: @sale,
            book_id: order[:id],
            title: order[:title],
            amount: order[:amount].to_f
          )
        end

        # Clear the pending orders
        session[:pending_orders] = []

        flash[:notice] = "Sale created successfully."
        redirect_to admin_sale_path(@sale)
      else
        flash[:alert] = "Failed to create sale."
        redirect_to request.referrer
      end
    rescue => e
      flash[:alert] = "An error occurred: #{e.message}"
      redirect_to request.referrer
    end
  end

  def show
    @sale = Sale.find(params[:id])

  end

  def sales_history
    @title = "Order History"
    @order_search = Sale.ransack(orders_search_params)
     if params[:q].present?
      @pagy, @sales = pagy(@order_search.result(distinct: true))
      
      if @sales.empty?
        flash.now[:alert] = "No order found for search query: #{params[:q]}"
      end
    else
      @pagy, @sales = pagy(@order_search.result(distinct: true).order(id: :desc), items: 8)
    end

  end

  def add_to_pending
    book = Book.find(params[:book_id])
    @pending_orders = session[:pending_orders] || []

    @pending_orders << {
      id: book.id,
      title: book.title,
      book_type: book.book_type,
      course_code: book.course_code,
      amount: book.amount.to_f
    }

    session[:pending_orders] = @pending_orders

    respond_to do |format|
      format.html { redirect_to request.referer || root_path }
      format.json { render json: { status: 'success', message: 'Book added to pending list' }, status: :ok }
    end
  end

  def remove_from_pending
    book_id = params[:book_id].to_i
    # puts "Book ID: #{book_id}"

    @pending_orders = session[:pending_orders] || []
    # puts "Pending Orders Before: #{@pending_orders.inspect}"

    @pending_orders.each do |order|
      # puts "Order: #{order.inspect}"
      order.transform_keys!(&:to_sym)  # Transform keys to symbols in-place.
      # puts "Order ID Type: #{order[:id].class}, Book ID Type: #{book_id.class}"
    end

    if @pending_orders.empty?
      flash.now[:notice]= "No pending orders to remove."
    else
      @pending_orders.delete_if { |order| order[:id].to_i == book_id }
      session[:pending_orders] = @pending_orders
      # puts "Pending Orders After: #{@pending_orders.inspect}"
    end

    respond_to do |format|
      
      format.html do
        redirect_to request.referer || root_path
      end
      format.json { render json: { status: 'success', message: 'Book removed from pending list' }, status: :ok }
    end
  end


  def clear
    session.delete(:pending_orders) # Correct way to delete a session key
    redirect_to admin_bookshop_path
  end


  private

  def set_student
    @student = Student.find_by(mat_no: params[:mat_no]) # Assuming mat_no is passed in params
  end

  def search_params
    search_query = if params[:q].present?
      query = params[:q]
      { combinator: 'or', mat_no_or_first_name_or_last_name_cont: query }
    else
      params[:q]
    end

    search_query || {} # Ensure it returns a hash
  end

  def book_search_params
    search_query = if params[:q].present?
      query = params[:q]
      { combinator: 'or', title_or_course_code_cont: query }
    else
      params[:q]
    end

    search_query || {} # Ensure it returns a hash
  end

  def orders_search_params
    if params[:q].present?
      { student_mat_no_cont: params[:q] }
    else
      {}
    end
  end

end
