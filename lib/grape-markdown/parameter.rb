module GrapeMarkdown
  class Parameter
    attr_reader :route, :full_name, :name, :settings

    delegate :route_name, :namespace, to: :route
    delegate :requirement, :type, :documentation, :desc, to: :settings
    delegate :example, to: :documentation, allow_nil: true

    def initialize(route, name, options)
      @full_name = name
      @name      = name
      @name      = name.scan(/\[(.*)\]/).flatten.first if name.include?('[')
      @route     = route
      @settings  = parse_options(options)
    end

    def description
      "#{name} (#{requirement}, #{type}, `#{example}`) ... #{desc}"
    end

    private

    def parse_options(options)
      options = default_options(options) if options.blank?

      options[:requirement] = options[:required] ? 'required' : 'optional'

      JSON.parse(options.to_json, object_class: OpenStruct)
    end

    def default_options(_options)
      model = name.include?('_id') ? name.gsub('_id', '') : route.route_name

      {
        required: true,
        requirement: 'required',
        type: 'uuid',
        desc: "the `id` of the `#{model}`",
        documentation: { example: GrapeMarkdown::Configuration.generate_id }
      }
    end
  end
end
