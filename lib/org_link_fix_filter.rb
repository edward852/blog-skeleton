#
# A filter to fix link in the org file.
#

class OrgLinkFixFilter < Nanoc::Filter
	identifier :org_link_fix_filter
    require 'nanoc/helpers/link_to'
    include Nanoc::Helpers::LinkTo

	def run(content, params = {})
      content.gsub(/\[\[([^\]]+?)\]/) do
        link = Regexp.last_match[1].strip
        flag = true
        link_fixed = link

        #puts "link: "+link

        while flag do
          # internal link
          if link.start_with?('#')
            break
          end

          if link.start_with?('file:')
            # ignore 'file+sys:' and 'file+emacs:'
            link = link['file:'.size..-1].strip
          end

          cmm_ext_link_type = ['http', 'news:', 'mailto:', 'ftp:', 'irc:']
          cmm_ext_link_type.each do |t|
            # common external link
            if link.start_with?(t)
              flag = false
              break
            end
          end
          unless flag
            break
          end

          content_path = Pathname.new('content')
          item_path = content_path + @item.identifier.to_s[1..-1]

          tgt_path = Pathname.new(link)
          if tgt_path.relative?
            if link.start_with?('~/')
              tgt_path = Pathname.new(File.expand_path(link))
            else
              tgt_path = item_path.dirname + link
            end
          end

          unless tgt_path.exist? && tgt_path.realpath.to_path.start_with?(content_path.realpath.to_path)
            if tgt_path.exist?
              reason = "is not within the content directory"
            else
              reason = "does not exist"
            end
            puts "Cannot fix the link to #{link} because the target "+reason
            break
          end

          if tgt_path.absolute? then
            tgt_id = '/' + tgt_path.relative_path_from(content_path.realpath).to_s
          else
            tgt_id = tgt_path.to_path[content_path.to_path.size..-1]
          end

          tgt_item = @items[tgt_id]
          if tgt_item.nil? then
            puts "Cannot fix the link to #{link} because the target has no corresponding item"
            break
          end

          tgt_abs_path = tgt_item.reps[:default].path

          link_fixed = relative_path_to(tgt_abs_path)
          flag = false
        end

        #puts "link fixed: #{link_fixed}"
        '[['+link_fixed+']'
      end
	end
end
