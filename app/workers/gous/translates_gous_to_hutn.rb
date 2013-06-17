class TranslatesGousToHutn
  def initialize(symbols, variables)
    @symbols_and_variables = symbols.zip(variables)
    @identifiers = {}
  end
  
  def run      
    symbols_with_identifiers_and_references.join(' ')
  end
  
private 
  def symbols_with_identifiers_and_references
    @symbols_and_variables.
      map { |sv| [make_identifiable(sv[0]), sv[1]] }.
      map { |sv| make_reference(sv[0], sv[1]) }
  end
  
  def make_identifiable(symbol)
    if symbol.end_with?("%")
      type = symbol.chomp("%")
      type + new_identifier_for(type).to_s
    else
      symbol
    end
  end
  
  def new_identifier_for(type)
    @identifiers[type] ||= 0
    id = @identifiers[type]
    @identifiers[type] += 1
    id
  end
  
  
  def make_reference(symbol, variable)
    if variable and variable.start_with?("[") and variable.end_with?("%]")
      type = variable[1, variable.length - 3]
      type + convert_to_reference(symbol, type).to_s
    else
      symbol
    end
  end
  
  def convert_to_reference(n, type)
    largest_id_for_type = @identifiers[type]
    largest_possible_value_for_n = 65535
    ( n.to_f * largest_id_for_type.to_f / largest_possible_value_for_n.to_f ).floor
  end
end