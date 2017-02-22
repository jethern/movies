# Movies
This is a simple [Movie DB](https://www.themoviedb.org) client for iPhones written in Swift.
I use it mostly to try out new ideas and technologies.


## Instalação


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

Para exibir o html

```sh
$ slather coverage --html --scheme Movies Movies.xcodeproj
```

To open the html reports, use


```sh
open '/Project_Folder/html/index.html'
```


or use '--show' flag to open it automatically.
