<p align="center">
  <img src="./assets/logos/logo.png?raw=true" width="200" alt="Meu Mengão Logo" />
</p>

<h1 align="center"> Meu Mengão </h1>

<p align="center">
<a href="https://play.google.com/store/apps/details?id=com.joaopegoraro.meu_mengao">
<img src="https://img.shields.io/badge/Download%20in%20Play%20Store-f39f37?style=social&logo=googleplay" alt="Download in Play Store" />
</a> 
</p>

<p align="center">
App with the latest Flamengo news, fixtures, results and standings, free and 
with no ads.
Made with Flutter, uses the 
<a href="https://github.com/joaopegoraro/meu-mengao-api">Meu Mengão API</a> 
as the backend.
</p>



#### PT-BR
Aplicativo com as últimas notícias, resultados e tabelas do Flamengo, 
gratuito e sem anúncios.
Feito em Flutter, utiliza o 
[Meu Mengão API](https://github.com/joaopegoraro/meu-mengao-api) como backend.

## Download
The app is available for free in the 
[Play Store](https://play.google.com/store/apps/details?id=com.joaopegoraro.meu_mengao).

## Screenshots
<p float="left">
  <img src="./screenshots/Screenshot1.png?raw=true" width="32%" />
  <img src="./screenshots/Screenshot2.png?raw=true" width="32%" />
  <img src="./screenshots/Screenshot3.png?raw=true" width="32%" />
</p>
<p float="left">
  <img src="./screenshots/Screenshot4.png?raw=true" width="32%" />
  <img src="./screenshots/Screenshot5.png?raw=true" width="32%" />
  <img src="./screenshots/Screenshot6.png?raw=true" width="32%" />
</p>

## Configuration
### API

The app is supposed to be used with the 
[Meu Mengão API](https://github.com/joaopegoraro/meu-mengao-api), which 
expects a valid Firebase Token when receiving requests. You can learn 
more about Firebase ID Tokens 
[here](https://firebase.google.com/docs/auth/admin/verify-id-tokens#retrieve_id_tokens_on_clients).

The App uses its own Firebase credentials to login anonymously to the 
Meu Mengão Firebase project to retrieve the Firebase ID Token that will 
be used to authenticate the requests made to the API. Therefore, the app 
expects to be linked to a Firebase Project, 
[like so](https://firebase.google.com/docs/flutter/setup).

If you plan on compiling the app to test it, you will either have to mock 
the requests, or build the 
[Meu Mengão API](https://github.com/joaopegoraro/meu-mengao-api) yourself.
The app expects a `BASE_URL` inside a `.env` file in the root of the project, 
so you must set it to the url of the API.


## Maintainers
This project is maintained by:
* [João Pegoraro](http://github.com/hahmraro)

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push your branch (git push origin my-new-feature)
5. Create a new Pull Request
