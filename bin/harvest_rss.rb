require 'rubygems'
require 'rss'
require 'rsolr'
require 'pry'
require 'securerandom'

rss_file = 'bin/completeArchiveWithImages.xml'
open(rss_file) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  solr = RSolr.connect :url => 'http://localhost:8983/solr/blacklight-core'
  copyright = feed.channel.copyright
  channel_title = feed.channel.title
  feed.items.each_with_index do |item, i|
    item_count = feed.items.size
    puts "#{i+1} of #{item_count}: Adding " + item.title
    author, title = item.title.split(" - ")
    guid = Digest::MD5.hexdigest(item.guid.content ? item.guid.content : item.link)
    document = { id: guid,
                 channel_display: channel_title,
                 author_t: author,
                 author_display: author,
                 title_t: title,
                 title_display: title,
                 pub_date: item.pubDate.year.to_s,
                 release_date_display: item.pubDate.to_s,
                 url_fulltext_display: item.link,
                 text: item.description,
                 description_display: item.description,
                 guid_s: item.guid.content,
                 copyright_s: copyright,
                 subject_topic_facet: item.itunes_keywords}
        
    document[:thumbnail_display] = item.enclosure.url if item.enclosure.type == "image/png"

    solr.add document, :add_attributes => {:commitWithin => 10}
  end
end
