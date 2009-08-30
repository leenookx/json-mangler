require 'strscan'

# A basic JSON extraction utility inspired by the parser example given at
# http://rubyquiz.com/quiz155.html

class JSONExtractor

    def extract(input, search)
        @input = StringScanner.new( input )
        @searchval = '"' + search + '"'
        @output = ""
        parse_value
        results = "{ \"results\": {" + @output + "} }\n"
    end

  private

    def error(message)
        if @input.eos?
            raise "Unexpected end of input."
        else
            raise "#{message}: @ char #{@input.pos} :: #{@input.peek(@input.string.length)}"
        end
    end

    def parse_value
        trim_space
        parse_object or
          parse_array or
          parse_string or
          parse_number or
          parse_keyword or
          error("Illegal JSON value")
    ensure
        trim_space
    end

    def parse_object
        if @input.scan(/\{\s*/)
            output = ""
            more_pairs = false
            while key = parse_string
            puts "::" + key  + "::" + @searchval + "::"
                @input.scan(/\s*:\s*/) or error("Expecting object separator")

                if key == @searchval
                    capture = true
                end

                res = parse_value

                if key == @searchval and capture
                    puts "  ! This one matched !"
                    @output = output + key + ": " + res
                    capture = false
                end

                more_pairs = @input.scan(/\s*,\s*/) or break
            end
            error("Missing object pair") if more_pairs
            @input.scan(/\s*\}/) or error("Unclosed object")
        else
            false
        end
    end

    def parse_array
        if @input.scan(/\[\s*/)
            array = Array.new
            more_values = false
            while contents = parse_value rescue nil
                array << contents.value
                more_values = @input.scan(/\s*,\s*/) or break
            end
            error("Missing value") if more_values
            @input.scan(/\s*\]/) or error("Unclosed array")
            array
        else
            false
        end
    end

    def parse_string
        if @input.scan(/"/)
            string = '"'
            while contents = parse_string_content || parse_string_escape
                string << contents
            end
            @input.scan(/"/) or error("Unclosed string")
            string = string + '"'
            string
        else
            false
        end
    end

    def parse_string_content
        @input.scan(/[^\\"]+/) and @input.matched
    end

    def parse_string_escape
        if @input.scan(%r{\\["\\/]})
            @input.matched[-1]
        elsif @input.scan(/\\[bfnrt]/)
            eval(%Q{"#{@input.matched}"})
        elsif @input.scan(/\\u[0-9a-fA-F]{4}/)
            [Integer("0x#{@input.matched[2..-1]}")].pack("U")
        else
            false
        end
    end

    def parse_number
        @input.scan(/-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?\b/) and
          eval(@input.matched)
    end

    def parse_keyword
        @input.scan(/\b(?:true|false|null)\b/) and
          eval(@input.matched.sub("null", "nil"))
    end

    def trim_space
        @input.scan(/\s+/)
    end
end

