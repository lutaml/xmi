# 04: Pipeline Hash Mutation

## Impact: LOW (saves 4 intermediate Hash allocations per parse)

## Problem

Each pipeline step returns `ctx.merge(key: value)` creating intermediate Hash objects.

## Fix

Use `ctx[:key] = value` mutation instead:

```ruby
# Before
def self.call(ctx)
  xml = ctx[:xml]
  # ...process...
  ctx.merge(xml: fixed_xml)

# After
def self.call(ctx)
  xml = ctx[:xml]
  # ...process...
  ctx[:xml] = fixed_xml
  ctx
end
```

## Files

- `lib/xmi/parser_pipeline.rb` — all 4 step modules
