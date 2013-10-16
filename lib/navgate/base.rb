class Base
  attr_accessor :selection, :default, :prefix, :controller,  :by_id, :css_class

  def initialize(&block)
    options = {selection: nil,default: nil, controller: nil, css_class: nil}
    yield(options)
    self.selection = pull_data(options[:selection])
    self.default = options[:default] || self.selection.first
    self.prefix = options[:prefix]
    self.controller = options[:controller]
    self.by_id = pull_data({options[:selection].to_a.first.first => :id }) if options[:by_id]
    self.css_class = options[:css_class]
  end
  private
    def pull_data selection
      if selection.is_a?(Array)
        output = selection
      elsif selection.is_a?(Hash)
        output = []
        selection.each do |key,value|
          key.to_s.singularize.classify.constantize.all.each do |item|
            output.push(item.send(value))
          end
        end
      else
        raise TypeError, " Selection was a #{selection.class}, expecting a (Array,Hash)"
      end
      output
    end

end