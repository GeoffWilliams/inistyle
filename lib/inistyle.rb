# Copyright 2016 Geoff Williams for Puppet Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
require "inistyle/version"

#module IniStyle
  class IniStyle
    @@section_regexp = /\s*\[([^\]]+)\]\s*/
    @@data_regexp = /([^#]*)#?.*/

    def initialize(filename, data=false, split=false)
      @filename = filename
      @split = split
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
         @data[current_section] = []
        else
          # strip comments
          if line =~ @@data_regexp
            captured = $1
            if captured !~ /^\s*$/
              if @split
                entry = captured.strip.split("\s+")
              else
                entry = captured.strip
              end
              @data[current_section].push(entry)
            end
          end
        end
      end
    end

    def save
      open(@filename, 'w') { |f|
        @data.keys { |key|
          f.puts "[#{key}]"
          @data[key].each { |entry|
            if entry.kind_of?(Array)
              line = entry.join(' ')
            else
              line = entry
            end
            f.puts line
          }
        }
      }
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
#end
