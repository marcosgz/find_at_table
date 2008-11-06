# -*- coding: utf-8 -*-
module FindAtTableHelper
  def find_at_table_field(name, table_id, options ={})
    options ||={}
    dynamic = options[:dynamic] == false ? false : true
    frequency = options[:frequency] || 1

    #Remover para não aparecer como tag no text_field
    options.delete(:frequency)
    options.delete(:dynamic)

    text_field = text_field_find_at_table({ "type" => "text", "name" => name, "id" => name }.update(options.stringify_keys))
    if dynamic == true
      returning "" do |v|
        v << text_field
        v << observer_ajax_field(name,frequency,table_id)
      end
    elsif dynamic == false
      returning "" do |v|
        v << text_field
        v << press_key_table_field(name,table_id)
      end
    end
  end

  private
  def text_field_find_at_table(options = nil)
    result = "<input #{tag_options_find_at_table(options) if options} />"
  end

  private
  def observer_ajax_field(field_id, frequency, table)
    script = "new Form.Element.Observer('#{field_id}',"
    script << " #{frequency}, "
    script << " function(element, value) { observerTableField('#{field_id}', '#{table}');})"
    javascript_tag(script)
  end

  private
  def press_key_table_field(field_id,table)
    script = "Event.observe('#{field_id}', 'keypress',"
    script << "function(event){ pressKeyTableField( "
    script << "event.keyCode ,'#{field_id}', '#{table}');});"
    javascript_tag(script)
  end

  private
  def tag_options_find_at_table(options)
    unless options.blank?
      attrs = options.map { |key, value| %(#{key}="#{value}") }
      " #{attrs.sort * ' '}" unless attrs.empty?
    end
  end
end
