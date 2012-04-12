Dynabix
========

A Rails 3.x gem for attribute serialization

Runtime dependencies
------------------------
* Activerecord

Development dependencies
---------------------

* Bundler for dependency management <http://github.com/carlhuda/bundler>
* Rspec for unit testing <http://github.com/rspec/rspec>
* Cucumber for functional testing <http://github.com/cucumber/cucumber>
* Aruba for CLI testing <http://github.com/cucumber/aruba>
* Yard for documentation generation <http://github.com/lsegal/yard>


Rake tasks
----------

bundle exec rake -T

    rake build         # Build mutagem-0.0.1.gem into the pkg directory
    rake doc:clean     # Remove generated documenation
    rake doc:generate  # Generate YARD Documentation
    rake features      # Run Cucumber features
    rake install       # Build and install mutagem-0.0.1.gem into system gems
    rake release       # Create tag v0.0.1 and build and push mutagem-0.0.1.gem to Rubygems
    rake spec          # Run specs
    rake test          # Run specs and features


Copyright
---------

Copyright (c) 2012 GearheadForHire, LLC. See [LICENSE](LICENSE) for details.
