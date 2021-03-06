Mxit Rails
==========

A gem that includes a simple and opinionated templating framework for Rails-based Mxit apps.
This includes a rough layout, support for styles similar to CSS classes, wrapped inputs, and
an elegant way to support Mxit's conversation-based interface.

Later versions will also include wrappers for important Mxit APIs.

Sample App
----------
A basic to-do app has been set up as an example of the gem in use.  It can be seen at [mxit-to-do](https://github.com/linsen/mxit-to-do).

Installation
------------
To use the gem, just include the gem your rails projects' gemfile:

    gem 'sass-rails'

The newest version is 0.1.2 - it is not recommended to use any earlier versions.

Basic usage
-----------
To set up a controller to use the gem, you need to include the `MxitRails::Page` module:

    include MxitRails::Page

This creates a few helper methods that can be used within that controller

- `input input_name, input_label` - Define the page's input field with a name (symbol) and text label
- `validate type, [parameter], message` - Set up validations on the input field.
- `validate message, &block` - A custom message with a block providing a `true` (valid) or `false` (invalid) value.  
  Note that the block must not use a `return` statement
- `submit &block` - A code block that will only be executed if the input was submitted and passed all validations.

### Validations
Currently the following validations are available:
- `:not_blank`
- `:numeric`
- `:length, exact_length`
- `:min_length, min`
- `:max_length, max`


Multi-step forms
----------------
The gem allows the easy set up of multi-step forms within a single controller action.  Forms are defined as follows:

    form do
      step :first do
        ...
      end
      step :second do
        ...
      end
    end

The order in which steps are defined will be the order they are presented to users in.  Each step should have its own view file, in
`app/views/controller/action/step`.  Each step has access to the same helper methods as the controller itself.  For steps that don't
have an input field, a `proceed` helper method is provided

- `proceed message` - Show a proceed link rather than a form input

Users will only proceed to the next step in the form if all validations of the previous step pass.

If the action has a `submit` block (defined outside of the `form`), it will only be executed after the last step is completed.


Styles
------
Mxit-rails has a basic styling engine that functions similarly to CSS classes.  Styles are identified by a symbol, 
and can be declared in any controller with the `mxit_style` macro.  It is recommended to declare them in application controller.

    mxit_style :author, 'background-color:#F8F3EA; color:#000000'

To include a style in a template, use the `mxit_style` helper method.  Any number of styles can be given as parameters to this method.

    <p style="<%= mxit_style :author %>">Lewis Carroll</p>

The following special styles are used in the overall layout, and it is thus recommended that they be defined.  Note that links can only be styled per-page, not per link.

- `:body` - The page body (`body` element in html)
- `:title` - The page title
- `:link` - The colour of links in the page
- `:link_hover` - The colour and background colour of highlighted links.


Layout
------
The gem currently includes a default layout that has a title bar, an optional navigation link, and a form input below the body where appropriate.
The title and navigation should be defined with `content_for` blocks, addressing `:title` and `:navigation` respectively.


Emulator
--------
The mxit-rails gem is provided with an emulator to aid development.  It can be accessed at `/emulator`.  The url will dynamically update to show
the current URL of the page shown as a suffix, e.g. `emulator/path_to/page`.  Certain parts of the app can similarly be loaded directly by
navigating to their corresponding URL.

To set the root URL of the emulator, add the following line to `config/application.rb`:

    config.mxit_root = 'mxit'
