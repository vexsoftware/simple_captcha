# SimpleCaptcha

This is Vex Software's fork of SimpleCaptcha that uses the session store rather than the database based on SimpleCaptcha.

## Requirements

In order to use SimpleCaptcha, the following is needed:

* [Ruby](http://ruby-lang.org/) >= 1.8.7
* [Rails](http://github.com/rails/rails) >= 3
* [ImageMagick](http://www.imagemagick.org/script/index.php) >= 6.6

## Installation

```ruby
gem 'simple_captcha', :git => 'git://github.com/vexsoftware/simple_captcha.git'
```

## Usage

### Controller/View Based

In the view file within the form tags add this code:

```ruby
<%= show_simple_captcha %>
```

And in the controller's action, validate it with:

```ruby
if simple_captcha_valid?
  # Code for valid answers.
else
  # Code for invalid answers.
end
```

### Model Based

In the view file within the form tags write this code:

```ruby
<%= show_simple_captcha(:object => "user") %>
```

And in the model add:
```ruby
apply_simple_captcha
```

#### FormBuilder Helper

In addition to the previous example, SimpleCaptcha can also be used along with FormBuilder.

```ruby
<%= form_for @user do |f| %>
  ...
  <%= f.simple_captcha :label => "Enter numbers..." %>
  ...
<% end %>
```

#### Validating with CAPTCHA

Using `valid_with_captcha?` will validate the model instance along with the CAPTCHA response.  
The original `valid?` method is not overridden.

```ruby
@user.valid_with_captcha?
```

#### Saving with CAPTCHA

Using `save_with_captcha` will save the model instance along with validating the CAPTCHA response.  
The original `save` method is not overridden.

```ruby
@user.save_with_captcha
```

### Formtastic Integration
SimpleCaptcha detects if you are using Formtastic and appends `SimpleCaptcha::CustomFormBuilder`.

```ruby
<%= form.input :captcha, :as => :simple_captcha %>
```

## Options

### View

These options can be passed to the view helper.

* `:label` - provides the custom text b/w the image and the text field, the default is "type the code from the image"
* `:object` - the name of the object of the model class, to implement the model based captcha.
* `:code_type` - return numeric only if set to 'numeric'

### Global

These options can be configured using an initializer.

* `image_style` - provides the specific image style for the captcha image.  
There are eight different styles available with this gem:

  * `simply_blue`
  * `simply_red`
  * `simply_green`
  * `charcoal_grey`
  * `embosed_silver`
  * `all_black`
  * `distorted_black`
  * `almost_invisible`

The default style is `simply_blue`.  
You can also specify `random` to select the random image style.

* `distortion` - handles the complexity of the image. Distortion can be set to `low`, `medium` or `high`. The default is `low`.

An example initializer file:

```ruby
SimpleCaptcha.setup do |sc|
  # default: 100x28
  sc.image_size = '120x40'

  # default: 5
  sc.length = 6

  # default: simply_blue
  # possible values:
  # 'embosed_silver',
  # 'simply_red',
  # 'simply_green',
  # 'simply_blue',
  # 'distorted_black',
  # 'all_black',
  # 'charcoal_grey',
  # 'almost_invisible'
  # 'random'
  sc.image_style = 'simply_green'

  # default: low
  # possible values: 'low', 'medium', 'high', 'random'
  sc.distortion = 'medium'
end
```

You can add your own style:

```ruby
SimpleCaptcha.setup do |sc|
  sc.image_style = 'mycaptcha'
  sc.add_image_style('mycaptcha', [
      "-background '#F4F7F8'",
      "-fill '#86818B'",
      "-border 1",
      "-bordercolor '#E0E2E3'"
  ])
end
```

You can provide the path where ImageMagick is installed as well:

```ruby
SimpleCaptcha.setup do |sc|
  sc.image_magick_path = '/usr/bin' # Find the path by running: which convert
end
```

You can provide the path where temp files should be stored.
It's useful when you are not able to use the default temp directory.

```ruby
SimpleCaptcha.setup do |sc|
  sc.tmp_path = Rails.root.join('tmp/simple_captcha').to_s
end
```


## Styling

To style SimpleCaptcha, use `.captcha` in your application's stylesheet. For further customization, you can generate the partial into your application by using:

```
rails g simplecaptcha:partial
```

The partial will be generated to `app/views/simple_captcha/_captcha.erb`.


## I18n
SimpleCaptcha supports I18n. It has the ability to use a different error message for different models.

```yaml
simple_captcha:
  message:
    default: "The answer to the CAPTCHA was incorrect."
    user: "Sorry, but your answer to the CAPTCHA wasn't correct."
```

## Credits

This is a fork of the [Rails 3 version of SimpleCaptcha](https://github.com/galetahub/simple-captcha) by Vex Software.  
The original plugin is located at http://expressica.com/simple_captcha which was created by [Sur](http://expressica.com)

## License

The original plugin is released under the MIT license by [Sur](http://expressica.com).