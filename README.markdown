Dynabix
========

An ActiveRecord 3.x Ruby gem for attribute serialization.

"Dy-na-bix, tasty serialization attribute accessors for ActiveRecord"

Overview
--------

Dynabix dynamically creates read/write accessors on ActiveRecord models for
storing attributes in a serialized Hash. Read more in our introductory
[blog article](http://www.gearheadforhire.com/articles/ruby/dynabix/activerecord-gem-for-attribute-serialization).

ActiveRecord's native 'store' method
------------------------------------

ActiveRecord as of 3.2.1, has a very similar native method
[store](http://apidock.com/rails/ActiveRecord/Store).  Dynabix differs
from store by providing a declarative DSL for defining multiple stores
(Ruby 1.9+), has separate read/write accessors, and stores to the database
as HashWithIndifferentAccess. Unless you need one of these specific
features, using the native 'store' method is recommended.

Installation
------------

Add to your Gemfile

    gem "dynabix"

Install the gem

    bundle install

Development
-----------

Get the source

    cd workspace

    git clone https://github.com/robertwahler/dynabix.git

    cd dynabix

Install the dependencies

    bundle install

Run the specs

    bundle exec rake spec

Autotest with Guard

    bundle exec guard

Usage Examples
--------------

### Ruby 1.8

Add a text column "metadata" to your model migration


    class AddMetadataToThings < ActiveRecord::Migration

      def change
        add_column :things, :metadata, :text
      end

    end

Add accessors to your model using the default column name ":metadata", specify
the attributes in a separate step.

    class Thing < ActiveRecord::Base
      has_metadata

      # full accessors
      metadata_accessor :breakfast_food, :wheat_products, :needs_milk

      # read-only
      metadata_reader :friends_with_spoons
    end

Specifying attributes for full attribute accessors in one step

    class Thing < ActiveRecord::Base
      has_metadata :metadata, :breakfast_food, :wheat_products, :needs_milk
    end

Using the new accessors

    thing = Thing.new

    thing.breakfast_food = 'a wheat like cereal"

    # same thing, but using the hash directly
    thing.metadata[:breakfast_food] = 'a wheat like cereal"

### Ruby 1.9+

Dynabix under Ruby 1.9+ enables specifying multiple metadata columns on a model.

Add text columns "cows" and "chickens" to your model migration

    class AddMetadataToThings < ActiveRecord::Migration

      def change
        add_column :things, :cows, :text
        add_column :things, :chickens, :text
      end

    end

Specifying multiple metadata serializers (Ruby 1.9 only)

    class Thing < ActiveRecord::Base
      has_metadata :cows
      has_metadata :chickens, :tasty, :feather_count

      # read-only
      cows_reader :likes_milk, :hates_eggs

      # write-only
      cows_writer :no_wheat_products

      # extra full accessors for chickens
      chickens_accessor :color, :likes_eggs
    end

Runtime dependencies
--------------------

* Activerecord 3.x


Development dependencies
---------------------

* Bundler for dependency management <http://github.com/carlhuda/bundler>
* Rspec for unit testing <http://github.com/rspec/rspec>
* Yard for documentation generation <http://github.com/lsegal/yard>


Rake tasks
----------

bundle exec rake -T

    rake build             # Build dynabix-0.0.2.gem into the pkg directory
    rake doc:clean         # Remove generated documenation
    rake doc:generate      # Generate YARD Documentation
    rake doc:undocumented  # List undocumented objects
    rake gemfiles          # Generate .gemfiles via 'git ls-files'
    rake install           # Build and install dynabix-0.0.2.gem into system gems
    rake release           # Create tag v0.0.2 and build and push dynabix-0.0.2.gem to Rubygems
    rake spec              # Run RSpec

Copyright
---------

Copyright (c) 2012-2017 GearheadForHire, LLC. See [LICENSE](LICENSE) for details.
