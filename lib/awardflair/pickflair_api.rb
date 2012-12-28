require 'httparty'
# require 'yajl/yajl'

class PFBadge
  attr_accessor :id, :name, :description, :picture_url, :pickflair_instance

  def initialize(attributes={})
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def qualify?(search_terms)
    search_terms.each do |key, value|
      if value == self.send(key.to_sym)
        self
      else
        return false && break
      end
    end
  end

  def award
    pickflair_instance.award_badge(@id)
  end

  def award_to(email_of_recipient)
    pickflair_instance.award_badge_by_email(@id, email_of_recipient)
  end
end

class PickFlair
  
  include HTTParty
  attr_accessor :badges
  
  def initialize(api_key, api_secret, application_id)
    @badges ||= []
    self.class.base_uri 'https://www.pickflair.com/api/v1'
    self.class.default_params :output => 'json'; self.class.format :json
    @auth = {:api_key => api_key, :api_secret => api_secret, :application_id => application_id}
  end

  def collect_badges
    @badges = []
    array_of_badges_from_api.each do |badge_hash|
      @badges << PFBadge.new(badge_hash.merge(:pickflair_instance => self))
    end
    @badges
  end

  def badges
    if @badges.any?
      @badges
    else
      collect_badges
    end
  end

  def find_badges(search_terms)
    badges.select {|badge| badge.qualify?(search_terms)}
  end

  def award_badge(badge_identifier)
    api_response = self.class.post("/badge_request_logs.json", :body => token.merge(:badge_id => badge_identifier))
    api_response.parsed_response["data"]["badge_awarding_url"]
  end

  def award_badge_by_email(badge_identifier, email_of_recipient)
    api_response = self.class.post("/email_awards.json", :body => token.merge(:badge_id => badge_identifier, :email => email_of_recipient))
    api_response.parsed_response["data"]["badge_award_url"]
  end

  def get_badge_by_identifier(badge_identifier)
    badges_that_match = find_badges(:id => badge_identifier)
    if badges_that_match.any?
      badges_that_match.first
    else
      api_response = self.class.get("/badges/#{badge_identifier}.json", :body => token)
      api_response.parsed_response["data"]
    end
  end

  private

  def login
    response = self.class.post("/logins.json", :body => @auth)
    @token = response["data"]["token"]
  end

  def token
    { :token => (@token || login) }
  end

  def array_of_badges_from_api
    api_response = self.class.get("/badges.json", :body => token)
    api_response.parsed_response["data"]["flair"]
  end

  # def find(search_terms = {})
  #   array_of_badges_from_api.select do |badge_from_api|
  #     badge_from_api[]
  #   end
  # end

end