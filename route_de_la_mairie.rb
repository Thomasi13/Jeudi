require 'rubygems'
require 'open-uri'
require 'nokogiri'


def get_all_the_urls_of_val_doise_townhalls

   @list_town =[]

   page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
   page.css('a.lientxt').each do |node|

      @liens = node['href'].slice!(1,1000)
      @list_town = node.text

      get_the_email_of_a_townhal_from_its_webpage(@liens)
   end


end


def get_the_email_of_a_townhal_from_its_webpage (liens)

   page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"+liens))
   page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|node.text
     @list_adress = node.text

      puts "La Mairie de la commune #{@list_town} :#{@list_adress}"

   end
end


get_all_the_urls_of_val_doise_townhalls
