class TrackerAPI

  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def projects(tracker_token)
    return [] if tracker_token.nil?
    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    if response.success?
      JSON.parse(response.body, symbolize_names: true)
    else
      []
    end
  end

  def stories(tracker_token, tracker_id)
    return [] if tracker_token.nil?
    response = @conn.get do |req|
      req.url "services/v5/projects/#{tracker_id}/stories?limit=500"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    if response.success?
      JSON.parse(response.body, symbolize_names: true)
    else
      []
    end
  end

end









class TrackerAPI

  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def projects(token)
    return [] if token.nil? # this is a precondition
    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

end

# call with
# tracker_api = TrackerAPI.new
# tracker_api.projects(token)
