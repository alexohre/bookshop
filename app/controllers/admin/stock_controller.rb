class Admin::StockController < AdminController
  def index
    @title = "Stocks"
    @stock_search = Book.ransack(book_search_params)
    puts "Search Params: #{book_search_params.inspect}"
    if params[:q].present?
      @pagy, @books = pagy(@stock_search.result(distinct: true).includes(:account))

      puts @stock_search.result(distinct: true).to_sql

      if @books.empty?
        flash.now[:alert] = "No Stock found for search query: #{params[:q]}"
      end
    else
      @pagy, @books = pagy(@stock_search.result(distinct: true).includes(:account).order(id: :desc), items: 8)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.restock(stock_params[:stock].to_i)
      redirect_to stock_index_path, notice: "Stock updated successfully."
    else
      render :edit
    end
  end

  private

  def stock_params
    params.require(:book).permit(:stock)
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
end
