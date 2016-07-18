require "sinatra"


class Schnittmuster

  attr_reader :name, :stoff, :laenge, :done

  def initialize (name, stoff, laenge, done)
    @name=name
    @stoff=stoff
    @laenge=laenge
    # TODO: Could you handle negative lengths?
    # TODO: Or invalid values like 'blabla'?
    @done=done
  end

  def gruen
    if @done=="ja" then
    "bgcolor=\"#cfeace\""
    end
  end

end

schnittmustersammlung=[

  Schnittmuster.new("Butterick 5354", "Webstoff", "1.5", "ja"),
  Schnittmuster.new("Butterick 5497", "Jersey", "1.5", "nein"),
  Schnittmuster.new("Colette Aurora", "Jersey", "1", "nein")

]

get '/' do

@schnittmusteranzeige=schnittmustersammlung
@schnittmusterarchiv=schnittmustersammlung

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




# TODO: Maybe merge route `/selection` and `/`
# Why? It feels strange that adding another pattern deletes all filter options
# Because I'm redirected to `/`
get '/selection' do

@schnittmusterarchiv=schnittmustersammlung
@schnittmusteranzeige=schnittmustersammlung.select do |schnittmuster|
  params[:laengenselektion].to_f >= schnittmuster.laenge.to_f &&
  params[:stoffselektion]==schnittmuster.stoff

end

erb :index

end






post '/' do

  schnittmustersammlung << Schnittmuster.new(params[:name], params[:stoff], params[:laenge], params[:done])

  redirect '/'
end
