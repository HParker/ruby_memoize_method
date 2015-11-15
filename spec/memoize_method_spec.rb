$LOAD_PATH.unshift(File.expand_path('../lib', File.dirname(__FILE__)))

require 'memoize_method'

class ExampleClass
  extend MemoizeMethod

  def initialize(expensive_thing_doer)
    @expensive_thing_doer = expensive_thing_doer
  end
  cache def foo(extra, c: 20)
    @expensive_thing_doer.do_expensive_thing(c)
  end
end

describe MemoizeMethod do
  it 'does not call bar more than once' do
    expensive_thing_doer = spy('expensive_thing_doer')
    allow(expensive_thing_doer).to receive(:do_expensive_thing) { Time.at(1) }
    example = ExampleClass.new(expensive_thing_doer)

    expect(example.foo('blah', c: 10)).to eq(Time.at(1))
    expect(example.foo('blah', c: 10)).to eq(Time.at(1))
    expect(expensive_thing_doer).to have_received(:do_expensive_thing).with(10).once
  end

  it 'will continue to return the recomputed value after recomputing' do
    expensive_thing_doer = spy('expensive_thing_doer')
    allow(expensive_thing_doer).to receive(:do_expensive_thing) { Time.now }
    example = ExampleClass.new(expensive_thing_doer)

    initial_value = example.foo('blah')

    expect(example.foo('blah')).to eq(initial_value)

    new_value = example.recompute_foo('blah')
    expect(new_value).to_not eq(initial_value)
    expect(example.foo).to eq(new_value)
  end
end
