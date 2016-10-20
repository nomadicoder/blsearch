require 'rubygems'
require 'rss'
require 'rsolr'
require 'pry'
require 'securerandom'
require 'ruby-progressbar'

def harvest_rss (rss_source)
  open(rss_file) do |rss|
    feed = RSS::Parser.parse(rss_source)
    puts "Harvesting: #{feed.channel.title}"
    progressbar = ProgressBar.create(:title => "Item", :total => feed.items.size, format: "%t (%c/%C) %a |%B|")
    solr = RSolr.connect :url => 'http://localhost:8983/solr/blacklight-core'
    copyright = feed.channel.copyright
    channel_title = feed.channel.title
    feed.items.each_with_index do |item, i|
      progressbar.increment
      channel_str = get_channel(item.link)
      author, title = item.title.split(" - ")
      guid = Digest::MD5.hexdigest(item.guid.content ? item.guid.content : item.link)
      document = { id: guid,
                   channel_facet: channel_str,
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
end

def get_channel (uri_str)
  uri = URI(uri_str)
  host = uri.host
  if host
    channel_str = host.split('.').first
  else
    channel_str = 'unknown'
  end
end

harvest_rss('completeArchiveWithImages.xml')
