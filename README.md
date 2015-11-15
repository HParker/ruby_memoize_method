# MemoizeMethod

Memoize Method lets you memoize the return value of methods methods with a single word.

```ruby
cache def my_expensive_computation
  ...
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'memoize_method'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install memoize_method

## Usage

You are going to want to extend MemoizeMethod in your class

```ruby
class A
  extend MemoizeMethod
end

irb> A.methods - Object.methods
=> [:cache]
```

Now lets cache our method.

```ruby
class A
  extend MemoizeMethod
  cache def foo
    Time.now
  end
end

irb> A.new.methods - Object.new.methods
=> [:foo, :cacheless_foo, :recompute_foo]
```

Now you have 3 methods where you defined `foo`,
- `foo` is will compute the first time, then cache after that.
- `cacheless_foo` lets you get at the current value without busting the cache.
- `recompute_foo` will bust the cache and assign it to the new value.

Example:
```ruby
irb> a = A.new
=> #<A:0x007f98212599f8>
irb> a.foo
=> 2015-11-15 10:38:09 -0800
irb> a.foo
=> 2015-11-15 10:38:09 -0800
irb> a.foo == a.foo
=> true
irb> a.cacheless_foo
=> 2015-11-15 10:38:41 -0800
irb> a.cacheless_foo != a.foo
=> true
irb(main):018:0> a.recompute_foo
=> 2015-11-15 10:41:01 -0800
irb(main):019:0> a.foo
=> 2015-11-15 10:41:01 -0800
irb(main):020:0> a.recompute_foo == a.foo
=> true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hparker/memoize_method.
