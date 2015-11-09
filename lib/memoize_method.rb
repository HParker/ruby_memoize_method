require "memoize_method/version"

module MemoizeMethod
  def cache(method)
    recompute_method = "recompute_" + method.to_s
    cache_var = "@" + method.to_s + "_cache"
    alias_method recompute_method, method
    define_method(method) { |*args|
      instance_eval(cache_var) ||
        instance_eval("#{cache_var} ||= #{send(recompute_method, *args)}")
    }
  end
end
