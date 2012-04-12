require 'spec_helper'

class Thing < ActiveRecord::Base
  has_metadata

  metadata_accessor :rv_doors, :rv_windows
end

class Bar < ActiveRecord::Base
  has_metadata :bardata

  bardata_accessor :foo
end

describe Dynabix::Metadata do

  describe "has_metadata" do

    it "should be a class method" do
      defined?(Thing.has_metadata).should be_true
      defined?(Thing.create_accessor).should be_false
    end

  end

  describe "creating a serializer" do

    context "has_metadata with no params" do

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

    context "has_metadata with user defined name of metadata database field 'bardata'" do

      it "should create a default instance serializer accessor called 'bardata'" do
        defined?(Bar.bardata).should be_false
        thing = Bar.new
        thing.should be_valid
        defined?(thing.bardata).should be_true
        thing.bardata.should == {}
      end

      it "should create a default class level accessor called 'metadata_accessor'" do
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
    end

  end

end
