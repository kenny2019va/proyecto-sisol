// Lógica para el navbar responsivo y off-canvas
(function() {
  const hamburger = document.querySelector('.hamburger');
  const offCanvasContainer = document.querySelector('.off-canvas-container');
  const offCanvasPanel = document.querySelector('.off-canvas-panel');
  const backdrop = document.querySelector('.off-canvas-backdrop');
  const closeButton = document.querySelector('.close-button');
  let lastFocusedElement = null;

  // Focus trap helpers
  function trapFocus(element) {
    const focusableEls = element.querySelectorAll('a, button, textarea, input, select, [tabindex]:not([tabindex="-1"])');
    const firstFocusableEl = focusableEls[0];
    const lastFocusableEl = focusableEls[focusableEls.length - 1];
    function handleTab(e) {
      if (e.key === 'Tab') {
        if (e.shiftKey) {
          if (document.activeElement === firstFocusableEl) {
            e.preventDefault();
            lastFocusableEl.focus();
          }
        } else {
          if (document.activeElement === lastFocusableEl) {
            e.preventDefault();
            firstFocusableEl.focus();
          }
        }
      }
    }
    element.addEventListener('keydown', handleTab);
    return () => element.removeEventListener('keydown', handleTab);
  }

  function openOffCanvas() {
    if (!offCanvasContainer) return;
    offCanvasContainer.classList.add('active');
    document.body.classList.add('off-canvas-open');
    offCanvasPanel.setAttribute('aria-hidden', 'false');
    hamburger.setAttribute('aria-expanded', 'true');
    lastFocusedElement = document.activeElement;
    setTimeout(() => {
      offCanvasPanel.focus();
    }, 100);
    // Trap focus
    offCanvasPanel._removeTrap = trapFocus(offCanvasPanel);
  }

  function closeOffCanvas() {
    if (!offCanvasContainer) return;
    offCanvasContainer.classList.remove('active');
    document.body.classList.remove('off-canvas-open');
    offCanvasPanel.setAttribute('aria-hidden', 'true');
    hamburger.setAttribute('aria-expanded', 'false');
    if (lastFocusedElement) lastFocusedElement.focus();
    // Remove focus trap
    if (offCanvasPanel._removeTrap) offCanvasPanel._removeTrap();
  }

  // Toggle
  if (hamburger) {
    hamburger.addEventListener('click', openOffCanvas);
  }
  if (closeButton) {
    closeButton.addEventListener('click', closeOffCanvas);
  }
  if (backdrop) {
    backdrop.addEventListener('click', closeOffCanvas);
    backdrop.addEventListener('touchstart', function(e) { e.preventDefault(); closeOffCanvas(); });
  }
  // Cerrar con ESC
  document.addEventListener('keydown', function(e) {
    if (offCanvasContainer.classList.contains('active') && e.key === 'Escape') {
      closeOffCanvas();
    }
  });
  // Prevenir scroll en overlay
  offCanvasPanel.addEventListener('touchmove', function(e) { e.stopPropagation(); }, { passive: false });
  // Debounce resize para recalcular dimensiones si es necesario
  let resizeTimeout;
  window.addEventListener('resize', function() {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(function() {
      if (window.innerWidth > 768 && offCanvasContainer.classList.contains('active')) {
        closeOffCanvas();
      }
    }, 150);
  });
})(); 