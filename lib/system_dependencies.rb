# frozen_string_literal: true

require 'system_dependencies/version'
require 'rubygems'
require 'os'

module SystemDependencies
  class SystemLibraries
    def self.local_gems
      packages = []
      gems = Gem::Specification.sort_by { |g| [g.name.downcase, g.version] }.group_by(&:name)

      gems.map do |gem|
        name = gem[1][0].name
        version = gem[1][0].version.to_s

        packages << { name: name, version: version }
      end

      packages
    end

    def self.operating_system_info
      bits = OS.bits
      name = ''
      vendor = ''

      report = OS.report.delete(':').split
      report.each_index do |i|
        next unless %q(target_os target_vendor).include?report[i]

        name = report[i + 1] if report[i] == 'target_os'
        vendor = report[i + 1] if report[i] == 'target_vendor'
      end

      { name: name, vendor: vendor, bits: bits }
    end

    def self.system_dependencies ## Gets all the applications accessible by this person
      url = '/api/lookups/package_system_dependencies'

      body = {
        lookup: {
          packages: local_gems,
          operating_system: operating_system_info,
        },
      }.to_json

      response = call_api('post',
                          url: url, body: body, headers: { 'Content-Type' => 'application/json' },)

      return JSON.parse(response.body).deep_symbolize_keys if response.success?

      []
    end

    def self.call_api(method, opts)
      url     = opts[:url]
      body    = opts[:body]    || {}
      headers = opts[:headers] || {}
      params  = opts[:params]  || {}

      api_root = 'localhost'
      api_port = '3000'

      fullpath = "#{api_root}:#{api_port}#{url}"

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
