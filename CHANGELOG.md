### 0.2.0 (unreleased)
#### Additions
* Added Brightcove adapter.
* Added RebelMouse adapter.
* Added DocumentCloud adapter.

#### Changes
* Switched Facebook to use Embedly. This doesn't really change the behavior,
  because the dedicated Facebook adapter was swapping in the same code anyways.
* adapter's `wrapper` element is now created in the constructor, instead of
  when `this.embed()` is called.
* Polldaddy does some dark magic.


### 0.1.0 (2013-10-08)
* First usable relase. API is nearly stable. Any changes to the API will be
  documented from now on in the changelog.
