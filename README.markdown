Dynabix
========

An ActiveRecord 3.x gem for attribute serialization

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

Copyright (c) 2012 GearheadForHire, LLC. See [LICENSE](LICENSE) for details.
