module ArchiveHelper
  def archive_id(time)
    '/archives/'+archive_name(time)
  end

  def archive_name(time)
    time.year.to_s
  end
end


