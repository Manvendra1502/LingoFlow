
# LingoFlow

LingoFlow is a web application that provides language translation services using OpenAI's API.

## Features

- Translate text between multiple languages
- Simple and intuitive web interface
- Uses OpenAI API for translation tasks
- Built with Java, Maven, Jakarta Servlet API, and Gson

## Prerequisites

- Java 21 or higher
- Apache Maven
- An OpenAI API key (keep this secret)

## Setup and Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Manvendra1502/LingoFlow.git
   cd LingoFlow
2. Configure API key:

Rename src/main/resources/config.properties.example to config.properties and add your OpenAI API key:
api.key=your_openai_api_key_here

3. Build project
   mvn clean package 

4.Deploy the WAR file:

The build produces target/lingoflow.war. Deploy this WAR file on a servlet container like Apache Tomcat 10.

5. Access the app:

Open your browser and navigate to http://localhost:8080/lingoflow (depending on your server configuration).

3  
