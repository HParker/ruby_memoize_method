require "memoize_method/version"

module MemoizeMethod
  def cache(method)
    cacheless_method = "cacheless_" + method.to_s
    recompute_method = "recompute_" + method.to_s
    cache_var = "@" + method.to_s + "_cache"
    alias_method cacheless_method, method
    define_method(method) { |*args|
      instance_eval(cache_var) ||
        instance_eval("#{cache_var} ||= send(cacheless_method, *args)")
    }

    define_method(recompute_method) { |*args|
      instance_eval("#{cache_var} = send(cacheless_method, *args)")
    }
  end
end
