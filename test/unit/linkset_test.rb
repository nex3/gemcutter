require File.dirname(__FILE__) + '/../test_helper'

class LinksetTest < ActiveSupport::TestCase
  should_belong_to :rubygem
  should_not_allow_mass_assignment_of :rubygem_id

  context "with a linkset" do
    setup do
      @linkset = Factory.build(:linkset)
    end

    should "be valid with factory" do
      assert_valid @linkset
    end

    should "not be empty with some links filled out" do
      assert !@linkset.empty?
    end

    should "be empty with no links filled out" do
      Linkset::LINKS.each do |link|
        @linkset.send("#{link}=", nil)
      end
      assert @linkset.empty?
    end
  end

  context "with a Gem::Specification" do
    setup do
      @spec    = gem_specification_from_gem_fixture('test-0.0.0')
      @linkset = Factory(:linkset)
      @linkset.update_attributes_from_gem_specification!(@spec)
    end

    should "have linkset home be set to the specificaton's homepage" do
      assert_equal @spec.homepage, @linkset.home
    end
  end
end
