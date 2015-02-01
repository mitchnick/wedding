module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type.to_sym
      when :success
        "alert-success"
      when :error, :danger
        "alert-danger"
      when :alert
        "alert-warning"
      when :notice, :info
        "alert-info"
      else
        flash_type.to_s
    end
  end

end
