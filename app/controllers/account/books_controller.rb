class Account::BooksController < AccountController
  def book 
    @title = "Books"
    @pagy, @books = pagy(Book.includes(:account).order(id: :desc), items: 8)
  end

  def create
    title = params[:title]
    amount = params[:amount]
    book_type = params[:book_type]

    @book = Book.new(
      title: title,
      amount: amount,
      account: current_account,  # Assign the model instance, not the ID
      book_type: book_type
    )

    if @book.save
      redirect_to account_books_path, notice: "Book added successfully!"
    else
      redirect_to account_books_path, alert: "Oops, something went wrong. Please try again"
    end
  end
end