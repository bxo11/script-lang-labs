#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'sequel'
require 'sqlite3'

$NOT_FOUND = 'not found'

# Fetch and parse HTML document
$amazonUrl = 'https://www.amazon.pl'
$amazonCategory = 'laptop'
$baseUrl = $amazonUrl+'/s?k='+$amazonCategory
$userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'

def getUrl(el)
	link = el.css('a.a-link-normal.s-underline-text.s-underline-link-text.s-link-style.a-text-normal').first['href'].to_s
	if link.empty?
		link = $NOT_FOUND
	end
	return $amazonUrl+link
end

def getPrice (el)
	price = el.css('span.a-price span.a-offscreen').text.to_s
	if !price.empty?
		price = price.split('zł').first.delete(' ')
	else
		price = $NOT_FOUND
	end
	return price
end

def getRating(el)
	rating = el.css('.a-icon.aok-align-bottom').text.to_s
	if rating.empty?
		rating = $NOT_FOUND
	end
	return rating
end

def getSellerFromDetails (el)
	seller = el.css('div.tabular-buybox-text.a-spacing-none span.a-size-small.tabular-buybox-text-message').first.text
	if seller.empty?
		seller = $NOT_FOUND
	end
	return seller
end

def getBrandFromDetails (el)
	brand = el.css('#bylineInfo').text.split.join(" ")
	if brand.empty?
		brand = $NOT_FOUND
	else
		brand = brand.split(':')[-1]
	end
	return brand
end

### main
$DB = Sequel.connect('sqlite://'+$amazonCategory+'.db')
$DB.drop_table?(:data)
$DB.create_table :data do
	primary_key :id
	String :name
	String :price
	String :rating
	String :seller
	String :brand
	String :url
	end

doc = Nokogiri::HTML(URI.open($baseUrl, "User-Agent" => $userAgent))
doc.css('div.s-widget-container').each do |el|
	productData = {}
	name = el.css('span.a-size-base-plus.a-color-base.a-text-normal').text.to_s

	unless name.strip.empty?
		productData[:url] = getUrl(el)
		productData[:name] = name
		productData[:price] = getPrice(el)
		productData[:rating] = getRating(el)

		if !productData[:url].empty?
			detailPage = Nokogiri::HTML(URI.open(productData[:url], "User-Agent" => $userAgent))
			productData[:seller] = getSellerFromDetails(detailPage)
			productData[:brand] = getBrandFromDetails(detailPage)
		end
		$DB[:data].insert(name: productData[:name], price: productData[:price], rating: productData[:rating], seller: productData[:seller], brand: productData[:brand], url: productData[:url])
	end
	# if productData.length > 0
	# 	puts productData
	# 	$DB[:data].insert(name: productData[:name], price: productData[:price], rating: productData[:rating], seller: productData[:seller], brand: productData[:brand], url: productData[:url])
	# 	break
	# end
end
