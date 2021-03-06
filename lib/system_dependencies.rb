# frozen_string_literal: true

require 'system_dependencies/version'
require 'rubygems'
require 'os'

module SystemDependencies
  class Libraries
    DEPENDENCIES_SERVICE_URL = '/api/lookups/package_system_dependencies'

    def initialize(api_root, api_port)
      @api_root = api_root
      @api_port = api_port
    end

    def local_gems
      packages = []
      gems = Gem::Specification.sort_by { |g| [g.name.downcase, g.version] }.group_by(&:name)

      gems.map do |gem|
        name = gem[1][0].name
        version = gem[1][0].version.to_s

        packages << { name: name, version: version }
      end

      packages
    end

    def operating_system_info
      bits = OS.bits
      name = ''
      vendor = ''

      report = OS.report.delete(':').split
      report.each_index do |i|
        next unless 'target_os target_vendor'.include? report[i]

        name = report[i + 1] if report[i] == 'target_os'
        vendor = report[i + 1] if report[i] == 'target_vendor'
      end

      { name: name, vendor: vendor, bits: bits }
    end

    def system_dependencies
      body = {
        lookup: {
          packages: local_gems,
          operating_system: operating_system_info,
        },
      }.to_json

      response = call_api('post',
                          url: DEPENDENCIES_SERVICE_URL,
                          body: body,
                          headers: { 'Content-Type' => 'application/json' },)

      return JSON.parse(response.body).deep_symbolize_keys if response.success?

      []
    end

    private

    def call_api(method, opts)
      url     = opts[:url]
      body    = opts[:body]    || {}
      headers = opts[:headers] || {}
      params  = opts[:params]  || {}

      fullpath = "#{@api_root}:#{@api_port}#{url}"

      request = Typhoeus::Request.new(
        fullpath,
        method: method.to_sym,
        params: params,
        body: body,
        headers: headers,
      )
      request.run
    end
  end
end
