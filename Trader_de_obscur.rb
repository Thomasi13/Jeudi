require 'rubygems'
require 'open-uri'
require 'nokogiri'



def get_all_the_crypo_name #Méthode qui récupère la devise des crypto monnaies

   @array_name = [] #Création d'un array "@array_name" vide

   page = Nokogiri::HTML(open("https://coinmarketcap.com"))
   page.css('a.currency-name-container').each do |node|
      @array_name << node.text #Ajoute dans l'array chaque devise
   end

end


def get_all_the_crypo_val #Méthode qui récupère la valeur des crypto monnaies

   @array_value = [] #Création d'un array "@array_value" vide

   page = Nokogiri::HTML(open("https://coinmarketcap.com"))
   page.css('a.price').each do |node|
      @array_value << node.text #Ajoute dans l'array chaque devise
   end


end


def chrono #Methode qui relance le programme chaque heure
   while true #Boucle infini
      get_all_the_crypo_name #Lance la méthode 
      get_all_the_crypo_val #Lance la méthode 
      puts Hash[@array_name.zip(@array_value)] #Fait un Hash des deux arrays : "@array_name" et "@array_value"
      sleep 3600 #Attend 3600 secondes
   end
end

chrono #Lance chrono