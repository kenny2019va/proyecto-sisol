// login.js - Manejo AJAX para login modal

document.addEventListener('DOMContentLoaded', function() {
  const loginForm = document.getElementById('loginForm');
  if (!loginForm) return;

  loginForm.addEventListener('submit', function(e) {
    e.preventDefault();
    const formData = new FormData(loginForm);
    const errorDiv = document.getElementById('loginErrorMsg');
    if (errorDiv) errorDiv.remove();

    fetch('/auth/login', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: formData
    })
    .then(async response => {
      if (response.ok) {
        window.location.reload();
      } else {
        let msg = 'Credenciales incorrectas';
        try {
          const res = await response.json();
          if (res && res.error) msg = res.error;
        } catch {}
        mostrarError(msg);
      }
    })
    .catch(() => mostrarError('Error de conexión. Intenta nuevamente.'));

    function mostrarError(msg) {
      const div = document.createElement('div');
      div.id = 'loginErrorMsg';
      div.className = 'alert alert-danger mt-2';
      div.textContent = msg;
      loginForm.prepend(div);
    }
  });

  // Mostrar/ocultar contraseña
  const passwordInput = document.getElementById('password');
  const togglePasswordBtn = document.getElementById('togglePassword');
  const iconPassword = document.getElementById('iconPassword');
  if (togglePasswordBtn && passwordInput && iconPassword) {
    togglePasswordBtn.addEventListener('click', function() {
      const isPassword = passwordInput.type === 'password';
      passwordInput.type = isPassword ? 'text' : 'password';
      iconPassword.classList.toggle('bi-eye', !isPassword);
      iconPassword.classList.toggle('bi-eye-slash', isPassword);
    });
  }
}); 