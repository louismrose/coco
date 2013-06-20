class TranslatesGousToHutn
  def initialize(symbols, variables)
    @symbols, @variables = symbols, variables
    @identifiers = {}
    @invalid_references = []
  end
  
  def run      
    symbols_with_identifiers_and_references.join(' ')
  end
  
private

  def quote(s)
    '"' + s + '"'
  end

  def symbols_with_identifiers_and_references
    identifiable_symbols = @symbols.map { |s| make_identifiable(s) }
    
    referenced_symbols = identifiable_symbols.zip(@variables).map do |sv|
      make_reference(sv[0], sv[1])
    end
    
    remove_invalid_reference_symbols_from(referenced_symbols)
  end
  
  # First pass -- replace identifier placeholders (e.g. Area%)
  # with type-unique identifier (e.g. Area42)
  
  def make_identifiable(symbol)
    if symbol.end_with?("%")
      type = symbol.chomp("%")
      quote(type + new_identifier_for(type).to_s)
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
      
      if @identifiers[type]
        quote(type + convert_to_reference(symbol, type).to_s)
      else
        nil
      end
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
  
  
  # Third pass -- removes invalid references, which are references to
  # to types for which there are no instances. The second pass inserts
  # nils into the symbols array for these invalid references. The third
  # pass finds occurrences of [..., X, nil, ...] in the symbols array
  # and replaces them with [..., "null", ...] to convert the invalid
  # reference into a valid null reference in HUTN. Note that we must
  # remove X as null references in HUTN are not preceded by a type
  # declaration. For example:
  #
  #   children: Area "Area1"  <-- valid HUTN
  #   children: null          <-- valid HUTN
  #   children: Area null     <-- invalid HUTN
  
  def remove_invalid_reference_symbols_from(symbols)
    valid_referenced_symbols = []
    symbols.each do |s|
      if s
        valid_referenced_symbols << s
      else
        valid_referenced_symbols.pop
        valid_referenced_symbols << "null"
      end
    end
    valid_referenced_symbols
  end
end