require 'json'

class JSONMangler
  VERSION = '0.1.0'

  def initialize( json_data )
    ingest_json( json_data )
  end

  def valid
    !@json_obj.nil?
  end

  def prune( keys )
    if valid
      keys.each do |key|
        @json_obj.delete_if{|k, v| k == key }
      end
    end
  end

  def to_json
    if valid
      JSON.pretty_generate( @json_obj )
    else
      ""
    end
  end

 private

  def ingest_json( json_string )
    begin
      @json_obj = JSON.parse( json_string )
    rescue
      @json_obj = nil
    end
  end
end
