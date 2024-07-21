class Account::SalesController < AccountController
  def sales_history
    @title = "Order History"
    # Fetch all books for the current account
    books = current_account.books

    # Fetch all SaleItems for these books
    # @sale_items = SaleItem.where(book_id: books.pluck(:id)).includes(:book, :sale).order(id: :desc)
    @sale_items = SaleItem.where(book_id: books.pluck(:id)).includes(:book, sale: :student).order(id: :desc)
    
    @pagy, @sales = pagy(@sale_items, items: 8)
  end
end