class BooksController < ApplicationController
    before_action :set_book, only: [:show, :update, :destroy]
    def json_response(object, status = :ok)
        render json: object, status: status
      end
  # GET /books
  def index
    if(book_params['owner']!=nil)
        then
        @books = Book.where(:owner => book_params['owner'])
    else
         @books = Book.all
    end
    json_response(@books)
  end

  # POST /books
  def create
        @book = Book.create!(book_params)
    # end
   json_response(@book, :created)  
  end

  # GET /books/:id
  def show
    json_response(@book)
  end

  # PUT /books/:id
  def update
    user= User.find_by(email: book_params['email'])
    if(user!=nil) then
        if(book_params['phone_number']!=nil) then
            user.update(phone_number: book_params['phone_number'])
        end
        user_id = user['_id']
        @book.update(reserved: book_params['reserved'], borrower: user_id )
        json_response(@book)
    else
        json_response("user does not exist")

    end
  end

  def user_books
    @books = Book.where(:owner =>params[:id])
    json_response(@books)

  end

  # DELETE /books/:id
  def destroy
    @book.destroy
    head :no_content
  end

  private

  def book_params
    # whitelist params
    params.permit(:title,:author,:owner,:days_to_borrow,:reserved,:borrower,:email,:phone_number)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
