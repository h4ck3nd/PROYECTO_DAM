package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebListener;
import java.io.*;
import java.util.concurrent.*;
// Marca la clase como un listener de eventos del ciclo de vida del contexto de la aplicación
@WebListener
public class AutoCleanerListenerControlador implements ServletContextListener {
    // Declaración de un planificador de tareas
    private ScheduledExecutorService scheduler;
    // Método que se ejecuta al iniciar la aplicación (cuando se carga el contexto)
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Obtiene la ruta absoluta de los archivos de usuarios y contraseñas
        String rutaUsuarios = sce.getServletContext().getRealPath("/labs/retroGame/users.txt");
        String rutaContrasenas = sce.getServletContext().getRealPath("/labs/retroGame/pass.txt");
        // Inicializa el planificador para ejecutar una tarea repetidamente
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(() -> {
            // Programa una tarea para ejecutarse cada 5 minutos después de un retraso inicial de 5 minutos
            try {
                // Limpia el contenido del archivo users.txt
                new PrintWriter(rutaUsuarios).close();
                // Limpia el contenido del archivo pass.txt
                new PrintWriter(rutaContrasenas).close();
                // Mensaje informativo en consola
                System.out.println("[INFO] Diccionarios limpiados automáticamente.");
            } catch (IOException e) {
                // Manejo de errores de escritura
                System.err.println("[ERROR] Error limpiando archivos: " + e.getMessage());
            }
        }, 5, 5, TimeUnit.MINUTES);
    }
    // Método que se ejecuta cuando se detiene la aplicación (cuando se destruye el contexto)
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Verifica que el planificador esté activo y lo detiene
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
        }
    }
}
