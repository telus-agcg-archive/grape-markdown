module GrapeMarkdown
  class Document
    attr_reader :api_class, :document_template, :properties_template

    delegate(*GrapeMarkdown::Config::SETTINGS, to: 'GrapeMarkdown::Config')

    def initialize(api_class)
      @api_class           = api_class
      @document_template   = template_for(:document)
      @properties_template = template_for(:properties)
    end

    def generate
      render(document_template, binding)
    end

    def write
      fail 'Not yet supported'
    end

    def routes
      @routes ||= api_class.routes.map do |route|
        GrapeMarkdown::Route.new(route)
      end
    end

    def resources
      @resources ||= begin
        grouped_routes = routes.group_by(&:route_name).reject do |name, routes|
          resource_exclusion.include?(name.to_sym)
        end

        grouped_routes.map { |name, routes| Resource.new(name, routes) }
      end
    end

    def properties_table(resource)
      render(properties_template, resource.resource_binding)
    end

    def formatted_request_headers
      formatted_headers(GrapeMarkdown::Config.request_headers)
    end

    def formatted_response_headers
      formatted_headers(GrapeMarkdown::Config.response_headers)
    end

    def show_request_sample?(route)
      %w(PUT POST).include?(route.route_method)
    end

    private

    def render(template, binding = nil)
      ERB.new(template, nil, '-').result(binding)
    end

    def template_for(name)
      directory = File.dirname(File.expand_path(__FILE__))
      path = File.join(directory, "./templates/#{name}.md.erb")

      File.read(path)
    end

    def formatted_headers(headers)
      return '' unless headers.present?

      spacer  = "\n" + (' ' * 12)

      strings = headers.map do |header|
        key, value = *header.first

        "#{key}: #{value}"
      end

      "    + Headers\n" + spacer + strings.join(spacer)
    end
  end
end
