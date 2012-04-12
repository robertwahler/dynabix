require 'active_record'

module Dynabix
  module Metadata

    def has_metadata(serializer=:metadata, *attributes)
      serialize(serializer, Hash)

      unless RUBY_VERSION < '1.9'
        # we can safely define additional accessors, Ruby 1.8 will only
        # be able to use the statically defined :metadata_accessor
        if serializer != :metadata
          # define the class accessor for setting attributes, requires Ruby 1.9+
          define_singleton_method "#{serializer}_accessor" do |*attrs|
            attrs.each do |attr|
              create_accessor(serializer, attr)
            end
          end
        end
      end

      # define each of the attributes for this serializer
      attributes.each do |attr|
        create_accessor(serializer, attr)
      end
    end

    # this is the default accessor, user defined accessors are available under Ruby 1.9+
    def metadata_accessor(*attrs)
      attrs.each do |attr|
        create_accessor(:metadata, attr)
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
