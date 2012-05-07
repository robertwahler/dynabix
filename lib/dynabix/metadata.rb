require 'active_record'

# An ActiveRecord 3.x Ruby gem for attribute serialization.
module Dynabix

  # Extending ActiveRecord with dynamic accessors for serialization
  module Metadata

    # Set up the model for serialization to a HashWithIndifferentAccess.
    #
    # @example Using the default column name ":metadata", specify the attributes in a separate step
    #
    #    class Thing < ActiveRecord::Base
    #      has_metadata
    #
    #      # full accessors
    #      metadata_accessor :breakfast_food, :wheat_products, :needs_milk
    #
    #      # read-only
    #      metadata_reader :friends_with_spoons
    #    end
    #
    # @example Specifying attributes for full attributes accessors in one step
    #
    #    class Thing < ActiveRecord::Base
    #      has_metadata :metadata, :breakfast_food, :wheat_products, :needs_milk
    #    end
    #
    # @example Specifying multiple metadata serializers (Ruby 1.9 only)
    #
    #    class Thing < ActiveRecord::Base
    #      has_metadata :cows
    #      has_metadata :chickens, :tasty, :feather_count
    #
    #      # read-only
    #      cow_reader :likes_milk, :hates_eggs
    #
    #      # write-only
    #      cow_writer :no_wheat_products
    #
    #      # extra full accessors for chickens
    #      chicken_accessor :color, :likes_eggs
    #    end
    #
    # @param [Symbol] serializer, the symbolized name (:metadata) of the database text column used for serialization
    # @param [Array<Symbol>] optional list of attribute names to add to the model as full accessors
    #
    # @return [void]
    def has_metadata(serializer=:metadata, *attributes)
      serialize(serializer, HashWithIndifferentAccess)

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

      # Define each of the attributes for this serializer
      attributes.each do |attr|
        create_reader(serializer, attr)
        create_writer(serializer, attr)
      end
    end

    # Default read/write accessor, user defined accessors are available under Ruby 1.9+
    #
    # @param [Array<Symbol>] attributes
    #
    # @return [void]
    def metadata_accessor(*attrs)
      attrs.each do |attr|
        create_reader(:metadata, attr)
        create_writer(:metadata, attr)
      end
    end

    # Default read accessor (getter), user defined accessors are available under Ruby 1.9+
    #
    # @param [Array<Symbol>] attributes
    #
    # @return [void]
    def metadata_reader(*attrs)
      attrs.each do |attr|
        create_reader(:metadata, attr)
      end
    end

    # Default write accessor (setter), user defined accessors are available under Ruby 1.9+
    #
    # @param [Array<Symbol>] attributes
    #
    # @return [void]
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
      define_method("#{attr}".to_sym) do
        self[serializer][attr.to_sym]
      end
    end

    def create_writer(serializer, attr)
      define_method("#{attr}=".to_sym) do |value|
        # mark this attribute as dirty because AR will not mark serializers of nested models dirty
        self.send("#{serializer}_will_change!")
        self[serializer][attr.to_sym] = value
      end
    end

  end
end

ActiveRecord::Base.extend Dynabix::Metadata
