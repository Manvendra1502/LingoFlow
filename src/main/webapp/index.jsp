<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Language Translator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }
        .language-selectors {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px;
        }
        select, button {
            padding: 10px;
            font-size: 16px;
        }
        .translation-boxes {
            display: flex;
            width: 100%;
            max-width: 1000px;
            justify-content: space-between;
        }
        textarea {
            width: 45%;
            height: 300px;
            padding: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
        }
        button.translate {
            margin-top: 20px;
            padding: 10px 30px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button.translate:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Language Translator</h2>
    <form method="post" action="translate">
        <div class="language-selectors">
            <select name="sourceLang" required>
                <option value="en" <%= "en".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>English</option>
                <option value="hi" <%= "hi".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Hindi</option>
                <option value="fr" <%= "fr".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>French</option>
                <option value="es" <%= "es".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Spanish</option>
                <option value="de" <%= "de".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>German</option>
                <option value="ru" <%= "ru".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Russian</option>
                <option value="zh" <%= "zh".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Chinese</option>
                <option value="ar" <%= "ar".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Arabic</option>
                <option value="ja" <%= "ja".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Japanese</option>
                <option value="ko" <%= "ko".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Korean</option>
                <option value="pt" <%= "pt".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Portuguese</option>
                <option value="it" <%= "it".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Italian</option>
                <option value="bn" <%= "bn".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Bengali</option>
                <option value="pa" <%= "pa".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Punjabi</option>
                <option value="ta" <%= "ta".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Tamil</option>
                <option value="te" <%= "te".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Telugu</option>
                <option value="gu" <%= "gu".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Gujarati</option>
                <option value="ur" <%= "ur".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Urdu</option>
                <option value="mr" <%= "mr".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Marathi</option>
                <option value="ml" <%= "ml".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Malayalam</option>
                <option value="kn" <%= "kn".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Kannada</option>
                <option value="tr" <%= "tr".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Turkish</option>
                <option value="nl" <%= "nl".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Dutch</option>
                <option value="pl" <%= "pl".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Polish</option>
                <option value="sv" <%= "sv".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Swedish</option>
                <option value="uk" <%= "uk".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Ukrainian</option>
                <option value="vi" <%= "vi".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Vietnamese</option>
                <option value="fa" <%= "fa".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Persian</option>
                <option value="ro" <%= "ro".equals(request.getParameter("sourceLang")) ? "selected" : "" %>>Romanian</option>
            </select>

            <select name="targetLang" required>
                <option value="en" <%= "en".equals(request.getParameter("targetLang")) ? "selected" : "" %>>English</option>
                <option value="hi" <%= "hi".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Hindi</option>
                <option value="fr" <%= "fr".equals(request.getParameter("targetLang")) ? "selected" : "" %>>French</option>
                <option value="es" <%= "es".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Spanish</option>
                <option value="de" <%= "de".equals(request.getParameter("targetLang")) ? "selected" : "" %>>German</option>
                <option value="ru" <%= "ru".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Russian</option>
                <option value="zh" <%= "zh".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Chinese</option>
                <option value="ar" <%= "ar".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Arabic</option>
                <option value="ja" <%= "ja".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Japanese</option>
                <option value="ko" <%= "ko".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Korean</option>
                <option value="pt" <%= "pt".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Portuguese</option>
                <option value="it" <%= "it".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Italian</option>
                <option value="bn" <%= "bn".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Bengali</option>
                <option value="pa" <%= "pa".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Punjabi</option>
                <option value="ta" <%= "ta".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Tamil</option>
                <option value="te" <%= "te".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Telugu</option>
                <option value="gu" <%= "gu".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Gujarati</option>
                <option value="ur" <%= "ur".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Urdu</option>
                <option value="mr" <%= "mr".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Marathi</option>
                <option value="ml" <%= "ml".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Malayalam</option>
                <option value="kn" <%= "kn".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Kannada</option>
                <option value="tr" <%= "tr".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Turkish</option>
                <option value="nl" <%= "nl".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Dutch</option>
                <option value="pl" <%= "pl".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Polish</option>
                <option value="sv" <%= "sv".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Swedish</option>
                <option value="uk" <%= "uk".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Ukrainian</option>
                <option value="vi" <%= "vi".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Vietnamese</option>
                <option value="fa" <%= "fa".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Persian</option>
                <option value="ro" <%= "ro".equals(request.getParameter("targetLang")) ? "selected" : "" %>>Romanian</option>
            </select>
        </div>

        <div class="translation-boxes">
            <textarea name="sourceText" placeholder="Enter text to translate..."><%= request.getParameter("sourceText") != null ? request.getParameter("sourceText") : "" %></textarea>
            <textarea readonly placeholder="Translated text"><%= request.getAttribute("translatedText") != null ? request.getAttribute("translatedText") : "" %></textarea>
        </div>

        <button type="submit" class="translate">Translate</button>
    </form>
</div>
</body>
</html>
