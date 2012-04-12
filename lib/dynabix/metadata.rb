require 'active_record'

module Dynabix
  module Metadata

    def has_metadata(serializer=:metadata, *attributes)
      serialize(serializer, Hash)

      if RUBY_VERSION < '1.9'
        raise "has_metadata serializer must be named ':metadata', this restriction is lifted in Ruby 1.9+" unless serializer == :metadata
      else
        # we can safely define additional accessors, Ruby 1.8 will only
        # be able to use the statically defined :metadata_accessor
        if serializer != :metadata

          # define the class accessor
          define_singleton_method "#{serializer}_accessor" do |*attrs|
            attrs.each do |attr|
              create_reader(serializer, attr)
              create_writer(serializer, attr)
            end
          end

          # define the class read accessor
          define_singleton_method "#{serializer}_reader" do |*attrs|
            attrs.each do |attr|
              create_reader(serializer, attr)
            end
          end

          # define the class write accessor
          define_singleton_method "#{serializer}_writer" do |*attrs|
            attrs.each do |attr|
              create_writer(serializer, attr)
            end
          end

        end
      end

      # define each of the attributes for this serializer
      attributes.each do |attr|
        create_reader(serializer, attr)
        create_writer(serializer, attr)
      end
    end

    # this is the default accessor, user defined accessors are available under Ruby 1.9+
    def metadata_accessor(*attrs)
      attrs.each do |attr|
        create_reader(:metadata, attr)
        create_writer(:metadata, attr)
      end
    end

    def metadata_reader(*attrs)
      attrs.each do |attr|
        create_reader(:metadata, attr)
      end
    end

    def metadata_writer(*attrs)
      attrs.each do |attr|
        create_writer(:metadata, attr)
      end
    end


    private

    def create_accessor(serializer, attr)
      create_reader(serializer, attr)
      create_writer(serializer, attr)
    end

    def create_reader(serializer, attr)
      define_method("#{attr}") do
        self[serializer][attr]
      end
    end

    def create_writer(serializer, attr)
      define_method("#{attr}=") do |value|
        self[serializer][attr] = value
      end
    end

  end
end

ActiveRecord::Base.extend Dynabix::Metadata
