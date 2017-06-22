module AlertsHelper
  def notice_message
    if flash.any?
      alerts = flash.map do |type, message|
        alert_div message, type
      end
      alerts.join("\n").html_safe
    end
  end

  def alert_div(message, type="info")
    return capture do
      content_tag :div, class: "alert alert-#{type} mt-1 mb-1" do
        message
      end
    end
  end

  def form_errors(obj)
    if obj.errors.any?
      obj.errors.full_messages.map do |message|
        alert_div message, "danger"
      end.join("\n").html_safe
    end
  end
end