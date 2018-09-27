# Astro Forms

[![Bitrise App Page](https://app.bitrise.io/app/11b5791a9dab5b3c/status.svg?token=jFpCmx9nwy200940OcGbqA&branch=master)](https://app.bitrise.io/app/11b5791a9dab5b3c) [![Astro Forms Documentation](https://github.com/plummer/astro-docs/blob/master/assets/docs-button.png)](https://www.astroforms.com)

[![Astro Forms is an approachable iOS forms framework for building beautiful, reusable and easy to maintain forms. Type Safe Row Access, Validation, Manage Multiple Themes, Custom Focus Rects, Keyboard Management](https://github.com/plummer/astro-docs/blob/master/assets/main-repo-readme-header.jpg)](https://www.astroforms.com)

## Getting Started

For a getting started guide, reference docs and included forms, head to the [documentation](https://www.astroforms.com). 

Want to dive right in?

```ruby
pod install 'AstroForms'
```

## What is Astro Forms?

Astro Forms is a framework that provides the structure to build your own highly custom and reusable forms for a project. In this way it's different to other frameworks - it's specifically _not_ a drop in set of subclassable elements or abstraction around UIKit. Instead, it's a set of protocols and a minimum of abstract classes you compose to build _your_ forms. This is an opinionated way of doing things, however you'll have far less code (less 🐛s) and far more flexibility for anything but trivial stock-standard looking forms.

### Talk straight - what is a `Form`?

It's a `UIView` subclass that contains a single `UIStackView` - it controls rendering, show/hide, validation and all the other form like features you might need.

### ... and a `Row`?

It's a class that conforms to various `Row` protocols (`ValueRow`, `FocusableRow`...) so it can interact with it's `Form`, plus a plain old `UIView` and a Nib.

## Examples

For a getting started guide, reference docs and a info on the included forms, head to the [documentation](https://www.astroforms.com). 

If you'd prefer to read the code, here's an [example login form](https://github.com/plummer/astro-forms/blob/master/Example/AstroForms/GUI/Features/Login/LoginForm.swift) and [text field row](https://github.com/plummer/astro-forms/tree/master/Example/AstroForms/GUI/Shared/Forms/Rows/TextFieldRow).

As a basic overview however to give you an idea of what it's like to use Astro Forms:

### Rendering a row

Rendering a row is as simple as giving it a tag and configuring it's view:

```swift
let emailRow = TextFieldRow(tag: LoginFormTag.email) {
  $0.view.label.text = "Email"
  $0.view.textField.placeholder = "example@astroforms.com"
  $0.view.textField.keyboardType = .emailAddress
  $0.view.textField.autocorrectionType = UITextAutocorrectionType.no
}

// inside a Form subclass
add(emailRow)
```
You can see the implementation for this row [here](https://github.com/plummer/astro-forms/tree/master/Example/AstroForms/GUI/Shared/Forms/Rows/TextFieldRow).

### Finding a row

Finding a row is easy and type safe:

```swift
let emailRow: TextFieldRow? = findRow(tag: LoginFormTag.email)
```

The value is typed for every row too:

```swift
let stringValue = emailRow?.value
```

`RowTag` implementations can have associated values, so dynamic row rendering and access is easy too:

```swift
let addressLine4Row: TextFieldRow? = findRow(tag: LoginFormTag.custom("address-line-4"))
```

### Validating a row

Forms can validate rows with a convenient block-chaining syntax:

```swift
let isValid: Bool = validate(
	row: emailRow,
	{ $0.count > 0 } // The rows typed value (String) is passed into each validation block
	{ $0.contains "@" }
)
```

A build in factory provides validation methods that can be extended for reusability. For example, instead of the (hilariously poor) email validation above, `ValidationRule.isEmail` is built in. This can be mixed with inline rules.


```swift
let isValid: Bool = validate(
	row: emailRow,
	{ $0.count > 0 } // The rows typed valued is passed into each validation block
	ValidationRule.isEmail
)
```