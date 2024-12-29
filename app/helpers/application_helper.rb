module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-primary"
    when :danger  then "bg-error"
    else "bg-info"
    end
  end
end
