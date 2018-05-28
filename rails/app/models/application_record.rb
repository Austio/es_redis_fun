class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # TODO maybe pull as epochable?
  def method_missing(*args)
    method_name = args.first.try(:to_s).try(:split, '_')

    if method_name.try(:first) == 'epoch'
      method_name.shift
      original_method = method_name.join('_')
      original_val = send(original_method)

      return original_val.to_time.to_i
    end

    super
  end
end
