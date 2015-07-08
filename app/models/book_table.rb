class BookTable

  def populate_book_table
    library = Rails.root.join "app", "csv", "ironlibrary.csv"
    books = SmarterCSV.process(library)
    books.each do |book|
      Book.where({
      :title => book[:title],
      :author => book[:author],
      :keywords => book[:keywords],
      :campus => book[:campus],
      :avatar_file_name => book[:avatar_file_name]
      }).create!
    end
  end

end