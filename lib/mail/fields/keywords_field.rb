# encoding: utf-8
# frozen_string_literal: true
# 
# keywords        =       "Keywords:" phrase *("," phrase) CRLF
module Mail
  class KeywordsField < StructuredField
    
    FIELD_NAME = 'keywords'
    CAPITALIZED_FIELD = 'Keywords'
    
    def initialize(value = nil, charset = 'utf-8')
      self.charset = charset
      super(CAPITALIZED_FIELD, value, charset)
      self
    end

    def parse(val = value)
      unless Utilities.blank?(val)
        @phrase_list ||= PhraseList.new(value)
      end
    end
    
    def phrase_list
      @phrase_list ||= PhraseList.new(value)
    end
      
    def keywords
      phrase_list.phrases
    end
    
    def encoded
      if Utilities.blank?(value)
        "#{CAPITALIZED_FIELD}: \r\n"
      else
        "#{CAPITALIZED_FIELD}: #{keywords.join(",\r\n ")}\r\n"
      end
    end
    
    def decoded
      if Utilities.blank?(value)
        ""
      else
        keywords.join(', ')
      end
    end

    def default
      if Utilities.blank?(value)
        []
      else
        keywords
      end
    end
    
  end
end
