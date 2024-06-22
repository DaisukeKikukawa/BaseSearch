module Admin::TournamentsHelper
  def form_url
    if params[:id].present?
      admin_tournament_path(id: params[:id])
    else
      admin_tournaments_path
    end
  end

  def form_method
    if params[:id].present?
      :patch
    else
      :post
    end
  end
end
