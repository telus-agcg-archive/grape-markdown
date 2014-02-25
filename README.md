# GrapeMarkdown

[![Code Climate](https://codeclimate.com/github/connexio-labs/grape-markdown.png)](https://codeclimate.com/github/connexio-labs/grape-markdown)
[![Build Status](https://travis-ci.org/connexio-labs/grape-markdown.png?branch=master)](https://travis-ci.org/connexio-labs/grape-markdown)
[![Coverage Status](https://coveralls.io/repos/connexio-labs/grape-markdown/badge.png)](https://coveralls.io/r/connexio-labs/grape-markdown)
[![Dependency Status](https://gemnasium.com/connexio-labs/grape-markdown.png)](https://gemnasium.com/connexio-labs/grape-markdown)
[![Gem Version](https://badge.fury.io/rb/grape-markdown.png)](http://badge.fury.io/rb/grape-markdown)

Auto generates Markdown from the docuementation that is created by your [Grape](https://github.com/intridea/grape) API.

### NOTE

This is an early implementation that makes some assumptions about your API (follows a standard REST pattern) that works with our implementation of Grape API's. This project will generate a very simplistic Markdown document. It primarily adds some wrappers around Grape's documentation and enables other gems ([grape-apiary](https://github.com/connexio-labs/grape-apiary) and [grape-slate](https://github.com/connexio-labs/grape-slate)) to generate Markdown in specific formats.

## Installation

Add this line to your application's Gemfile:

    gem 'grape-markdown'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape-markdown

## Usage

Add some metadata about your API and then execute the `generate` method on the `GrapeMarkdown::Document` class.

### Configuration

Configure details about your api in an initializers or similar:

```ruby
GrapeMarkdown.config do |config|
  # the name of your api
  config.name               = 'Awesome API'
  # a description for your api
  config.description        = 'The awesome description'
  # the type to use for generated sample id's (`integer` or `uuid`)
  config.example_id_type    = :uuid
  # resources you do not want documented
  config.resource_exclusion = [:admin, :swagger_doc]
  # whether or not examples should include a root element (default: false)
  config.include_root       = true
end

# request headers you want documented
GrapeMarkdown.config.request_headers = [
  { 'Accept-Charset' => 'utf-8' },
  { 'Connection'     => 'keep-alive' }
]

# response headers you want documented
GrapeMarkdown.config.response_headers = [
  { 'Content-Length' => '21685' },
  { 'Connection'     => 'keep-alive' }
]
```

### Generation

```ruby
# supply the class you'd like to document and generate your blueprint
GrapeMarkdown::Document.new(AwesomeAPI).generate
```

## TODO

* Add a rake task to simplify generation
* ~~Add support for listing all of a resources attributes at the resource level as a markdown table~~
* Handle ever changing sample id's (don't want git diff's after every generation)
* Add option to change or remove the sample id field (eg. `_id` vs `id`)
* What if someone does not use JSON?!?
* ~~Create sample response for list endpoints (array)~~
* Add support for writing the markdown to disk
* ~~Add an option to include root in json~~

## Contributing

1. Fork it ( http://github.com/connexio-labs/grape-markdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
