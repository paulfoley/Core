# Core
Repository for Core Project


## Getting Started

I think most of you are using windows so I enabled Docker support which will hopefully make it easier for you guys to get started.

If you aren't familier with Docker it is a container technology that lets you quickly deploys apps.
You can download the [Docker Toolbox](https://www.docker.com/products/docker-toolbox) to get started.
Once you have docker intalled you should be able to make a machine, and start the app with a postgres db by doing:

    docker-compose up

You will need to create and run database migrations by doing this:

    docker-compose run web rake db:create db:migrate

I have brought in Devise and Omniauth for authentication and API access. I have added Stripe and Quickbooks integrations as well.
We should start with Stripe, Quickbooks still needs some work.

