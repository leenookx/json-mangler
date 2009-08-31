require 'strscan'

# A basic JSON extraction utility inspired by the parser example given at
# http://rubyquiz.com/quiz155.html

class JSONExtractor

    def initialize
      @output = ""
      @force_capture = false
    end

    def extract(input, extract_mode, search, depth = 1)
        @output = ""
        @force_capture = false
        @capture_depth = depth - 1
        @current_depth = 0
        @num_fragments = 0

        @input = StringScanner.new( input )
        @searchval = '"' + search + '"'

        if extract_mode == "object"
            @mode = 1
        elsif extract_mode == "data"
            @mode = 2
        else
           error "Unknown mode '" + extract_mode + "'. Supported [object, data]"
        end

        puts "Extracting data based on '" + extract_mode + "' values."

        parse_value

        results = "{ \"results\": [" + @output + "] }\n"
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
            start_pos = @input.pos
            more_pairs = false
            capture = false
            while key = parse_string
                @input.scan(/\s*:\s*/) or error("Expecting object separator")

                # If we're in object matching mode and we've found an object
                # that matches the one we're looking for...
                if @mode == 1 and key == @searchval
                    capture = true
                end

                res = parse_value

                # If we're in data matching mode and the data associated
                # will this object matches what we are looking for, but
                # make sure that we don't re-force the capture if one is
                # already in progress.
                if @mode == 2 and res == @searchval 
                    if !@force_capture
                        if @capture_depth > 0
                            # Set the 'upward' depth to be captured.
                            @current_depth = @capture_depth

                            # Force the capturing of this object.
                            @force_capture = true
                        else
                            capture = true
                        end
                    else
                        @current_depth = @current_depth - 1
                    end
                end

                if !@force_capture and capture
                    fragment = key + ": " + res.to_s
                    add_json_fragment( fragment )

                    # We've stopped capturing locally...
                    capture = false
                end

                # Handle special case of array match
                if @force_capture 
                    if @current_depth == -1
                        fragment = key + ": " + res.to_s
                        add_json_fragment( fragment )
                        @force_capture = false
                        @current_depth = 0
                    end
                end

                # Are there more pairs associated with this
                # object?
                more_pairs = @input.scan(/\s*,\s*/)
                if more_pairs
                    # yes, so write out a comma.
                    output << ", "
                else
                     # Do we need to force capturing of the entire
                     # object?
                     if @force_capture and @current_depth == 0
                         last_pos = @input.pos
                         cur_pos = start_pos
                         @input.pos = cur_pos
                         fragment = ""
                         while (cur_pos < last_pos)
                             fragment << @input.getch
                             cur_pos = cur_pos + 1
                         end

                         add_json_fragment( fragment )

                         @force_capture = false
                     else
                         # No, we need to 'descend' further
                         @current_depth = @current_depth - 1
                     end
                end
            end
            error("Missing object pair") if more_pairs
            @input.scan(/\s*\}/) or error("Unclosed object")
        else
            false
        end
    end

    def parse_array
        if @input.scan(/\[\s*/)
            array = "["
            more_values = false
            while contents = parse_value rescue nil
                array << contents
                if contents == @searchval
                    @force_capture = true
                    @current_depth = -1
                end
                more_values = @input.scan(/\s*,\s*/) or break
                array << ", "
            end
            error("Missing value") if more_values
            @input.scan(/\s*\]/) or error("Unclosed array")
            array << "]"
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
            string << '"'

            # If we're in data matching mode and this matches the
            # value that we are searching for...
            if @mode == 2 and string == @searchval and @capture_depth > 0
                @force_capture = true
                @current_depth = @capture_depth
            end
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

    def add_json_fragment( fragment )
        @num_fragments = @num_fragments + 1
        if @num_fragments > 1
            @output << ", "
        end

        @output << '{' << fragment << '}'
    end
end

