module GrapeMarkdown
  class SampleGenerator
    attr_reader :resource, :root

    delegate :unique_params, to: :resource

    def initialize(resource)
      @resource = resource
      @root     = resource.key.singularize
    end

    def sample(id = false)
      array = resource.unique_params.map do |param|
        next if param.name == root

        [param.name, param.example]
      end

      hash = Hash[array.compact]

      hash = hash.reverse_merge('id' => Configuration.generate_id) if id
      hash = { root => hash } if Configuration.include_root

      hash
    end

    def request(opts = {})
      hash = sample

      return unless hash.present?

      json(hash, opts[:pretty])
    end

    def response(opts = {})
      hash = sample(true)

      return unless hash.present?

      hash = [hash] if opts[:list]

      json(hash, opts[:pretty])
    end

    private

    def json(hash, pretty = true)
      if pretty
        JSON.pretty_generate(hash)
      else
        JSON.generate(hash)
      end
    end
  end
end
