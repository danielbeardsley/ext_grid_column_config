module ExtGridColumnConfig
  def self.included(model)
    model.send(:extend, ClassMethods)
    model.send(:include, InstanceMethods)
    model.class_eval do
      cattr_accessor :grid_columns
    end
    model.grid_columns = []
  end

  ##
  # InstanceMethods
  #
  module InstanceMethods

  end
  ##
  # ClassMethods
  #
  module ClassMethods
    def ext_grid_columns(columns, options = {})
      self.grid_columns = columns
    end

    def ext_grid_column_config(options = {})
      columns = self.grid_columns

      if(options[:only])
        columns = columns.select {|col| options[:only].include?(col[:dataIndex].to_sym)}
      elsif(options[:except])
        columns = columns.select {|col| !options[:except].include?(col[:dataIndex].to_sym)}
      end
      columns
    end
  end
end
