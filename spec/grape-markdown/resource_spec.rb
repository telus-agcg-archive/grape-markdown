require 'spec_helper'

describe GrapeMarkdown::Resource do
  include_context 'configuration'

  subject { GrapeMarkdown::Resource.new('foo', []) }

  context 'sample' do
    it 'request generation is delegated to a generator' do
      expect(subject.sample_generator).to receive(:request)

      subject.sample_request
    end

    it 'response generation is delegated to a generator' do
      expect(subject.sample_generator).to receive(:response)

      subject.sample_response(GrapeMarkdown::Route.new(Grape::Router::Route.new('GET', '/')))
    end
  end
end
