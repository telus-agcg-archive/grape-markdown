module GrapeMarkdown
  class Route < SimpleDelegator
    # would like to rely on SimpleDelegator but Grape::Route uses
    # method_missing for these methods :'(
    delegate :route_namespace,
             :route_path,
             :route_method,
             :route_description,
             to: '__getobj__'

    def route_params
      @route_params ||= __getobj__.route_params.sort.map do |param|
        Parameter.new(self, *param)
      end
    end

    def route_name
      route_namespace.split('/').last ||
        route_path.match('\/(\w*?)[\.\/\(]').captures.first
    end

    def route_short_description
      "#{route_method.titleize} a #{route_model}"
    end

    def route_path_without_format
      route_path.gsub(/\((.*?)\)/, '')
    end

    def route_model
      route_namespace.split('/').last.singularize
    end

    def route_type
      list? ? 'collection' : 'single'
    end

    def list?
      %w(GET POST).include?(route_method) && !route_path.include?(':id')
    end

    def route_binding
      binding
    end

    private

    def request_body?
      !%w(GET DELETE).include?(route_method)
    end
  end
end
