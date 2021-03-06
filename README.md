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

The following dependencies must be included manually. I hope to remove these
eventually.

* [jQuery](http://jquery.com/)
* [underscore.js](http://underscorejs.org/)


## Usage

**Note** Currently Embeditor (the JS library) exists only in this Rails plugin.
Eventually it will be extracted to a pure-JS library and this gem will be a
simple wrapper around it.

First, add `embeditor` and dependencies to your `application.js` manifest file:

```javascript
//= require jquery
//= require underscore
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

Embeditor works by replacing `A` tags with a specific class with the
appropriate embed. The default class is `embed-placeholder`, but that can be
configured.

There are several adapters included with this engine:

* **Embedly** - Covers several services, such as SoundCloud, Spotify, Scribd, Google
  Maps, and others. See
  [the list of Embedly's providers](http://embed.ly/embed/features/providers).
  Embedly doesn't always work perfectly, so Embeditor provides manual adapters
  for some of the providers that Embedly claims to support.
* **Cover It Live**
* **Polldaddy**
* **KPCC's Fire Tracker**
* **Instagram**
* **Facebook**
* **Twitter**
* **Storify**
* **Brightcove**
* **Document Cloud** - Not yet supported.
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

#### Embeditor

You can configure:

* `defaultAdapter` - The adapter that will be used if no adapter is found for
  the provided service.
* `defaultService` - The service that will be used if no service is provided
  on the placeholder link.
* `wrapperClass` - The class of the div that will get wrapped around the embed.
* `placeholderClass` - The class of the `<A>` tags that Embeditor will look for.


#### Embeds

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

The `display` object is for configuring display options. Properties:
* `placement` - the method to use for placing the embed, such as
  `before`, `after`, or `replace`. Default is `after`.

The `query` object is for configuring the query parameters, or in the case of
an adapter which doesn't use a query, it's for configuring the embed properties.

For the most part, everything will be pretty consistent.

```javascript
new Embeditor.Base({
    Embedly: {
        query: {
            maxheight: 450
        }
    },
    FireTracker: {
        query: {
            maxheight: 350
        },
        display: {
          placement: 'replaceWith'
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

There are also some Embeditor options you can configure:

* `defaultAdapter` - Adapter that gets used when the service isn't recognized.
  default: `Embedly`
* `defaultServer` - Service that gets used when the `data-service` attribute is
  missing. default: `other`
* `placeholderClass` - The class that the embed placeholders are given.
  default: `embed-placeholder`
* `wrapperClass` - The class the embed's wrapper is given.
  default: `embed-wrapper`
* `wrapperElement` - The element which should be wrapped around all embeds.
  default: `div`
* `defaultPlacement` - Default embed placement, if a placement is somehow
  missing or it doesn't exist in the PlacementFunctions object. default: `after`


#### Adapter-specific defaults

Finally, if you're writing an adapter, you should specify a `QueryDefaults`
object on the adapter, which will be used as a fallback for that adapter's
parameters:

```coffeescript
class Embeditor.Adapters.Twitter extends Embeditor.Adapter
    @QueryDefaults =
        maxheight: 500

    @DisplayDefaults =
        placement: 'before'

    # ...
```


### Embedly

Embedly requires an API key.
You can provide it in the `query` options for the Embedly adapter when
initializing `Embeditor.Base`:

```javascript
new Embeditor.Base({
    Embedly: {
        query: {
            key: 'YOUR_API_KEY'
        }
    }
})
```


### oEmbed vs. non-oEmbed

This library isn't necessarily tied to oEmbed, however it does have support for
it. Even for services which support oEmbed, there are static templates which
are able to render the embed properly just based off of the provided URL.
This eliminates any oEmbed headaches (Access-Control-Allowed-Origin, for
example), and also reduces the time it takes for an embed to load.


## CKEditor plugin

An unofficial CKEditor plugin can be found [HERE](https://github.com/SCPR/SCPRv4/blob/master/vendor/assets/javascripts/ckeditor/plugins/embed-placeholder/plugin.js).
Copy and paste it into your own repository.


## Extending

You can/should add your own adapters! It's easy, I promise. If you add one
which you think could be useful to a lot of people, please submit a PR and
share the wealth!

You can extend your adapter from:

* `Embeditor.Adapter`, which is the base adapter.
* `Embeditor.Adapters.Oembed`, for oEmbed endpoints.
* `Embeditor.Adapters.StaticTemplate`, for embeds where the embed code is
  stored in the `/templates` directory and rendered with JST.

**NOTE** Any function beginning with an underscore, like `_extractData()`,
should be considered a private function.


## Known Issues

* Cover It Live and Facebook embeds don't currently work together on the same
  page, due to a javascript conflict between the two.


## Contributing

If you have an adapter that you think would be useful for many, please open
up a pull request.
