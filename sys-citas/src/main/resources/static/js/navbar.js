// Este archivo solo debe contener lógica adicional para el navbar, no para el offcanvas, ya que ahora usamos el de Bootstrap 5.
// Si necesitas agregar scripts personalizados para el navbar, hazlo aquí. 

// navbar.js - Funcionalidades del navbar

// Función para mostrar alerta de acceso denegado
function mostrarAccesoDenegado(mensaje = 'No tienes permisos para acceder a esta sección.') {
    // Crear el alert
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-warning alert-dismissible fade show position-fixed';
    alertDiv.style.cssText = 'top: 80px; right: 20px; z-index: 9999; min-width: 300px;';
    alertDiv.innerHTML = `
        <strong>Acceso Denegado</strong><br>
        ${mensaje}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
    `;
    
    // Agregar al body
    document.body.appendChild(alertDiv);
    
    // Auto-eliminar después de 5 segundos
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 5000);
}

// Función para verificar permisos antes de navegar
function verificarPermisos(rolRequerido, urlDestino) {
    // Obtener el rol del usuario desde la sesión (si existe)
    const usuarioRol = document.querySelector('[data-usuario-rol]')?.dataset.usuarioRol;
    
    if (!usuarioRol || usuarioRol !== rolRequerido) {
        mostrarAccesoDenegado();
        return false;
    }
    
    // Si tiene permisos, navegar
    window.location.href = urlDestino;
    return true;
}

// Exportar funciones para uso global
window.mostrarAccesoDenegado = mostrarAccesoDenegado;
window.verificarPermisos = verificarPermisos; 