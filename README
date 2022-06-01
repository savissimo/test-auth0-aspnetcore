## Auth0 integration into ASP.NET 6 test

I've had an issue when I tried to integrate Auth0's login flow into my .NET 6 web application. This repository is a minimal reproduction of that issue. 

### Describe the problem

The redirect URI always uses HTTP instead of HTTPS. As a consequence, the login page fails to load, since the redirect URI is not among the allowed ones. 

### What was the expected behavior?

The redirect URI follows the scheme of the URL of the document the request came from, or it should be possible to specify the scheme.  per request. 

### Reproduction

- I followed the Quickstart guide for .NET Core MVC. Everything works in local dev, even if I use a custom DNS name instead of `localhost`. 
- I dockerized the project and deployed the container on to Heroku. 
- Visit (http://test-auth0-ss.herokuapp.com) to see a public page. Go to `/account/profile` (not linked in the page) to request a page that needs authorizations. 
- You'll be redirected to (https://4funsimracing.eu.auth0.com/authorize), but the `redirect_uri` field causes the issue. 

### Environment

- `Auth0.AspNetCore.Authentication` version 1.0.3
- .NET 6
- No dependency is involved in the authentication/authorization flow. 
