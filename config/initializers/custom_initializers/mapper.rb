class ActionDispatch::Routing::Mapper
  # Take the draw method from :
  # https://github.com/rails/rails/commit/6acebb38bc0637bc05c19d87f8767f16ce79189b
  # It was remove on the commit
  # https://github.com/rails/rails/commit/5e7d6bba79393de0279917f93b82f3b7b176f4b5
  def draw(name)
    @draw_paths ||= [Rails.root.join("config/routes")]
    path = @draw_paths.find do |p|
      p.join("#{name}.rb").file?
    end
    unless path
      msg  = "Your router tried to #draw the external file #{name}.rb,\n" \
             "but the file was not found in:\n\n"
      msg += @draw_paths.map { |p| " * #{p}" }.join("\n")
      raise msg
    end
    instance_eval(path.join("#{name}.rb").read)
  end
end
