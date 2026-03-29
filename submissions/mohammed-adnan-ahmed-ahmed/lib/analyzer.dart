Map<String, dynamic> analyzeUrl(String inputUrl) {
  int score = 0;
  final List<String> reasons = [];

  final String url = inputUrl.trim().toLowerCase();

  if (url.isEmpty) {
    return {
      "score": 100,
      "result": "DANGEROUS",
      "reasons": ["No URL was entered"],
      "recommendation": "Please enter a valid URL before checking.",
    };
  }

  Uri? uri;
  try {
    uri = Uri.parse(url);
  } catch (_) {
    return {
      "score": 100,
      "result": "DANGEROUS",
      "reasons": ["Invalid URL format"],
      "recommendation": "The link format looks incorrect. Do not open it.",
    };
  }

  // Must have scheme and host
  if ((uri.scheme != "http" && uri.scheme != "https") || uri.host.isEmpty) {
    return {
      "score": 90,
      "result": "DANGEROUS",
      "reasons": ["URL is missing a valid scheme or domain"],
      "recommendation":
          "Only trust complete links that start with http:// or https://",
    };
  }

  final String host = uri.host;

  // Rule 1: HTTP instead of HTTPS
  if (uri.scheme == "http") {
    score += 25;
    reasons.add("Uses insecure HTTP instead of HTTPS");
  }

  // Rule 2: IP address instead of domain
  final ipRegex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
  if (ipRegex.hasMatch(host)) {
    score += 25;
    reasons.add("Uses an IP address instead of a normal domain");
  }

  // Rule 3: Suspicious keywords
  const suspiciousKeywords = [
    "login",
    "verify",
    "update",
    "secure",
    "bank",
    "free",
    "bonus",
    "win",
    "account",
    "password",
    "confirm",
    "signin",
  ];

  int keywordMatches = 0;
  for (final word in suspiciousKeywords) {
    if (url.contains(word)) {
      keywordMatches++;
    }
  }

  if (keywordMatches > 0) {
    score += (keywordMatches * 8).clamp(8, 24);
    reasons.add("Contains suspicious phishing-related keywords");
  }

  // Rule 4: Very long URL
  if (url.length > 75) {
    score += 10;
    reasons.add("URL is unusually long");
  }

  // Rule 5: Too many dots / subdomains
  final dotCount = '.'.allMatches(host).length;
  if (dotCount > 2) {
    score += 10;
    reasons.add("Domain contains many subdomains");
  }

  // Rule 6: Hyphens in domain
  if (host.contains('-')) {
    score += 10;
    reasons.add("Domain contains hyphens, which can be suspicious");
  }

  // Rule 7: URL shorteners
  const shorteners = [
    "bit.ly",
    "tinyurl.com",
    "t.co",
    "goo.gl",
    "is.gd",
    "ow.ly",
    "buff.ly",
    "rebrand.ly",
  ];

  if (shorteners.any((s) => host.contains(s))) {
    score += 20;
    reasons.add("Uses a URL shortener that hides the final destination");
  }

  // Rule 8: @ symbol trick
  if (url.contains('@')) {
    score += 20;
    reasons.add("Contains '@' symbol, which can hide the real destination");
  }

  // Rule 9: Suspicious top-level domains
  const suspiciousTlds = [
    ".tk",
    ".xyz",
    ".top",
    ".click",
    ".buzz",
    ".work",
    ".gq",
    ".ml",
    ".cf",
  ];

  if (suspiciousTlds.any((tld) => host.endsWith(tld))) {
    score += 15;
    reasons.add("Uses a high-risk or suspicious domain extension");
  }

  // Rule 10: Possible brand impersonation
  const popularBrands = [
    "paypal",
    "google",
    "facebook",
    "apple",
    "microsoft",
    "amazon",
    "instagram",
    "netflix",
    "bank",
  ];

  for (final brand in popularBrands) {
    if (host.contains(brand) &&
        host != "$brand.com" &&
        host != "www.$brand.com") {
      score += 20;
      reasons.add("Domain may be impersonating a trusted brand");
      break;
    }
  }

  // Clamp score
  if (score > 100) score = 100;

  String result;
  String recommendation;

  if (score <= 30) {
    result = "SAFE";
    recommendation =
        "This link looks relatively safe, but still verify the website before entering sensitive information.";
  } else if (score <= 60) {
    result = "SUSPICIOUS";
    recommendation =
        "This link has some warning signs. Be careful and avoid entering passwords or personal data.";
  } else {
    result = "DANGEROUS";
    recommendation =
        "Do not open this link unless you fully trust the source. It may be phishing or malicious.";
  }

  if (reasons.isEmpty) {
    reasons.add("No major suspicious patterns were detected");
  }

  return {
    "score": score,
    "result": result,
    "reasons": reasons,
    "recommendation": recommendation,
  };
}
