# Embeditor

Embeditor is a set of client-side adapters for various embed codes. 
It aims to keep your article bodies clean while still allowing you 
to have rich embeds within them.

## Installation

It's a Rails engine. Add it to your Gemfile:

```ruby
gem 'embeditor'
```


## Dependencies

Currently, [`underscore.js`](http://underscorejs.org/) is a required dependency.
I hope to remove this dependency eventually.


## Usage

**Note** Currently Embeditor (the JS library) exists only in this Rails plugin.
Eventually it will be extracted to a pure-JS library and this gem will be a
simple wrapper around it.

First, add `embeditor` to your `application.js` manifest file:

```javascript
//= require embeditor
```

Next, initialize `Embeditor.Base` on any page where you want the swapping to
occur, and call its `swap()` function to perform the swapping:

```html
<script type="text/javascript">
    embeditor = new Embeditor.Base()
    embeditor.swap()
</script>
```

Embeditor works by replacing `A` tags (eg. `<a href="...">Embed</a>`) with the
appropriate embed. There are several adapters included with this engine:

* **Embedly** - Covers several services, such as SoundCloud, Spotify,
  Facebook, Scribd, among others. Unfortunately, Embedly doesn't work perfectly
  all the time.
* **Cover It Live**
* **Polldaddy**
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
//= require embeditor/adapters
```

You can also selectively require templates:

```javascript
//= require embeditor/templates/cover_it_live
```

... or require them all at once:

```javascript
//= require embeditor/templates
```

### Configuration

Embeditor offers a system of configuration precedence.
The order of precedence is:

1. `data-attributes` on the placeholder link itself.
2. Adapter-specific configuration in the `Embeditor.Base` object.
3. Global configuration on `Embeditor.Base`
4. Adapter-specific defaults.

#### data-attributes

You may add a `data-attribute` to any placeholder link, which will be used
in the query or embed code. This method of specifying configuration takes
precedence over any other configuration. The names of the data-attributes
get passed directly to the query or embed code (depending on the adapter).
Only the data-attributes which have to do with the embed will be passed through;
attributes like `data-service` won't be used.

In the following example, the `maxheight` property will be sent to the oembed
endpoint:

```html
<a href="http://projects.scpr.org/firetracker/oembed?url=http://projects.scpr.org/firetracker/rim-fire/" data-maxheight="450" class="embed-placeholder" data-service="firetracker">Rim Fire</a>
```

#### Adapter-specific configuration

When initializing the global `Embeditor.Base` object, you may specify
configuration for individual adapters.

The `plugin` object is for configuring the adapter.

The `query` object is for configuring the query parameters, or in the case of
an adapter which doesn't use a query, it's for configuring the embed properties.

For the most part, everything will be pretty consistent.

```javascript
new Embeditor.Base({
    Embedly: {
        query: {
            maxheight: 450
        },
        plugin: {
            key: '12345'
        }
    },
    FireTracker: {
        query: {
            maxheight: 350
        }
    },
    CoverItLive: {
        query: {
            maxheight: 500
        }
    }
})
```

#### Global configuration

You may also specify global configuration in `Embeditor.Base`, which will be
used for all adapters:

```javascript
new Embeditor.Base({
    maxheight: 450,
    maxwidth: 200
})
```

#### Adapter-specific defaults

Finally, if you're writing an adapter, you should specify a `QueryDefaults`
object on the adapter, which will be used as a fallback for that adapter's
parameters:

```coffeescript
class Embeditor.Adapters.Twitter extends Embeditor.Adapter
    @QueryDefaults =
        maxheight: 500

    # ...
```


### Embedly

Embedly requires a key. You can provide it while initializing `Embeditor.Base`:

```javascript
new Embeditor.Base({
    Embedly: {
        plugin: {
            key: '12345'
        }
    }
})
```


### oEmbed vs. non-oEmbed

This library isn't necessarily tied to oEmbed, however it does has support for
it. Even for services which support oEmbed, there are static templates which
are able to render the embed properly just based off of the provided URL.
This eliminates any oEmbed headaches (Access-Control-Allowed-Origin, for
example), and also reduces the time it takes for an embed to load.



## Extending

You can/should add your own adapters! It's easy, I promise. If you add one
which you think could be useful to a lot of people, please submit a PR and
share the wealth!

You can extend your adapter from:

* `Embeditor.Adapter`, which is the base adapter.
* `Embeditor.Adapters.Oembed`, for oEmbed endpoints.
* `Embeditor.Adapters.StaticTemplate`, for embeds where the embed code is
  stored in the `/templates` directory and rendered with JST.
