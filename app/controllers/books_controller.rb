class BooksController < ApplicationController

  def index
    @available_books = Book.where(available: true)
    @reserved_books = Book.where(available: false).includes(:users)
  end

  def show
    @book = Book.find params[:id]
  end

  def new
    if current_user.admin?
      @book = Book.new
    else
      render :index, notice: "Insufficient Admin Privileges"
    end
  end

  def create
    if current_user.admin?
      @book = Book.new(book_params)
      if @book.save
        redirect_to @book, notice: "Book record created"
      else
        render :new, notice: "Record failed to be created"
      end
    else
    render :index
    end
  end

  def edit
    @book = Book.find params[:id]
  end

  def update
    if current_user.admin?
      @book = Book.find params[:id]
      @book.update(book_params)

      redirect_to @book, notice: "Record updated"
    else
      flash[:warning] = "Failed to update record"
      render :edit
    end
  end

  def destroy
    if current_user.admin?
      @book = Book.find params[:id]
      @book.delete

      redirect_to books_path, notice: "Record has been deleted"
    else
      redirect_to books_path, notice: "Insufficient Admin Privileges"
    end
  end

  def checkout
    @book = Book.find params[:book_id]
    @book.update!(available: false)

    t = Time.now + 2.weeks
    t = t.at_end_of_day

    checkout_log = current_user.checkout_histories.create!(book_id: @book.id, due_date: t)
    if checkout_log.save
      redirect_to @book, notice: "You have checked out #{@book.title}"
    else
      render :index, notice: "#{@book.title} is unable to be checked out"
    end
  end

  def checkin
    @book = Book.find params[:book_id]
    @book.update!(available: true)

    returned_book_log = CheckoutHistory.where(book_id: params[:book_id]).last
    returned_book_log.update!(returned: true)
    if returned_book_log.save
      redirect_to @book, notice: "You have returned #{@book.title}"
    else
      redirect_to @book, notice: "An error occured while returning #{@book.title}"
    end
  end

private

  def book_params
    params.require(:book).permit(:title, :author, :campus)
  end

end