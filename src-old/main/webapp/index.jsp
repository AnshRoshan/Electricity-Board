<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electricity Management - Welcome</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom Tailwind styles */
        .hero-bg {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<!-- Hero Section -->
<section class="hero-bg text-white min-h-screen flex items-center justify-center">
    <div class="container mx-auto px-6 text-center">
        <h1 class="text-5xl md:text-6xl font-bold mb-4 animate-fade-in">
            Welcome to Electricity Management
        </h1>
        <p class="text-xl md:text-2xl mb-8 animate-fade-in-delay">
            Manage your bills, track usage, and resolve issues with ease.
        </p>
        <div class="flex justify-center gap-4">
            <a href="register"
               class="bg-white text-blue-600 font-semibold py-3 px-6 rounded-lg shadow-lg hover:bg-blue-100 transition duration-300 transform hover:-translate-y-1">
                Register
            </a>
            <a href="login"
               class="bg-transparent border-2 border-white text-white font-semibold py-3 px-6 rounded-lg hover:bg-white hover:text-blue-600 transition duration-300 transform hover:-translate-y-1">
                Login
            </a>
        </div>
    </div>
</section>

<!-- Features Section (Optional) -->
<section class="py-16 bg-white">
    <div class="container mx-auto px-6">
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-12">Why Choose Us?</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="text-center">
                <div class="text-blue-600 text-4xl mb-4">⚡</div>
                <h3 class="text-xl font-semibold mb-2">Easy Bill Payments</h3>
                <p class="text-gray-600">Pay your electricity bills quickly and securely.</p>
            </div>
            <div class="text-center">
                <div class="text-blue-600 text-4xl mb-4">📊</div>
                <h3 class="text-xl font-semibold mb-2">Usage Tracking</h3>
                <p class="text-gray-600">Monitor your electricity consumption effortlessly.</p>
            </div>
            <div class="text-center">
                <div class="text-blue-600 text-4xl mb-4">🛠️</div>
                <h3 class="text-xl font-semibold mb-2">Support & Complaints</h3>
                <p class="text-gray-600">Report issues and get fast resolutions.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-6">
    <div class="container mx-auto px-6 text-center">
        <p>&copy; <%= java.time.Year.now() %> Electricity Management. All rights reserved.</p>
    </div>
</footer>

<!-- Animation Keyframes -->
<style>
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .animate-fade-in {
        animation: fadeIn 1s ease-out;
    }
    .animate-fade-in-delay {
        animation: fadeIn 1s ease-out 0.5s;
        animation-fill-mode: both;
    }
</style>
</body>
</html>