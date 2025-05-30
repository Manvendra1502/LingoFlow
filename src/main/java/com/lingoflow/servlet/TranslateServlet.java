package com.lingoflow.servlet;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.lingoflow.utils.AppConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/translate")
public class TranslateServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(TranslateServlet.class.getName());
    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String sourceText = request.getParameter("sourceText");
        String sourceLang = request.getParameter("sourceLang");
        String targetLang = request.getParameter("targetLang");

        String translatedText;

        if (sourceText == null || sourceText.trim().isEmpty()) {
            translatedText = "Please enter text to translate.";
        } else {
            try {
                translatedText = translateWithOpenAI(sourceText, sourceLang, targetLang);
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error during translation", e);
                translatedText = "Error during translation: " + (e.getMessage() != null ? e.getMessage() : "Unknown error");
            }
        }

        request.setAttribute("translatedText", translatedText);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private String translateWithOpenAI(String text, String sourceLang, String targetLang)
            throws IOException, InterruptedException {

        String apiKey = AppConfig.get("api.key");

        if (apiKey == null || apiKey.isBlank()) {
            throw new IllegalStateException("API key not found in config.properties");
        }

        JsonObject systemMessage = new JsonObject();
        systemMessage.addProperty("role", "system");
        systemMessage.addProperty("content", "You are a professional translator. Translate the given text accurately from " + sourceLang + " to " + targetLang + ".");

        JsonObject userMessage = new JsonObject();
        userMessage.addProperty("role", "user");
        userMessage.addProperty("content", text);

        JsonArray messages = new JsonArray();
        messages.add(systemMessage);
        messages.add(userMessage);

        JsonObject requestBody = new JsonObject();
        requestBody.addProperty("model", "gpt-4o-mini");
        requestBody.add("messages", messages);
        requestBody.addProperty("temperature", 0.3);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(OPENAI_API_URL))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + apiKey)
                .POST(HttpRequest.BodyPublishers.ofString(requestBody.toString(), StandardCharsets.UTF_8))
                .build();

        HttpClient client = HttpClient.newHttpClient();
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        logger.info("OpenAI API Response status: " + response.statusCode());
        logger.info("OpenAI API Response body: " + response.body());

        if (response.statusCode() != 200) {
            try {
                JsonObject errorObj = JsonParser.parseString(response.body())
                        .getAsJsonObject()
                        .getAsJsonObject("error");
                String errorMessage = errorObj != null && errorObj.has("message") ? errorObj.get("message").getAsString() : "Unknown API error";
                throw new IOException("OpenAI API error: " + errorMessage);
            } catch (Exception e) {
                throw new IOException("OpenAI API request failed with status " + response.statusCode() + ": " + response.body());
            }
        }

        JsonObject jsonResponse = JsonParser.parseString(response.body()).getAsJsonObject();
        return jsonResponse.getAsJsonArray("choices")
                .get(0).getAsJsonObject()
                .getAsJsonObject("message")
                .get("content").getAsString().trim();
    }
}
