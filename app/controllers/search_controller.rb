class SearchController < ApplicationController

  # サーチ機能
  def search
    # プルダウンで選択された値が入るとこ
    @user_or_book = params[:option]
    @how_method = params[:method]
    @word = params[:word]

    #　プルダウンでuserかbookかで、参照するモデルを決める
    if @user_or_book == "user"
      @user = User.search(params[:word],@how_method)
    else
      @book = Book.search(params[:word],@how_method)
    end
    # searchメソッド カッコ内にテキストで入力された値と、選択された方の値を引数としてモデルに送っています。
  end

end
