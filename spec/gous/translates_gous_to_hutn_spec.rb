require "lib/gous/translates_gous_to_hutn.rb"

describe TranslatesGousToHutn, "#run" do

  it "emits symbols as-is when they do not represent references" do
    symbols = %w(Family { name: "Smiths" })
    variables = []
    translated = translate(symbols, variables)
     
    translated.should eq(symbols.join(' '))
  end
  
  it "replaces named objects with identifiers" do
    symbols = %w(identifiable: Area% Area% Event% Area% Event%)
    variables = []
    
    translated = translate(symbols, variables)
    translated.should eq(%w(identifiable: "Area0" "Area1" "Event0" "Area2" "Event1").join(' '))
  end
  
  it "replaces a reference with a valid identifiers according to partitioning" do
    symbols = %w(refs: 0 65534 65534 defs: Area% Area% Event%)
    variables = %w(Dummy [Area%] [Area%] [Event%] Dummy Dummy Dummy Dummy)
    
    translated = translate(symbols, variables)
    translated.should eq(%w(refs: "Area0" "Area1" "Event0" defs: "Area0" "Area1" "Event0").join(' '))
  end
  
  it "replaces a reference and its type with null when there are no potential targets" do
    symbols = %w(Area 0 Area 65534)
    variables = %w([Event] [Area%] [Event] [Area%])
    
    translated = translate(symbols, variables)
    translated.should eq(%w(null null).join(' '))
  end
  
private

  def translate(symbols, variables)
    TranslatesGousToHutn.new(symbols, variables).run
  end
  
end