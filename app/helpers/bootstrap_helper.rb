module BootstrapHelper
  def render_flash
    flash_class = { notice: "alert-success", alert: "alert-warning", error: "alert-danger" }

    flash.map do |name, msg|
      next if msg.empty?

      content_tag :div, id: 'error_messages', class: "flash alert #{flash_class[name.to_sym]} fade in", 'data-alert' => 'true' do
        content = []
        content << link_to('&times;'.html_safe, '#', class: 'close', :"data-dismiss" => 'alert')
        content << msg
        content.join('').html_safe
      end
    end.join('').html_safe
  end

  # Provides a link styled as a button.
  #
  # @param [String] anchor The anchor for the link
  # @param [String] URL The address to link to
  # @param [Hash] options The options for link_to
  # @return [String] the link with the needed styles
  def button_link_to anchor, url, options = {}
    klazz = options.delete(:class)

    if klazz.present?
      options[:class] = "btn #{klazz}"
    else
      options[:class] = "btn"
    end

    link_to anchor, url, options
  end

  # Draws an icon which shows a popover on hover
  # @param [String] content The content of the popover
  # @param [String] title The title on the popover
  def popover_info_icon(content, title, options={}, icon = 'info-sign')
    options[:placement]||= "right"
    formated_content = content_tag :div, simple_format(content), class: 'left'
    formated_title = content_tag :div, title, class: 'left'
    klazz = "fal fa-#{icon} fa-lg"
    klazz << " #{options[:class]}" if options[:class].present?

    icon = content_tag :i, nil,
                       'class' => klazz,
                       'data-content' => content,
                       'data-original-title' => title,
                       'data-placement' => options[:placement],
                       'data-trigger' => options[:trigger] || "click",
                       'rel' => 'popover'
    icon.html_safe
  end

  def content_with_icon(content, klazz, color = nil, options = {})
    (icon(klazz, color, options) + " #{content}".html_safe)
  end

  def icon(klazz, colour = nil, options = {})
    icon_class = "fal fa-#{klazz}"
    content_tag :i, nil, options.merge(class: "#{icon_class} #{options[:class]}")
  end

  # Generates a table for a collection of active record objects showing a list
  # of its attributes. The last column in the table will have a set of buttons
  # (edit, destroy and show). Pagination is at the top and at the bottom of the
  # table.
  #
  # @param [Array] collection A collection of ActiveRecord objects.
  # @param [Array] attr_list A list of the attributes to be shown.
  # @return [HTML] A table to show the paginated collection of objects.
  def table_for(collection, options = {}, *attr_list)
    actions = false
    classes = options[:classes] || ""

    model_class_name = options[:model_name] || collection.name
    table_id = options[:id] || model_class_name.tableize
    table_klazz = model_class_name.constantize
    table_headers = []

    attr_list.flatten.each do |attr_name|
      if attr_name.class == Hash && !attr_name[:actions].nil?
        actions = attr_name[:actions]
      else
        header_content = table_klazz.human_attribute_name(attr_name)
        header = content_tag(:th, header_content)
        table_headers << header
      end
    end

    if actions
      table_headers << content_tag(:th, t('actions'), class: 'table_actions')
    end

    thead = content_tag :thead, content_tag(:tr, table_headers.join(" ").html_safe)

    table_content = ""
    if options[:partial].present?
      table_content = render partial: options[:partial], collection: collection
    else
      table_content = render collection
    end
    tbody = content_tag :tbody, table_content

    table = content_tag(:table, "#{thead} #{tbody}".html_safe, id: table_id, class: "table table-hover #{classes}")
    table.html_safe
  end
end