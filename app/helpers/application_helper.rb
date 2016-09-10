module ApplicationHelper
  def resolve_alert_class_from_flash(type)
    case type
      when 'error'
        'alert-danger'
      when 'notice'
        'alert-success'
    end
  end
end
