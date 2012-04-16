require 'spec_helper'

class Thing < ActiveRecord::Base
  has_metadata

  metadata_accessor :rv_doors, :rv_windows
end

describe Dynabix::Metadata do

  describe "has_metadata" do

    it "should be a class method" do
      defined?(Thing.has_metadata).should be_true
      defined?(Thing.create_accessor).should be_false
    end

  end

  describe "creating a serializer" do

    context "has_metadata with no params, Ruby 1.8+" do

      it "should create a default instance serializer accessor called 'metadata'" do
        defined?(Thing.metadata).should be_false
        thing = Thing.new
        thing.should be_valid
        defined?(thing.metadata).should be_true
        thing.metadata.should == {}
      end

      it "should create a default class level accessor called 'metadata_accessor'" do
        defined?(Thing.metadata_accessor).should be_true
        defined?(Thing.rv_windows).should be_false

        thing = Thing.new
        defined?(thing.rv_windows).should be_true
        thing.metadata[:rv_windows].should be_nil
        thing.metadata[:rv_windows] = 1
        thing.metadata[:rv_windows].should == 1
        thing.rv_windows = 2
        thing.rv_windows.should == 2
      end

    end

    context "has_metadata with attribute params, Ruby 1.8+" do

      class Foo < ActiveRecord::Base
        has_metadata :metadata, :bar1, :bar2

        metadata_reader :frog
        metadata_writer :duck
      end

      it "should create a default instance serializer accessor called 'metadata'" do
        foo = Foo.new
        foo.metadata.should == {}
      end

      it "should create a default class level accessor called 'metadata_accessor'" do
        foo = Foo.new
        defined?(foo.bar1).should be_true
        defined?(foo.bar2).should be_true
        foo.metadata[:bar1].should be_nil
        foo.metadata[:bar1] = 1
        foo.metadata[:bar1].should == 1
        foo.bar1 = 2
        foo.bar1.should == 2
      end

      it "should create a default class level write accessor called 'metadata_writer'" do
        foo = Foo.new
        foo.duck = 2
        foo.metadata[:duck].should == 2
        lambda { foo.duck }.should raise_exception(NoMethodError)
      end

      it "should create a default class level read accessor called 'metadata_reader'" do
        foo = Foo.new
        foo.metadata[:frog] = 4
        foo.frog.should == 4
        lambda { foo.frog = 5 }.should raise_exception(NoMethodError)
      end
    end

    unless RUBY_VERSION < '1.9'

      class Bar < ActiveRecord::Base
        has_metadata :bardata

        bardata_accessor :foo
        bardata_reader :frog
        bardata_writer :duck
      end

      context "has_metadata with user defined name of metadata database field 'bardata', Ruby 1.9+" do

        it "should create a default instance serializer accessor called 'bardata'" do
          defined?(Bar.bardata).should be_false
          thing = Bar.new
          thing.should be_valid
          defined?(thing.bardata).should be_true
          thing.bardata.should == {}
        end

        it "should create a default class level accessor called 'bardata_accessor'" do
          defined?(Bar.bardata_accessor).should be_true
          defined?(Bar.foo).should be_false

          thing = Bar.new
          defined?(thing.foo).should be_true
          thing.bardata[:foo].should be_nil
          thing.bardata[:foo] = 1
          thing.bardata[:foo].should == 1
          thing.foo = 2
          thing.foo.should == 2
        end

        it "should create a default class level write accessor called 'bardata_writer'" do
          bar = Bar.new
          bar.duck = 2
          bar.bardata[:duck].should == 2
          lambda { bar.duck }.should raise_exception(NoMethodError)
        end

        it "should create a default class level read accessor called 'bardata_reader'" do
          bar = Bar.new
          bar.bardata[:frog] = 4
          bar.frog.should == 4
          lambda { bar.frog = 5 }.should raise_exception(NoMethodError)
        end
      end
    end

  end
end
