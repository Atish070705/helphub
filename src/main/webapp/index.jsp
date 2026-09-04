<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HelpHub - Connect. Help. Grow Together.</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #1f2937;
            overflow-x: hidden;
        }

        /* Animation Keyframes */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        /* Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            padding: 1rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            animation: fadeInDown 0.8s ease;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 2rem;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #4b5563;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .nav-links a:hover {
            color: #667eea;
        }

        .btn-nav {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white !important;
            padding: 0.5rem 1.5rem;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .btn-nav:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-nav::after {
            display: none;
        }

        /* Hero Section */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 6rem 5% 4rem;
            gap: 3rem;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            flex: 1;
            animation: slideInLeft 1s ease;
        }

        .hero-content h1 {
            font-size: 4rem;
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #fff 0%, #e0e7ff 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-content p {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-hero {
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .btn-hero-primary {
            background: white;
            color: #667eea;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .btn-hero-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 35px rgba(0,0,0,0.2);
        }

        .btn-hero-secondary {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-hero-secondary:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
        }

        .hero-image {
            flex: 1;
            animation: slideInRight 1s ease;
            text-align: center;
        }

        .hero-image i {
            font-size: 20rem;
            color: rgba(255, 255, 255, 0.2);
            animation: float 3s ease-in-out infinite;
        }

        /* Stats Section */
        .stats-section {
            background: white;
            padding: 4rem 5%;
            border-radius: 50px 50px 0 0;
            margin-top: -50px;
            position: relative;
            animation: fadeInUp 1s ease;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .stat-card {
            text-align: center;
            padding: 2rem;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-10px);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #6b7280;
            font-weight: 500;
            font-size: 1rem;
        }

        /* Features Section */
        .features-section {
            padding: 5rem 5%;
            background: #f9fafb;
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .section-title h2 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .section-title p {
            color: #6b7280;
            font-size: 1.1rem;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            animation: fadeInUp 0.8s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }

        .feature-icon i {
            font-size: 2.5rem;
            color: white;
        }

        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #1f2937;
        }

        .feature-card p {
            color: #6b7280;
            line-height: 1.6;
        }

        /* How It Works Section */
        .how-it-works {
            padding: 5rem 5%;
            background: white;
        }

        .steps-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .step {
            text-align: center;
            position: relative;
            animation: fadeInUp 1s ease;
        }

        .step-number {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: bold;
            margin: 0 auto 1.5rem;
        }

        .step h3 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .step p {
            color: #6b7280;
        }

        /* Testimonials Section */
        .testimonials {
            padding: 5rem 5%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .testimonials .section-title h2 {
            color: white;
            background: none;
            -webkit-text-fill-color: white;
        }

        .testimonials .section-title p {
            color: rgba(255, 255, 255, 0.9);
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .testimonial-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            position: relative;
            transition: all 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-5px);
        }

        .testimonial-card i.fa-quote-left {
            font-size: 2rem;
            color: #667eea;
            opacity: 0.3;
            position: absolute;
            top: 1rem;
            left: 1rem;
        }

        .testimonial-text {
            font-size: 1rem;
            line-height: 1.6;
            color: #4b5563;
            margin: 1.5rem 0;
            font-style: italic;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-top: 1rem;
        }

        .testimonial-author i {
            font-size: 3rem;
            color: #667eea;
        }

        .author-info h4 {
            font-size: 1rem;
            margin-bottom: 0.25rem;
        }

        .author-info p {
            font-size: 0.875rem;
            color: #9ca3af;
        }

        /* CTA Section */
        .cta-section {
            padding: 5rem 5%;
            background: white;
            text-align: center;
        }

        .cta-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .cta-container h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .cta-container p {
            color: #6b7280;
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }

        .btn-cta {
            padding: 1rem 2.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.3);
        }

        /* Footer */
        .footer {
            background: #1f2937;
            color: white;
            padding: 3rem 5% 1rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            margin-bottom: 2rem;
        }

        .footer-section h3 {
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .footer-section p {
            color: #9ca3af;
            line-height: 1.6;
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 0.5rem;
        }

        .footer-section ul li a {
            color: #9ca3af;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-section ul li a:hover {
            color: #667eea;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-links a {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: #667eea;
            transform: translateY(-3px);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #9ca3af;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                gap: 1rem;
            }

            .hero {
                flex-direction: column;
                text-align: center;
                padding-top: 8rem;
            }

            .hero-content h1 {
                font-size: 2.5rem;
            }

            .hero-buttons {
                justify-content: center;
            }

            .hero-image i {
                font-size: 12rem;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            .features-grid,
            .steps-container,
            .testimonials-grid {
                grid-template-columns: 1fr;
            }

            .section-title h2 {
                font-size: 2rem;
            }
        }

        /* Scroll Animation */
        .scroll-reveal {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.8s ease;
        }

        .scroll-reveal.revealed {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <a href="/" class="logo">
        <i class="fas fa-hands-helping"></i>
        <span>HelpHub</span>
    </a>
    <div class="nav-links">
        <a href="#home">Home</a>
        <a href="#features">Features</a>
        <a href="#how-it-works">How It Works</a>
        <a href="#testimonials">Testimonials</a>
        <a href="/login" class="btn-nav">Login</a>
        <a href="/register" class="btn-nav">Sign Up</a>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="hero">
    <div class="hero-content">
        <h1>Connect, Help,<br>Grow Together</h1>
        <p>Join thousands of community members who are making a difference by helping others and building meaningful connections.</p>
        <div class="hero-buttons">
            <a href="/register" class="btn-hero btn-hero-primary">
                <i class="fas fa-user-plus"></i> Get Started
            </a>
            <a href="#features" class="btn-hero btn-hero-secondary">
                <i class="fas fa-info-circle"></i> Learn More
            </a>
        </div>
    </div>
    <div class="hero-image">
        <i class="fas fa-hand-holding-heart"></i>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-number">1,000+</div>
            <div class="stat-label">Active Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">500+</div>
            <div class="stat-label">Requests Resolved</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">2,500+</div>
            <div class="stat-label">Helpful Responses</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">24/7</div>
            <div class="stat-label">Community Support</div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="features-section">
    <div class="section-title">
        <h2>Why Choose HelpHub?</h2>
        <p>Discover the amazing features that make our community special</p>
    </div>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-hand-holding-heart"></i>
            </div>
            <h3>Help Others</h3>
            <p>Share your knowledge and skills to help someone in need. Every small act of kindness makes a big difference.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-star"></i>
            </div>
            <h3>Earn Karma Points</h3>
            <p>Get recognized for your contributions. Earn karma points for helpful responses and build your reputation.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-users"></i>
            </div>
            <h3>Build Community</h3>
            <p>Connect with like-minded individuals and build lasting relationships within your community.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <h3>Track Your Impact</h3>
            <p>See how many people you've helped and track your contribution to the community.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-shield-alt"></i>
            </div>
            <h3>Safe & Secure</h3>
            <p>Your privacy and safety are our priority. We maintain a respectful and supportive environment.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-mobile-alt"></i>
            </div>
            <h3>Accessible Anywhere</h3>
            <p>Access HelpHub from any device - desktop, tablet, or mobile. Help is always at your fingertips.</p>
        </div>
    </div>
</section>

<!-- How It Works Section -->
<section id="how-it-works" class="how-it-works">
    <div class="section-title">
        <h2>How It Works</h2>
        <p>Getting started with HelpHub is simple and easy</p>
    </div>
    <div class="steps-container">
        <div class="step">
            <div class="step-number">1</div>
            <h3>Create an Account</h3>
            <p>Sign up for free and create your profile. Tell us a bit about yourself and your skills.</p>
        </div>
        <div class="step">
            <div class="step-number">2</div>
            <h3>Post or Find Help</h3>
            <p>Need help? Post a request. Want to help? Browse requests and find opportunities to make a difference.</p>
        </div>
        <div class="step">
            <div class="step-number">3</div>
            <h3>Connect & Collaborate</h3>
            <p>Connect with community members, share your knowledge, and work together to solve problems.</p>
        </div>
        <div class="step">
            <div class="step-number">4</div>
            <h3>Grow & Earn</h3>
            <p>Earn karma points for helpful responses, build your reputation, and grow as a valued community member.</p>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section id="testimonials" class="testimonials">
    <div class="section-title">
        <h2>What Our Community Says</h2>
        <p>Real stories from real people who found help and gave help</p>
    </div>
    <div class="testimonials-grid">
        <div class="testimonial-card">
            <i class="fas fa-quote-left"></i>
            <div class="testimonial-text">
                "HelpHub has been a game-changer for me. I needed career guidance and found an experienced mentor who helped me land my dream job!"
            </div>
            <div class="testimonial-author">
                <i class="fas fa-user-circle"></i>
                <div class="author-info">
                    <h4>Priya Sharma</h4>
                    <p>Software Developer</p>
                </div>
            </div>
        </div>
        <div class="testimonial-card">
            <i class="fas fa-quote-left"></i>
            <div class="testimonial-text">
                "I love helping others on HelpHub. The karma system motivates me to give back, and I've made so many meaningful connections."
            </div>
            <div class="testimonial-author">
                <i class="fas fa-user-circle"></i>
                <div class="author-info">
                    <h4>Amit Kumar</h4>
                    <p>Technical Mentor</p>
                </div>
            </div>
        </div>
        <div class="testimonial-card">
            <i class="fas fa-quote-left"></i>
            <div class="testimonial-text">
                "The mental health support I received was incredible. Someone was there to listen when I needed it most. Forever grateful!"
            </div>
            <div class="testimonial-author">
                <i class="fas fa-user-circle"></i>
                <div class="author-info">
                    <h4>Neha Joshi</h4>
                    <p>Community Member</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <div class="cta-container">
        <h2>Ready to Make a Difference?</h2>
        <p>Join our growing community of helpers and learners today. Every small act of kindness creates ripples of change.</p>
        <a href="/register" class="btn-cta">
            <i class="fas fa-rocket"></i> Start Your Journey
        </a>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>About HelpHub</h3>
            <p>HelpHub is a community-driven platform that connects people who need help with those who can provide it. Together, we make the world a better place.</p>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
        <div class="footer-section">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="#features">Features</a></li>
                <li><a href="#how-it-works">How It Works</a></li>
                <li><a href="#testimonials">Testimonials</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>Support</h3>
            <ul>
                <li><a href="#">Help Center</a></li>
                <li><a href="#">Community Guidelines</a></li>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>Contact Us</h3>
            <p><i class="fas fa-envelope"></i> support@helphub.com</p>
            <p><i class="fas fa-phone"></i> +1 (555) 123-4567</p>
            <p><i class="fas fa-map-marker-alt"></i> 123 Community Street, Digital City, DC 12345</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 HelpHub. All rights reserved. Made with <i class="fas fa-heart" style="color: #ef4444;"></i> for the community.</p>
    </div>
</footer>

<script>
    // Scroll reveal animation
    function reveal() {
        var reveals = document.querySelectorAll('.scroll-reveal');
        for (var i = 0; i < reveals.length; i++) {
            var windowHeight = window.innerHeight;
            var elementTop = reveals[i].getBoundingClientRect().top;
            var elementVisible = 150;
            if (elementTop < windowHeight - elementVisible) {
                reveals[i].classList.add('revealed');
            }
        }
    }

    // Add scroll-reveal class to elements
    document.querySelectorAll('.feature-card, .step, .testimonial-card, .stat-card').forEach(el => {
        el.classList.add('scroll-reveal');
    });

    // Listen for scroll events
    window.addEventListener('scroll', reveal);
    window.addEventListener('load', reveal);

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Navbar background change on scroll
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(255, 255, 255, 0.98)';
            navbar.style.boxShadow = '0 2px 20px rgba(0,0,0,0.1)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
            navbar.style.boxShadow = '0 2px 20px rgba(0,0,0,0.1)';
        }
    });
</script>

</body>
</html>