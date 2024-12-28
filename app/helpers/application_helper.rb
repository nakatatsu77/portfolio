module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-primary"
    when :danger  then "bg-secondary"
    else "bg-info"
    end
  end
end
