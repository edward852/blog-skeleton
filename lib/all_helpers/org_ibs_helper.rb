#
# This helper extract in-buffer settings from org file.
# Note: should be called at preprocess stage.
#

module OrgIbsHelper
  IN_BUFFER_SETTINGS_REGEXP = /^#\+(\w+)\s*:\s*(.*)$/

  def org_ibs_to_metadata(path)
    ibs = { :kind => 'article' }
    aliasKeys = { :date => :created_at }
    ignoreKeys = [ :startup, :setupfile, :include, :tblfm ]
    splitKeys = [ :tags ]
	booleanKeys = [ :commenting ]

    File.open(path, 'r') do |f|
      f.each_line do |line|
        if line =~ IN_BUFFER_SETTINGS_REGEXP then
          key = $1.strip.downcase.to_sym
          val = $2.strip

          key = aliasKeys[key] || key

          # support simple tags only
          if splitKeys.include?(key)
            val = val.split(' ')
            unless ibs[key].nil?
              val = val.concat(ibs[key]).uniq
            end
          elsif booleanKeys.include?(key)
            val = val.downcase.eql?('true')
          end
          ibs[key] = val unless ignoreKeys.include?(key)

          #puts "found key: #{key} val: #{val}"
        end
      end
    end

    ibs
  end
end

