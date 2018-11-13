module GrapeMarkdown
  class Route < SimpleDelegator
    # would like to rely on SimpleDelegator but Grape::Route uses
    # method_missing for these methods :'(
    delegate(
      :namespace,
      :path,
      :request_method,
      :route_description,
      to: '__getobj__'
    )

    def root_resource
      namespace.split('/').reject(&:empty?).first
    end

    def root_resource_title
      root_resource.titleize
    end

    def route_params
      @route_params ||= __getobj__.params.sort.map do |param|
        Parameter.new(self, *param)
      end
    end

    def route_name
      namespace.split('/').last ||
        route_path.match('\/(\w*?)[\.\/\(]').captures.first
    end

    def route_title
      route_name.titleize
    end

    def route_short_description
      description = <<-DESCRIPTION.gsub(/^\s*/, '').gsub(/\n/, ' ').squeeze
      #{request_method.titleize} a
      #{list? ? 'list of '  : ' '}
      #{list? ? route_title : route_title.singularize}
      DESCRIPTION

      description << "on a #{root_resource_title.singularize}" if parent?

      description
    end

    def route_path_without_format
      path.gsub(/\((.*?)\)/, '')
    end

    def route_type
      list? ? 'collection' : 'single'
    end

    def list?
      request_method == 'GET' && !path.include?(':id')
    end

    def route_binding
      binding
    end

    private

    def request_body?
      !%w(GET DELETE).include?(request_method)
    end

    def parent?
      route_name != root_resource
    end
  end
end
