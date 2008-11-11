# -*- coding: utf-8 -*-
module FindAtTableHelper
  def find_at_table_field(name, table_id, options ={})
    options ||={}
    dynamic = options[:dynamic] == false ? false : true
    frequency = options[:frequency] || 1
    cols = format_columns(options[:columns])
    #Remover para não aparecer como tag no text_field
    options.clear

    text_field = tag(:input,{ :type => "text", :name => name, :id => name }.update(options))
    
    if dynamic == true
      return_with(text_field, observer_ajax_field(name,frequency,table_id,cols))
    elsif dynamic == false
      return_with(text_field, press_key_table_field(name,table_id,cols))
    end
  end
  
  private
  def return_with(field, script)
    returning "\n" do |v|
      v << field
      v << script
    end
  end

  private
  def format_columns(cols)
    # Caso o objeto seja do tipo Array
    if cols.class == Array
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
    elsif cols.class == Fixnum
      returning "" do |v|
        v << "["
        v << cols.to_s
        v << "]"
      end

    # Caso o objeto seja do tipo Range
    elsif cols.class == Range
      format_columns(cols.to_a)
    else
      return "'all'"
    end
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

end
