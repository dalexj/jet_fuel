require "test_helper"

class LinkTest < ActiveSupport::TestCase

  def link
    @link ||= Link.new
  end

  def test_valid
    assert link.valid?
  end

end
