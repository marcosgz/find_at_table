# -*- coding: utf-8 -*-
module FindAtTableHelper
  def find_at_table_field(name, table_id, options ={})
    options ||={}
    dynamic = options[:dynamic] == false ? false : true
    frequency = options[:frequency] || 1
    cols = format_columns(options[:columns])
    #Remover para não aparecer como tag no text_field
    options.delete(:frequency)
    options.delete(:dynamic)
    options.delete(:columns)

    text_field = text_field_find_at_table({ "type" => "text", "name" => name, "id" => name }.update(options.stringify_keys))
    if dynamic == true
      returning "" do |v|
        v << text_field
        v << observer_ajax_field(name,frequency,table_id,cols)
      end
    elsif dynamic == false
      returning "" do |v|
        v << text_field
        v << press_key_table_field(name,table_id,cols)
      end
    end
  end

  private
  def format_columns(cols)
    # Caso o objeto seja do tipo Array
    if cols.type == Array
      #Remove caso o valor do array não estar dentro do padrão
      cols.delete_if{|x| x.type != Fixnum}
      if cols.size > 0
        returning "" do |v|
          v << "["
          v << cols.join(",").to_s
          v << "]"
        end
      else
        return "'all'"
      end

    # Caso o objeto seja do tipo Fixnum
    elsif cols.type == Fixnum
      returning "" do |v|
        v << "["
        v << cols.to_s
        v << "]"
      end

    # Caso o objeto seja do tipo Range
    elsif cols.type == Range
      format_columns(cols.to_a)
    else
      return "'all'"
    end
  end

  private
  def text_field_find_at_table(options = nil)
    result = "<input #{tag_options_find_at_table(options) if options} />"
  end

  private
  def observer_ajax_field(field_id, frequency, table,cols)
    script = "new Form.Element.Observer('#{field_id}',"
    script << " #{frequency}, "
    script << " function(element, value) { observerTableField('#{field_id}', '#{table}', #{cols} );})"
    javascript_tag(script)
  end

  private
  def press_key_table_field(field_id,table,cols)
    script = "Event.observe('#{field_id}', 'keypress',"
    script << "function(event){ pressKeyTableField( "
    script << "event.keyCode ,'#{field_id}', '#{table}', #{cols});});"
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
