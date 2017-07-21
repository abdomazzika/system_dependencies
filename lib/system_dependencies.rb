require 'system_dependencies/version'
require 'rubygems'

module SystemDependencies
  class SystemLibraries

    def self.local_gems
      packages = []
      gems = Gem::Specification.sort_by { |g| [g.name.downcase, g.version] }.group_by(&:name)

      gems.map do |gem|
        name = gem[1][0].name
        version = gem[1][0].version.as_json['version']

        packages << { name: name, version: version }
      end

      packages
    end
  end
end