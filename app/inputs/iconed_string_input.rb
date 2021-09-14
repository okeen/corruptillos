class IconedStringInput < SimpleForm::Inputs::StringInput

  def input_html_classes
    super.push('form-control string')
  end

  def input(_wrapper_options = {})
    template.content_tag :div, class: "input-group mb3" do
      if input_options[:icon_position] == :left
        "#{icon_span} #{input_control}".html_safe
      else
        "#{input_control} #{icon_span}".html_safe
      end
    end
  end

  protected

  def label_target
    attribute_name
  end

  def icon_span
    content = ''
    if input_options[:icon]
      content = template.icon(input_options[:icon] || 'email')
    else
      content = input_options[:text_icon] || '€'
    end
    template.content_tag :span, content, class: "input-group-text"
  end

  def input_control
    @builder.text_field(attribute_name, input_html_options)
  end
end