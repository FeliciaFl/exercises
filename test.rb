require "sinatra"


class Schnittmuster
  attr_reader :name, :stoff, :laenge
  def initialize (name, stoff, laenge)
  @name=name
  @stoff=stoff
  @laenge=laenge

end
end

schnittmuster=[

  Schnittmuster.new("Butterick 5354", "Webstoff", "1,5m"),
  Schnittmuster.new("Butterick 5497", "Jersey", "1,5m"),
  Schnittmuster.new("Colette Aurora", "Jersey", "1m")

]

get '/' do

@schnittmuster=schnittmuster

 erb :index

end


post '/' do

  schnittmuster << Schnittmuster.new(params[:name], params[:stoff], params[:laenge])

  redirect '/'
end
