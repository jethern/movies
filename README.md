# Movies
This is a simple [Movie DB](https://www.themoviedb.org) client for iPhones written in Swift.
I use it mostly to try out new ideas and technologies.


## Instalação

### Set ApiKey - https://www.themoviedb.org

To configure an ApiKey on your request API, you can edit directly in the Info.plist in the MovieApiKey key.

### Slather - Relatório de Cobertura

Add this line to your application's Gemfile:

```ruby
gem 'slather'
```

And then execute:

```sh
$ bundle
```

Or install the gem:

```sh
gem install slather
```

## Usage

To verify you're ready to generate test coverage, run your test suite on your project, and then run:

```sh
$ slather coverage -s --scheme Movies Movies.xcodeproj
```

To generate html use:

```sh
$ slather coverage --html --scheme Movies Movies.xcodeproj
```

To open the html reports, use


```sh
open '/Project_Folder/html/index.html'
```


or use '--show' flag to open it automatically.
