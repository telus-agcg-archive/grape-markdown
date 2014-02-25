require 'grape'

module GrapeMarkdown
  autoload :Version,         'grape-markdown/version'
  autoload :Config,          'grape-markdown/config'
  autoload :Parameter,       'grape-markdown/parameter'
  autoload :SampleGenerator, 'grape-markdown/sample_generator'
  autoload :Route,           'grape-markdown/route'
  autoload :Resource,        'grape-markdown/resource'
  autoload :Document,        'grape-markdown/document'

  def self.config
    block_given? ? yield(Config) : Config
  end
end

class UnsupportedIDType < StandardError
  def message
    'Unsupported id type, supported types are [integer, uuid, bson]'
  end
end

class BSONNotDefinied < StandardError
  def message
    'BSON type id requested but bson library is not present'
  end
end
