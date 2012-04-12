require 'active_record'

module Dynabix
  module Metadata

    def has_metadata(serializer=:metadata, *attributes)
      serialize(serializer, Hash)

      # Requires Ruby 1.9+
      #
      # define the class accessor for setting attributes
      define_singleton_method "#{serializer}_accessor" do |*attrs|
        attrs.each do |attr|
          create_accessor(serializer, attr)
        end
      end

      # define each of the attributes for this serializer
      attributes.each do |attr|
        create_accessor(serializer, attr)
      end
    end

    private

    def create_accessor(serializer, attr)

      define_method("#{attr}") do
        self[serializer][attr]
      end

      define_method("#{attr}=") do |value|
        self[serializer][attr] = value
      end

    end

  end
end

ActiveRecord::Base.extend Dynabix::Metadata
