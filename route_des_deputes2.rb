require 'rubygems'
require 'open-uri'
require 'nokogiri'



def get_all_the_name_of_deputy #methode qui récupère les noms et prenom des députés

   page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
   page.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |node|

    #Récupère prenom et, enlève "M." ou  "Mme"
    #Sépare le prénom et le nom, puis range le prénom dans la variable "@depute_prenom", et le nom dans "@depute_nom"

     @depute_prenom = node.text.sub("M. ", "").sub("Mme ", "").split(' ').slice(0) # 0 est la position du premier mot (prénom)
     @depute_nom = node.text.sub("M. ", "").sub("Mme ", "").split(' ').slice(1..3) #(1..3) pour les noms composés 

     
     @OMC = node['href'] #Récupère l'OMC correspondant au député sélectionné, et range le dans la variable "@OMC"

     get_all_the_emails_of_deputy(@OMC) #Appelle la méthode "get_all_the_emails..." en utilisant la variable (@OMC)
   end
end


def get_all_the_emails_of_deputy(names) #Méthode qui va prélever l'adresse mail dans la page ( avec comme variable name==@OMC )

  @emails_list = [] #Création d'un array "@email_list vide"
  array_depute_prenom = [] #Création d'un array "array_depute_prenom" vide
  array_depute_nom = [] #Création d'un array "array_depute_nom" vide
  @array_prenom_nom = [] #Création d'un array "array_depute_prenom" vide

   page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr"+names))
   page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[1]/a').each do |node|

     @emails_list << node['href'].sub("mailto:", "") #Récupère l'adresse mail et remplace "mailto:" par "rien"

     array_depute_prenom << @depute_prenom #Ajoute dans l'array chaque "@depute_prenom" récolté
     array_depute_nom<< @depute_nom #Ajoute dans l'array chaque "@depute_nom" récolté

     @array_prenom_nom << array_depute_prenom + array_depute_nom.flatten(2) #Ajoute dans l'array les deux array précèdent

   
   end

      puts Hash[@array_prenom_nom.zip(@emails_list)]  #Crée et affiche un hash qui contient les arrays : "@array_prenom_nom" et @emails_list

end


get_all_the_name_of_deputy #Début du programme => Appelle la méthode get_all_the_name_of_deputy




