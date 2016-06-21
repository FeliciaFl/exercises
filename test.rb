require "sinatra"


class Freund
  attr_reader :name, :nummer, :ort
  def initialize (name, nummer, ort)
  @name=name
  @nummer=nummer
  @ort=ort

end
end

freunde=[

  Freund.new("Jana Rudolph", "0338", "Bernau"),
  Freund.new("Iris Riege", "030", "Berlin"),
  Freund.new("Robert Winter", "030", "Lichtenberg")

]

get '/' do

@freunde=freunde

 erb :index

end


post '/' do

  freunde << Freund.new(params[:name], params[:nummer], params[:ort])

  redirect '/'
end
