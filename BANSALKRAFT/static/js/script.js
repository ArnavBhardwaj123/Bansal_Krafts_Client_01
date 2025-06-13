 // Wait for the DOM to be fully loaded
document.addEventListener("DOMContentLoaded", () => {
  // Navigation active state
  const navLinks = document.querySelectorAll("nav ul li a")

  // Sticky header
  const header = document.querySelector('header');
  let lastScroll = 0;

  // Trigger header animation on load - moved here after header declaration
  if (header) {
    header.classList.add('header-animate');
  }

  navLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      // Remove active class from all links
      navLinks.forEach((item) => {
        item.classList.remove("active")
      })

      // Add active class to clicked link
      this.classList.add("active")
    })
  })

  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
      e.preventDefault()

      const targetId = this.getAttribute("href")
      if (targetId === "#") return

      const targetElement = document.querySelector(targetId)
      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: "smooth",
        })
      }
    })
  })

  // Simple animation for the hero section
  // Removed the previous redeclaration of heroContent and heroImage.
  // The animation for hero section elements will now be handled by the new section below.

  window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;
    
    if (currentScroll <= 0) {
      header.classList.remove('scroll-up');
      return;
    }
    
    if (currentScroll > lastScroll && !header.classList.contains('scroll-down')) {
      // Scroll Down
      header.classList.remove('scroll-up');
      header.classList.add('scroll-down');
    } else if (currentScroll < lastScroll && header.classList.contains('scroll-down')) {
      // Scroll Up
      header.classList.remove('scroll-down');
      header.classList.add('scroll-up');
    }
    lastScroll = currentScroll;
  });

  // Form validation
  const contactForm = document.querySelector('.contact-form form');

if (contactForm) {
  contactForm.addEventListener('submit', function(e) {
    // Don't prevent yet
    // Basic form validation
    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const subject = document.getElementById('subject').value.trim();
    const message = document.getElementById('message').value.trim();

    if (!name || !email || !subject || !message) {
      e.preventDefault(); // Block submission only if fields are invalid
      alert('Please fill in all fields');
      return;
    }

    // Email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      e.preventDefault(); // Block submission only if email is invalid
      alert('Please enter a valid email address');
      return;
    }

    // ✅ Let the form submit to Django as normal
    // You can show a message after backend response instead of here
    alert('Thank you for your message! We will get back to you soon.');
  });
}

  // Animate stats when they come into view
  const stats = document.querySelectorAll('.stat-number');
  const observerOptions = {
    threshold: 0.5
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const target = entry.target;
        const finalValue = parseInt(target.textContent);
        let currentValue = 0;
        const duration = 2000; // 2 seconds
        const increment = finalValue / (duration / 16); // 60fps
        
        const counter = setInterval(() => {
          currentValue += increment;
          if (currentValue >= finalValue) {
            target.textContent = finalValue + '+';
            clearInterval(counter);
          } else {
            target.textContent = Math.floor(currentValue) + '+';
          }
        }, 16);
        
        observer.unobserve(target);
      }
    });
  }, observerOptions);

  stats.forEach(stat => observer.observe(stat));

  // Mobile menu functionality
  const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
  const nav = document.querySelector('nav');

  if (mobileMenuBtn && nav) {
    mobileMenuBtn.addEventListener('click', (e) => {
        e.stopPropagation();
        nav.classList.toggle('active');
        mobileMenuBtn.classList.toggle('active');
    });
    
    document.addEventListener('click', (e) => {
        if (!nav.contains(e.target) && !mobileMenuBtn.contains(e.target)) {
            nav.classList.remove('active');
            mobileMenuBtn.classList.remove('active');
        }
    });

    document.querySelectorAll('nav a').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            // Check if the clicked anchor is part of a dropdown button
            if (this.classList.contains('dropbtn')) {
                // For dropdown buttons, we want to toggle the dropdown, not scroll immediately
                e.preventDefault();
                const parentDropdown = this.closest('.dropdown');
                if (parentDropdown) {
                    // Close other open dropdowns
                    document.querySelectorAll('.dropdown.open').forEach(openDropdown => {
                        if (openDropdown !== parentDropdown) {
                            openDropdown.classList.remove('open');
                        }
                    });
                    parentDropdown.classList.toggle('open');
                }
            } else {
                // For regular nav links, perform smooth scroll and close mobile menu
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    nav.classList.remove('active');
                    mobileMenuBtn.classList.remove('active');
                    
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }
        });
    });
  }

  // Add loading animation for images
  const images = document.querySelectorAll('img');
  images.forEach(img => {
    img.addEventListener('load', () => {
      img.classList.add('loaded');
    });
  });

  // Hero Section Elements Animation (Corrected declaration)
  const heroContentAnimation = document.querySelector('.hero-content');
  const heroImageSliderAnimation = document.querySelector('.hero-image-slider');

  if (heroContentAnimation) {
      setTimeout(() => {
          heroContentAnimation.classList.add('animate-in');
      }, 100); // Small delay for content
  }

  if (heroImageSliderAnimation) {
      setTimeout(() => {
          heroImageSliderAnimation.classList.add('animate-in');
      }, 300); // Slightly longer delay for slider
  }

  // About Cards Animation
  const aboutCards = document.querySelectorAll('.about-card');

  const aboutCardsObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
          if (entry.isIntersecting) {
              console.log('About card intersecting:', entry.target);
              entry.target.classList.add('animate-in');
              observer.unobserve(entry.target); // Stop observing once animated
          }
      });
  }, { threshold: 0.3 }); // Trigger when 30% of the item is visible

  aboutCards.forEach(card => {
      aboutCardsObserver.observe(card);
  });

  // Products Cards Animation
  const productCards = document.querySelectorAll('.product-card');

  const productCardsObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
          if (entry.isIntersecting) {
              console.log('Product card intersecting:', entry.target);
              entry.target.classList.add('animate-in');
              observer.unobserve(entry.target); // Stop observing once animated
          }
      });
  }, { threshold: 0.3 });

  productCards.forEach(card => {
      productCardsObserver.observe(card);
  });

  // Services Cards Animation
  const serviceCards = document.querySelectorAll('.service-card');

  const serviceCardsObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
          if (entry.isIntersecting) {
              console.log('Service card intersecting:', entry.target);
              entry.target.classList.add('animate-in');
              observer.unobserve(entry.target); // Stop observing once animated
          }
      });
  }, { threshold: 0.3 });

  serviceCards.forEach(card => {
      serviceCardsObserver.observe(card);
  });

  // Network Section Animation
  const networkMap = document.querySelector('.network-map');
  const networkDetails = document.querySelector('.network-details');

  const networkObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
          if (entry.isIntersecting) {
              console.log('Network element intersecting:', entry.target);
              entry.target.classList.add('animate-in');
              observer.unobserve(entry.target); // Stop observing once animated
          }
      });
  }, { threshold: 0.3 });

  if (networkMap) networkObserver.observe(networkMap);
  if (networkDetails) networkObserver.observe(networkDetails);

  // Hero Image Slider functionality
  const sliderWrapper = document.querySelector('.slider-wrapper');
  const sliderImages = document.querySelectorAll('.slider-image');
  const sliderDots = document.querySelectorAll('.slider-dots .dot');
  const totalImages = sliderImages.length;
  let currentSlide = 0;
  let slideInterval;

  console.log('Slider elements found:', { sliderWrapper, sliderImages, sliderDots });
  console.log('Total images:', totalImages);

  function showSlide(index) {
      console.log('showSlide called with index:', index);
      if (index >= totalImages) {
          currentSlide = 0;
      } else if (index < 0) {
          currentSlide = totalImages - 1;
      } else {
          currentSlide = index;
      }

      const offset = -currentSlide * 100;
      if (sliderWrapper) {
          sliderWrapper.style.transform = `translateX(${offset}%)`;
          console.log('Applying transform:', `translateX(${offset}%)`);
      }

      sliderDots.forEach((dot, i) => {
          if (i === currentSlide) {
              dot.classList.add('active');
          } else {
              dot.classList.remove('active');
          }
      });
      console.log('Current slide after update:', currentSlide);
  }

  function startSlider() {
      console.log('startSlider called');
      stopSlider(); // Ensure any previous interval is cleared
      slideInterval = setInterval(() => {
          showSlide(currentSlide + 1);
      }, 5000); // Change image every 5 seconds
  }

  function stopSlider() {
      console.log('stopSlider called');
      clearInterval(slideInterval);
  }

  // Event listeners for dots
  if (sliderDots && sliderImages.length > 0) {
    sliderDots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            console.log('Dot clicked, index:', index);
            stopSlider();
            showSlide(index);
            startSlider();
        });
    });
  }

  // Start the slider when the page loads
  if (sliderWrapper && sliderImages.length > 0) {
      console.log('Starting slider on DOMContentLoaded');
      showSlide(currentSlide);
      startSlider();
  }

  // State accordion functionality
  const stateHeaders = document.querySelectorAll('.state-header');
  let activeHeader = null;
  
  function toggleAccordion(header, shouldOpen = true) {
      const content = header.nextElementSibling;
      const state = header.dataset.state;
      
      // Close previous active header if exists
      if (activeHeader && activeHeader !== header) {
          activeHeader.classList.remove('active');
          activeHeader.nextElementSibling.classList.remove('active');
          activeHeader.querySelector('.toggle-icon').textContent = '+';
          const prevStatePath = document.querySelector(`.state[data-state="${activeHeader.dataset.state}"]`);
          if (prevStatePath) {
              prevStatePath.classList.remove('active');
          }
      }
      
      // Toggle current header
      if (shouldOpen) {
          header.classList.add('active');
          content.classList.add('active');
          header.querySelector('.toggle-icon').textContent = '−';
          const statePath = document.querySelector(`.state[data-state="${state}"]`);
          if (statePath) {
              statePath.classList.add('active');
          }
          activeHeader = header;
      } else {
          header.classList.remove('active');
          content.classList.remove('active');
          header.querySelector('.toggle-icon').textContent = '+';
          const statePath = document.querySelector(`.state[data-state="${state}"]`);
          if (statePath) {
              statePath.classList.remove('active');
          }
          activeHeader = null;
      }
  }
  
  // Click handlers for accordion headers
  stateHeaders.forEach(header => {
      header.addEventListener('click', () => {
          toggleAccordion(header, !header.classList.contains('active'));
      });
  });

  // Map interaction
  const statePaths = document.querySelectorAll('.state');
  statePaths.forEach(path => {
      path.addEventListener('click', () => {
          const state = path.dataset.state;
          const header = document.querySelector(`.state-header[data-state="${state}"]`);
          if (header) {
              toggleAccordion(header, true);
          }
      });
  });

  // Scroll-based accordion functionality
  const scrollObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
          if (entry.isIntersecting) {
              const header = entry.target;
              toggleAccordion(header, true);
          }
      });
  }, {
      root: null,
      rootMargin: '-20% 0px -20% 0px',
      threshold: 0.5
  });

  // Observe all state headers
  stateHeaders.forEach(header => {
      scrollObserver.observe(header);
  });

  // Button hover interaction
  const getQuoteBtn = document.querySelector('.btn.primary');
  const viewProductsBtn = document.querySelector('.btn.secondary');

  if (getQuoteBtn && viewProductsBtn) {
    getQuoteBtn.addEventListener('mouseover', () => {
      viewProductsBtn.classList.add('active-from-hover');
    });

    getQuoteBtn.addEventListener('mouseout', () => {
      viewProductsBtn.classList.remove('active-from-hover');
    });

    viewProductsBtn.addEventListener('mouseover', () => {
      getQuoteBtn.classList.add('active-from-secondary-hover');
    });

    viewProductsBtn.addEventListener('mouseout', () => {
      getQuoteBtn.classList.remove('active-from-secondary-hover');
    });
  }
});

