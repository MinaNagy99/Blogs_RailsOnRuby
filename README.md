# Rails Project with Docker

This project is a Ruby on Rails application that includes articles and comments with authentication using JWT (JSON Web Tokens). 

## Getting Started

To get started with this project, follow these steps:

### Prerequisites

Make sure you have the following installed on your machine:

- [Docker Desktop](https://www.docker.com/products/docker-desktop)

### Installation

1. **Clone the repository:**

    ```sh
    git clone https://github.com/MinaNagy99/Blogs_RailsOnRuby
    cd Blogs_RailsOnRuby
    ```

2. **Build the Docker containers:**

    ```sh
    docker-compose build
    ```

3. **Start the Docker containers:**

    ```sh
    docker-compose up
    ```

4. **Start the Rails server:**

    ```sh
    docker-compose exec web rails server -b 0.0.0.0
    ```

### Usage

- The application should now be running on [http://localhost:3000](http://localhost:3000).
- You can create, read, update, and delete articles and comments.
- Authentication is handled using JWT. 

### Stopping the Application

To stop the Docker containers, run:

```sh
docker-compose down
