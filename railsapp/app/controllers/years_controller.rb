class YearsController < ApplicationController
  def index
    @years = Year.where(target_year: 1)
    @all_years = Year.all
  end

  def update
    selected_year = params[:year]

    if selected_year.present?
      year_to_update = Year.find_by(year: selected_year.to_i)

      if year_to_update.present?
        Year.where.not(id: year_to_update.id).update_all(target_year: 0) # Update all other records to 0
        year_to_update.update!(target_year: 1) # Use update! for exception handling
        flash[:notice] = "対象年度が変更されました。"
      else
        flash[:alert] = "無効な年度が選択されました。"
      end
    else
      flash[:alert] = "年度を選択してください。"
    end

    redirect_to years_path
  end
end