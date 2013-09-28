# Embeditor

Embeditor is a set of client-side adapters for various embed codes. 
It aims to keep your article bodies clean while still allowing you 
to have rich embeds within them.

## Installation

It's a Rails engine. Add it to your Gemfile:

```ruby
gem 'embeditor'
```


## Usage

Embeditor works by replace `A` tags (eg. `<a href="...">Embed</a>`) with the
appropriate embed. There are several adapters included with this engine:

* **Embedly** - Covers several services, such as SoundCloud, Spotify,
  Facebook, Scribd, among others. Unfortunately, Embedly doesn't work perfectly
  all the time.
* **Cover It Live**
* **Document Cloud**
* **KPCC's Fire Tracker**
* **Rebel Mouse**

None of these are included automatically. To install just the ones you need,
add them to your `application.js` :

```javascript
//= include embeditor/adapters/embedly
//= include embeditor/adapters/cover_it_live
```

Or you can add all of them at once:

```javascript
//= require_tree ./embeditor/adapters/
```


## Extending

You can/should add your own adapters! It's easy, I promise. If you add one which
you think could be useful to a lot of people, please submit a PR and share the
wealth!
