require "test_helper"

class LinkShortenerTest < Capybara::Rails::TestCase
  def shorten_fake_link(location = "/page_that_doesnt_exist")
    visit root_path
    fill_in "link[url]", with: location
    click_link_or_button "Create Link"
  end

  def test_gets_back_shortened_url
    visit root_path
    require 'pry' ; binding.pry # try running Rails.env
    refute_content page, "URL Shortened"
    shorten_fake_link
    assert_content page, "URL Shortened"
  end

  def test_can_follow_the_link
    link_location = "/fake_link_location"
    shorten_fake_link(link_location)

    click_link_or_button "#created-link"
    assert_equal current_path, link_location
  end

  def test_sorted_links
    skip
    visit root_path
    link_most_visits = Link.create!(url: "/fake", visits: 9)
    sleep(0.25)
    link_in_middle   = Link.create!(url: "/fake", visits: 8)
    sleep(0.25)
    link_most_recent = Link.create!(url: "/fake", visits: 5)

    within("ul#links li:first") do
      assert_content page, link_most_visits.local_slug
    end

    click_link_or_button "#sort-created-at"

    within("ul#links li:first") do
      assert_content page, link_most_recent.local_slug
    end
  end
end
