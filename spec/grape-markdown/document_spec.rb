require 'spec_helper'

describe GrapeMarkdown::Document do
  include_context 'configuration'

  before do
    GrapeMarkdown.config do |config|
      config.name               = name
      config.description        = description
      config.resource_exclusion = [:admin]
    end

    GrapeMarkdown.config.request_headers = [
      { 'Accept-Charset' => 'utf-8' },
      { 'Connection'     => 'keep-alive' }
    ]

    GrapeMarkdown.config.response_headers = [
      { 'Content-Length' => '21685' },
      { 'Connection'     => 'keep-alive' }
    ]
  end

  subject { GrapeMarkdown::Document.new(SampleApi) }

  context '#generate' do
    let(:klass) { SampleApi }

    subject { GrapeMarkdown::Document.new(klass).generate }

    it 'creates a header from configuration' do
      expect(subject).to include("# #{name}")
    end

    it 'adds the description' do
      expect(subject).to include(description)
    end

    it 'includes properties for the resources' do
      expect(subject).to include('Properties')
    end
  end

  it 'exposes configuration settings' do
    GrapeMarkdown::Config::SETTINGS.each do |setting|
      expect(subject.send(setting)).to eq(GrapeMarkdown.config.send(setting))
    end
  end

  it 'exposes the raw routes of the given api' do
    expect(subject.routes).to eq(SampleApi.routes)
  end

  context '#resources' do
    let(:unique_routes) { subject.routes.map(&:route_name).uniq }

    let(:included_routes) do
      unique_routes.reject do |name|
        GrapeMarkdown.config.resource_exclusion.include?(name.to_sym)
      end
    end

    it 'aggregates routes into resources' do
      expect(subject.resources.first).to be_a(GrapeMarkdown::Resource)
    end

    it 'excluded resources based on configuration' do
      expect(subject.resources.map(&:key)).to eq(included_routes)
    end
  end
end
