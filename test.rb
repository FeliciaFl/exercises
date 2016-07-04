require "sinatra"


class Schnittmuster
  attr_reader :name, :stoff, :laenge
  def initialize (name, stoff, laenge)
  @name=name
  @stoff=stoff
  @laenge=laenge

end
end

schnittmustersammlung=[

  Schnittmuster.new("Butterick 5354", "Webstoff", "1,5m"),
  Schnittmuster.new("Butterick 5497", "Jersey", "1,5m"),
  Schnittmuster.new("Colette Aurora", "Jersey", "1m")

]

get '/' do

@schnittmustersammlung=schnittmustersammlung

 erb :index

end


schnittmustersammlungalt=[]


get '/delete/:schnitt' do

a = schnittmustersammlung.delete_at(params[:schnitt].to_i)
schnittmustersammlungalt << a
redirect '/'

end



get '/undo' do


schnittmustersammlung << schnittmustersammlungalt.pop

redirect '/'

end




get '/selection' do

@schnittmustersammlung=schnittmustersammlung.select do |schnittmuster|
  params[:laengenselektion]==schnittmuster.laenge &&
  params[:stoffselektion]==schnittmuster.stoff

end

erb :index


end






post '/' do

  schnittmustersammlung << Schnittmuster.new(params[:name], params[:stoff], params[:laenge])

  redirect '/'
end
