      // Create floating particles
        function createParticles() {
            const particlesContainer = document.getElementById('particles');
            const particleCount = 24;

            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.bottom = Math.random() * 40 + '%';
                particle.style.animationDelay = Math.random() * 10 + 's';
                particle.style.animationDuration = (Math.random() * 10 + 16) + 's';
                
                const size = Math.random() * 8 + 6;
                particle.style.width = size + 'px';
                particle.style.height = size + 'px';
                
                particlesContainer.appendChild(particle);
            }
        }

        // // 🎯 MAIN SCROLL EFFECT - Background opacity control
        // function handleScroll() {
        //     const scrollY = window.pageYOffset;
        //     const windowHeight = window.innerHeight;
        //     const backgroundLayer = document.getElementById('backgroundLayer');
        //     const header = document.getElementById('header');
        //     const kraftTitle = document.getElementById('kraftTitle');
            
        //     // Calculate opacity based on scroll position
        //     // Background starts fading after 20% of viewport height
        //     const fadeStart = windowHeight * 0.2;
        //     const fadeEnd = windowHeight * 0.8;
            
        //     let opacity = 1;
            
        //     if (scrollY > fadeStart) {
        //         const fadeProgress = (scrollY - fadeStart) / (fadeEnd - fadeStart);
        //         opacity = Math.max(0, 1 - fadeProgress);
        //     }
            
        //     // Apply opacity to background layer
        //     backgroundLayer.style.opacity = opacity;
            
        //     // Header scroll effect
        //     if (scrollY > 100) {
        //         header.classList.add('scrolled');
        //     } else {
        //         header.classList.remove('scrolled');
        //     }
            
        //     // Kraft title animation
        //     const kraftSection = kraftTitle.closest('.kraft-section');
        //     const kraftSectionTop = kraftSection.offsetTop;
        //     const kraftSectionHeight = kraftSection.offsetHeight;
            
        //     if (scrollY + windowHeight > kraftSectionTop + kraftSectionHeight * 0.3) {
        //         kraftTitle.classList.add('animate');
        //     }
            
        //     // Particle opacity based on background opacity
        //     const particles = document.getElementById('particles');
        //     particles.style.opacity = opacity * 0.8;
        // }

        // // Throttled scroll handler for better performance
        // let ticking = false;
        // function requestTick() {
        //     if (!ticking) {
        //         requestAnimationFrame(handleScroll);
        //         ticking = true;
        //     }
        // }

        // window.addEventListener('scroll', () => {
        //     requestTick();
        //     ticking = false;
        // });

        // // Mouse movement effect
        // document.addEventListener('mousemove', (e) => {
        //     const mouseX = (e.clientX / window.innerWidth) * 100;
        //     const mouseY = (e.clientY / window.innerHeight) * 100;
            
        //     document.documentElement.style.setProperty('--mouse-x', mouseX + '%');
        //     document.documentElement.style.setProperty('--mouse-y', mouseY + '%');
        // });

        // Mobile menu functionality
        document.querySelector('.mobile-menu-btn').addEventListener('click', function() {
            const navMenu = document.querySelector('.nav-menu');
            const icon = this.querySelector('i');
            
            if (navMenu.style.display === 'flex') {
                navMenu.style.display = 'none';
                icon.className = 'fas fa-bars';
            } else {
                navMenu.style.display = 'flex';
                navMenu.style.flexDirection = 'column';
                navMenu.style.position = 'absolute';
                navMenu.style.top = '100%';
                navMenu.style.left = '0';
                navMenu.style.right = '0';
                navMenu.style.background = 'rgba(248, 244, 230, 0.98)';
                navMenu.style.padding = '2rem';
                navMenu.style.borderRadius = '0 0 20px 20px';
                navMenu.style.boxShadow = '0 10px 30px rgba(0,0,0,0.1)';
                icon.className = 'fas fa-times';
            }
        });

        // // Initialize
        // createParticles();
        // handleScroll(); // Initial call

        // // Loading animation
        // window.addEventListener('load', () => {
        //     document.body.style.opacity = '0';
        //     document.body.style.transition = 'opacity 0.8s ease';
        //     setTimeout(() => {
        //         document.body.style.opacity = '1';
        //     }, 100);
        // });

        // console.log('🎨 Bansal Kraft with Scroll Background Effect Loaded!');
        // console.log('📜 Scroll to see the background fade effect!');

        // // Hero section scroll effects
        // document.addEventListener('DOMContentLoaded', function() {
        //     const heroSection = document.querySelector('.hero-section');
        //     const backgroundLayer = document.getElementById('backgroundLayer');
        //     const particles = document.getElementById('particles');
        //     const heroContent = document.querySelector('.hero-content');
            
        //     function handleScroll() {
        //         const scrollY = window.pageYOffset;
        //         const windowHeight = window.innerHeight;
                
        //         // Calculate opacity based on scroll position
        //         const fadeStart = windowHeight * 0.2;
        //         const fadeEnd = windowHeight * 0.8;
                
        //         let opacity = 1;
                
        //         if (scrollY > fadeStart) {
        //             const fadeProgress = (scrollY - fadeStart) / (fadeEnd - fadeStart);
        //             opacity = Math.max(0, 1 - fadeProgress);
        //         }
                
        //         // Apply opacity to background and particles
        //         backgroundLayer.style.opacity = opacity * 0.15;
        //         particles.style.opacity = opacity * 0.7;
                
        //         // Add scrolled class for additional effects
        //         if (scrollY > 100) {
        //             heroSection.classList.add('scrolled');
        //         } else {
        //             heroSection.classList.remove('scrolled');
        //         }
        //     }
            
        //     // Initial call
        //     handleScroll();
            
        //     // Add scroll event listener
        //     window.addEventListener('scroll', handleScroll);
        // });

        // document.addEventListener('DOMContentLoaded', function() {
        //     createParticles();
        // });