# Gem Building Workflow

This document describes the workflow for building, installing, and releasing the ISBN Field gem.

## Prerequisites

- Ruby (version 2.5.0 or higher)
- Bundler

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Jedt3D/isbn_field.git
   cd isbn_field
   ```

2. Install dependencies:
   ```bash
   bin/setup
   ```

## Development

1. Run the tests to ensure everything is working:
   ```bash
   bundle exec rake spec
   ```

2. Start an interactive console to experiment with the gem:
   ```bash
   bin/console
   ```

## Building the Gem

To build the gem locally:

```bash
bundle exec rake build
```

This will create a `.gem` file in the `pkg` directory.

## Installing the Gem Locally

To install the gem on your local machine:

```bash
bundle exec rake install
```

## Releasing a New Version

1. Update the version number in `lib/isbn_field/version.rb`.

2. Update the `CHANGELOG.md` (if you have one) to document the changes.

3. Commit your changes:
   ```bash
   git add .
   git commit -m "Release version X.Y.Z"
   ```

4. Release the gem:
   ```bash
   bundle exec rake release
   ```

   This will:
   - Create a git tag for the version
   - Push git commits and the created tag
   - Push the `.gem` file to [rubygems.org](https://rubygems.org)

## Continuous Integration

Consider setting up a CI pipeline (e.g., GitHub Actions, Travis CI) to automatically run tests and build the gem on each push.

## Gem Structure

The gem follows the standard Ruby gem structure:

- `lib/`: Contains the gem's code
  - `lib/isbn_field.rb`: The main entry point for the gem
  - `lib/isbn_field/version.rb`: Contains the gem's version number
- `bin/`: Contains executable scripts
  - `bin/setup`: Sets up the development environment
  - `bin/console`: Provides an interactive console for experimenting with the gem
- `spec/`: Contains the gem's tests
- `Rakefile`: Contains tasks for building, testing, and releasing the gem
- `Gemfile`: Specifies the gem's dependencies
- `isbn_field.gemspec`: Contains metadata about the gem