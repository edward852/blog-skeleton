def tags_for_ex(item)
  return if item[:tags].nil?

  tags_html = '<div class="ui teal tag label">Tags:</div>'

  item[:tags].each do |tag|
    ref = tag_ref(tag)
    #ref = '99+' if ref>99
    #tags_html += '<a class="ui basic label">'+tag+'<sup>'+ref.to_s+'</sup></a>'
    tags_html += '<a class="ui basic label" href="'+tag_path(tag)+'">'+tag+'</a>'
  end

  tags_html
end

def tag_id(tag)
  '/tags/' + tag.to_s.downcase
end

def tag_path(tag)
  tag_id(tag)
end

def tag_ref(tag)
  ref = 0

  tag_item = @items[tag_id(tag)]
  unless tag_item.nil?
    ref = tag_item[:ref]
  end
  if ref.nil?
    ref = 0
  end

  ref
end

