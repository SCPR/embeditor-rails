### 1.1.0 (unreleased)
#### Changes
* Added CoffeeScript to the dependencies. This was always a dependency, but now
  it's official.
* Replaced the `rails` dependency with only an `actionpack` dependency.


### 1.0.1 (2013-10-09)
* I accidentally built and pushed a gem with some missing files. This release
  fixes it.


### 1.0.0 (yanked)
#### Additions
* Added Brightcove adapter.
* Added RebelMouse adapter.

#### Changes
* Switched Facebook to use Embedly. This doesn't really change the behavior,
  because the dedicated Facebook adapter was swapping in the same code anyways.
* adapter's `wrapper` element is now created in the constructor, instead of
  when `this.embed()` is called.
* Polldaddy does some dark magic.


### 0.1.0 (2013-10-08)
* First usable relase. API is nearly stable. Any changes to the API will be
  documented from now on in the changelog.
