module ApplicationHelper
	# 取消 turbolinks 緩存，建議用在有 js 套件的頁面
	# TODO
  def no_cache
    content_for :custom_head do
      content_tag :meta, "", name: "turbolinks-cache-control", content: "no-cache"
    end
  end

  def ajax_modal(obj, type, args)
    args[:namespace] ||= nil
    data_attrs = "data-toggle=modal" +
      " data-target=#edit#{obj.class.model_name}" +
      if args[:namespace]
        " data-url=#{send("#{type}_#{args[:namespace]}_#{obj.class.model_name.singular}_path", obj)}".html_safe
      else
        " data-url=#{send("#{type}_#{obj.class.model_name.singular}_path", obj)}".html_safe
      end
    if obj.persisted?
      data_attrs += " data-model-id=#{obj.id}"
    end
    return data_attrs
  end

  def count_row(text)
    text.nil? ? 4 : (text.length / 14.0) + 2
  end
end
