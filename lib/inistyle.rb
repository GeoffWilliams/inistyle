# Ini-style parser - for things that look like inifiles but aren't really...
class Inistyle
  @@section_regexp = /\s*\[([^\]]+)\]\s*/
  @@data_regexp = /([^#]*)#?.*/   

  def initialize(filename,data=false)
    @filename = filename
    if data
      @data = data
    elsif File.exists?(filename)
      parse
    else
      data = {}
    end
  end

  def parse
    current_section = '__GLOBAL__'
    @data = {current_section => []}
    File.open(@filename, "r").each_line do |line|
      if line =~ @@section_regexp
        # new section found
        current_section = $1
      puts $1 
       @data[current_section] = []
      else
        # strip comments
        if line =~ @@data_regexp
          @data[current_section].push($1)
        else 
          puts "blank"
        end
      end
    end
  end

  def save
    File.write(@filename, @data.join("\n"))
  end

  # Public: Get the section Hash by name. If the section does not exist, then
  # it will be created.
  #
  # section - The section name as a String.
  #
  # Examples
  #
  #   inifile['global']
  #   #=> global section Hash
  #
  # Returns the Hash of parameter/value pairs for this section.
  def []( section )
    return nil if section.nil?
    @data[section.to_s]
  end

  # Public: Set the section to a hash of parameter/value pairs.
  #
  # section - The section name as a String.
  # value   - The Hash of parameter/value pairs.
  #
  # Examples
  #
  #   inifile['tenderloin'] = { 'gritty' => 'yes' }
  #   #=> { 'gritty' => 'yes' }
  #
  # Returns the value Hash.
  def []=( section, value )
    @data[section.to_s] = value
  end

  def sections
    @data.keys
  end

  def get_data
    @data
  end

  def set_data(data)
    @data = data
  end
end
