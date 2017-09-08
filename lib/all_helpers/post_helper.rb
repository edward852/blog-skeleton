module PostHelper
  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  def get_updated_date(post)
    attribute_to_time(post[:updated_at]).strftime('%B %-d, %Y')
  end

  def get_post_excerpt(post)
    more_regex = /<!--\s*more\s*-->/i
    para_regex = /<p>[^#][\s\S]*?(?=<\/p>)<\/p>/i

    content = post.compiled_content(snapshot: :pre)

    # <!-- more --> will be transformed to &lt;!-- more --&gt;
    # use #+BEGIN_HTML and #+END_HTML to include raw html code
    if content =~ more_regex then
      content = content.partition(more_regex).first +
                "<div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div>"
    elsif content =~ para_regex then
      content = content.partition(para_regex)[1] +
                "<div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div>"
    end
    return content
  end

  def get_post_url(post)
    y,m,d,slug = /([0-9]+)\-([0-9]+)\-([0-9]+)\-([^\/]+)/.match(post.identifier.without_ext).captures

    "/#{y}/#{m}/#{slug}/index.html"
  end

  # page starting from 1
  def paginated_articles(page=1)
    startIdx = (page-1) * @config[:items_per_page]
    endIdx = page * @config[:items_per_page]

    posts = sorted_articles()[startIdx...endIdx]
  end
end

