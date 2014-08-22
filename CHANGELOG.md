## 2.0.1
* Updated Fire Tracker adapter to adopt new URL scheme.

## 2.0.0
#### Additions
* Added `Adapter#service`, which reads from the `data-service` attribute.
* The wrapper element now gets the service added to it as a class. A YouTube
  embed will have a wrapper class `youtube`, for example.
* You can now specify the default placement for embeds when initializing
  Embeditor, via the `defaultPlacement` option.
* The element that gets wrapped around embeds can also be specified, via the
  `wrapperElement` option. This should be an element name, such as `div`,
  `p`, `span`, etc.
* Added support for `photo` oEmbed type.

#### Changes
* Removed Plugin options.
* [BREAKING] Embedly now uses the Oembed adapter. `embedly.jquery` is no longer a
  dependency. Your API Key should be specified as a `query` option, not
  `plugin`. For example:

```javascript
new Embeditor.Base({
    Embedly: {
        query: { key: 'YOUR_API_KEY' }
    }
})
```

#### Fixes
* Fixed a bug where an embed wouldn't render if its `data-placement` attribute
  wasn't found in the PlacementFunctions object.


## 1.1.1
#### Changes
* Minor internal cleanup


## 1.1.0
#### Additions
* Added `display` options. Currently the only one that does anything is
  `placement`, which allows you to decide where to place the embed relative
  to the placeholder link. See README for more information.

#### Changes
* Added CoffeeScript to the dependencies. This was always a dependency, but now
  it's official.
* Replaced the `rails` dependency with only an `actionpack` dependency.

#### Fixes
* Fixed a bug when merging defaults together, where empty strings weren't
  being overwritten.

#### Deprecations
* `Adapter#dataOptions` is deprecated with no replacement.
  Use `Adapter#queryParams` and `Adapter#display` to get the data options.


## 1.0.1
* I accidentally built and pushed a version (1.0.0) with some missing files.
  This release fixes it.


## 1.0.0 (yanked)
#### Additions
* Added Brightcove adapter.
* Added RebelMouse adapter.

#### Changes
* Switched Facebook to use Embedly. This doesn't really change the behavior,
  because the dedicated Facebook adapter was swapping in the same code anyways.
* adapter's `wrapper` element is now created in the constructor, instead of
  when `this.embed()` is called.
* Polldaddy does some dark magic.


## 0.1.0
* First usable relase. API is nearly stable. Any changes to the API will be
  documented from now on in the changelog.
