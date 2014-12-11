class TrackerProject

  def initialize
    @connection = Faraday.new(url: 'https://www.pivotaltracker.com')
  end

  def project(project,token)
    response = @connection.get do |req|
      req.url "/services/v5/projects/#{project}"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end


  def projects(token)
    response = @connection.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end

    JSON.parse(response.body, symbolize_names: true)
  end


  def stories(project,token)
    response = @connection.get do |req|
      req.url "/services/v5/projects/#{project}/stories?limit=500"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end



end
