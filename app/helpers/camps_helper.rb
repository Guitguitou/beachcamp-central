module CampsHelper
  def camp_status_color(camp)
    case camp.status
    when "published" then "success"
    when "draft"     then "neutral"
    when "full"      then "warning"
    when "cancelled" then "danger"
    else "neutral"
    end
  end
end
