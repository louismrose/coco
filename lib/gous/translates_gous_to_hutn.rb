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
  
  # First pass -- replace identifier placeholders (e.g. Area%)
  # with type-unique identifier (e.g. Area42)
  
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
  
  # Second pass -- now that we know how many identifiable objects 
  # exist for each type, replace reference placeholders (e.g. [Area%])
  # with a valid name of an object with the right type (e.g., Area42)
  # Note that the symbol contains an index into a partition in the range
  # [0..65534] and that the variable denotes the type of object to which
  # this integer should refer.
  
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
    normalize_for_set_of_bins(n, largest_id_for_type)
  end
  
  def normalize_for_set_of_bins(n, bin_size)
    largest_possible_value_for_n = 65535
    ( n.to_f * bin_size.to_f / largest_possible_value_for_n.to_f ).floor
  end
end