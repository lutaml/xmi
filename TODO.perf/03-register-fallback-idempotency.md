# 03: Register Fallback Idempotency Guard

## Impact: MEDIUM (prevents cache invalidation on every parse)

## Problem

`extend_fallback_for_mixed_namespaces` is called on every `parse_xml` for mixed-namespace documents. It calls `primary_register.add_fallback(reg.id)` which invalidates internal caches even when the fallback was already added on a previous parse.

## Fix

Add a guard before calling `add_fallback`:

```ruby
next if primary_register.fallback.include?(reg.id)
primary_register.add_fallback(reg.id)
```

## Files

- `lib/xmi/namespace_detector.rb` or `lib/xmi/version_registry.rb` — find where `extend_fallback_for_mixed_namespaces` is called and add the guard
