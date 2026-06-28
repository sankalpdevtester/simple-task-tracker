# Simple Task Tracker App
A simple task tracking web app for individuals to manage their daily tasks and to-do lists.

## Badges
[![Language](https://img.shields.io/badge/language-Ruby%20on%20Rails%207-blue)](https://rubyonrails.org/)
[![License](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/licenses/MIT)

## What it does
The Simple Task Tracker App is designed to help individuals manage their daily tasks and to-do lists efficiently. It allows users to create and assign tasks, track due dates, and mark tasks as completed. This app provides a user-friendly interface for users to stay organized and focused on their tasks.

## Features
* User authentication
* Task creation
* Task assignment
* Due date tracking
* Task completion status

## Requirements
* Ruby 3.1.2
* Rails 7.0.4
* React 18.2.0
* PostgreSQL 14.5
* Node.js 16.17.0
* Yarn 1.22.17

## Installation
To install the required dependencies, run the following commands:
```bash
bundle install
npm install
```

## Usage
To start the development server, run the following command:
```bash
rails s
```
This will start the server on `http://localhost:3000`. You can access the app by visiting this URL in your web browser.

Example usage:
* Create a new task: `curl -X POST -H "Content-Type: application/json" -d '{"task": {"title": "New Task", "due_date": "2024-09-17"}}' http://localhost:3000/tasks`
* Get all tasks: `curl -X GET http://localhost:3000/tasks`
* Update a task: `curl -X PATCH -H "Content-Type: application/json" -d '{"task": {"title": "Updated Task"}}' http://localhost:3000/tasks/1`

## Environment Variables
| Variable | Description |
| --- | --- |
| `DATABASE_URL` | PostgreSQL database URL |
| `RAILS_ENV` | Rails environment (development, production, test) |
| `SECRET_KEY_BASE` | Secret key base for Rails |
| `REACT_APP_API_URL` | API URL for React app |

## Project Structure
```markdown
simple-task-tracker-app/
├── app
│   ├── assets
│   ├── controllers
│   ├── models
│   ├── views
│   └── ...
├── config
│   ├── application.rb
│   ├── database.yml
│   ├── environments
│   └── ...
├── db
│   ├── migrate
│   ├── schema.rb
│   └── ...
├── node_modules
│   └── ...
├── public
│   ├── index.html
│   └── ...
├── spec
│   ├── controllers
│   ├── models
│   ├── requests
│   └── ...
├── vendor
│   └── ...
├── package.json
├── Gemfile
├── Gemfile.lock
├── README.md
└── ...
```

## Contributing
Contributions are welcome! To contribute to this project, please follow these steps:
1. Fork the repository
2. Create a new branch for your feature or bug fix
3. Commit your changes with a descriptive message
4. Open a pull request against the main branch

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.