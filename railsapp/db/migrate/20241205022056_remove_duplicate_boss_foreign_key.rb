class RemoveDuplicateBossForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :bosses, :applies # 1つ目の外部キー削除
    begin
        remove_foreign_key :bosses, :applies  # 2つ目の外部キー削除。存在しない場合は例外が発生
    rescue ActiveRecord::InvalidForeignKey
        # 2つ目の外部キーが存在しない場合の処理。特に何もする必要がなければ空で構いません。
        puts "Second foreign key not found. Skipping."
    end

  end
end
