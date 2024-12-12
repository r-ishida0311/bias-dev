class DepartmentsController < ApplicationController
  def index
    @years = Year.all
    @selected_year = params[:year] 


# get => data_upload
    upload_file = params[:upload_file]
  end

  def create
    if params[:upload_file].present?
      upload_file = params[:upload_file].tempfile

      # ファイルの内容によってはEncodingErrorが出ますので適宜調整してください
      CSV.foreach(upload_file.path, headers: true, encoding: 'cp932') do |row|
        
        # recruiting_idがあった場合はレコードを呼び出す、ない場合は新しく作成
        departments = Department.new
        departments.attributes = convert_csv_to_hash(row)
        departments.save
      end
      redirect_to root_path
    end
  end


  def import
    # fileはtmpに自動で一時保存される
    Department.import(params[:file])
    redirect_to departments_url
  end

  private

  # csvの欲しいデータがある列とDBのカラムを指定してデータを入れます。
  def convert_csv_to_hash(row)
    params = {
      dep_name: row['部署名'],
      year_id: row['対象年度'],
    }
    return params
  end

end
