# README

# TrailSync

TrailSync is a Rails application for outdoors enthusiasts, built as an experiment in leveraging LLMs to explore frameworks I’m less familiar with, such as Hotwire and Tailwind CSS. While the implementation may not always follow conventional patterns, the project integrates the National Park Service API and serves as a hands-on learning ground for AI-assisted development.

## Features

- Rails foundation with Hotwire (Turbo Frames, Turbo Streams) + Tailwind CSS
- Integration with the National Park Service API for fetching park and trail data
- Built as a learning sandbox to explore and prototype with AI coding tools (e.g., GitHub Copilot, Cline)
- Designed to evolve—new features and enhancements planned

## Tech Stack & Tools

| Component                | Details                                      |
|--------------------------|----------------------------------------------|
| **Framework**            | Ruby on Rails                                |
| **Front-end Tools**      | Hotwire (Turbo Frames/Streams), Tailwind CSS |
| **API Integration**      | National Park Service API                    |
| **AI Coding Tools Used** | GitHub Copilot, Cline                        |

## Getting Started

### Prerequisites

- Ruby (version as per `.ruby-version`)
- Rails (check `Gemfile`)
- PostgreSQL (or your chosen DB)
- Bundler (`gem install bundler`)

### Setup

```bash
# Clone the repo
git clone https://github.com/isabella-sandoval/TrailSync.git
cd TrailSync

# Install dependencies
bundle install
yarn install   # if using JS assets via webpack or importmap

# Configure database
rails db:create
rails db:migrate
```

### Environment Variables
```bash
Create a .env file (or use credentials.yml.enc) and add:

NPS_API_KEY=your_national_park_service_api_key_here
```
Replace your_national_park_service_api_key_here with your actual API key from https://www.nps.gov/subjects/developer/index.htm

### Running the App Locally
```bash
rails server
```
Visit http://localhost:3000

### Usage Overview

- Explore interactive park/trail data, enhanced by Turbo Frames and Tailwind’s responsive styling
- Use interface patterns powered by Hotwire for a smooth, SPA-like experience

# Future Enhancements
- Add search functionality for parks by location or keywords
- Display trail maps and details using mapping libraries
- Build out favorites, user profiles, or save listings
- Incorporate additional National Park Service endpoints (alerts, events, ranger info)
- Deepen AI tool integration—e.g., use Copilot for test generation, Cline for query refinement


