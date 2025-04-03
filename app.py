from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
from sqlalchemy import text  # Necesitamos importar `text` para las expresiones SQL

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1234@localhost/appusers'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'supersecreto'

db = SQLAlchemy(app)

# Definición del modelo User
class User(db.Model):
    __tablename__ = 'usuarios'  # Aseguramos que se usa la tabla correcta
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), nullable=False)
    apellidos = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    usuario = db.Column(db.String(128), unique=True, nullable=False)  # Aquí aumentamos a 128
    password_hash = db.Column(db.String(128), nullable=False)
    fecha_nacimiento = db.Column(db.Date, nullable=False)
    estado = db.Column(db.Boolean, default=True)
    fecha_registro = db.Column(db.DateTime, default=datetime.utcnow)
    rol = db.Column(db.String(10), default='user')
    ultimo_login = db.Column(db.DateTime)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

@app.before_request
def create_tables():
    with app.app_context():
        db.create_all()

# Ruta de inicio, redirige al login
@app.route('/')
def index():
    return redirect(url_for('select_user'))

# Ruta de login
# Ruta de login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        user_input = request.form['username']
        password = request.form['password']
        
        # Buscando el usuario por nombre de usuario o correo electrónico
        user = User.query.filter((User.usuario == user_input) | (User.email == user_input)).first()
        
        if user and user.check_password(password):
            user.ultimo_login = datetime.utcnow()
            db.session.commit()
            session['user_id'] = user.id
            session['rol'] = user.rol
            return redirect(url_for('animation'))
        else:
            flash("Usuario o contraseña incorrectos", 'danger')  # Mensaje de error
            return redirect(url_for('login'))
    
    return render_template('index.html')  # Método GET: Muestra el formulario de inicio de sesión

# Ruta de registro
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellidos = request.form['apellidos']
        email = request.form['email']
        usuario = request.form['usuario']
        password = request.form['password']
        confirm_password = request.form['confirm_password']
        fecha_nacimiento = request.form['fecha_nacimiento']
        rol = request.form.get('rol', 'user')
        
        # Verificación de contraseñas coincidentes
        if password != confirm_password:
            flash('Las contraseñas no coinciden', 'danger')
            return redirect(url_for('register'))
        
        # Verificación de si el email o el usuario ya existen
        if User.query.filter_by(email=email).first():
            flash('El correo ya está registrado', 'danger')
            return redirect(url_for('register'))
        
        if User.query.filter_by(usuario=usuario).first():
            flash('El nombre de usuario ya está en uso', 'danger')
            return redirect(url_for('register'))
        
        # Aquí ejecutamos el INSERT manualmente en SQL
        try:
            # Usamos `text()` para ejecutar una expresión SQL
            query = text("""
                INSERT INTO usuarios (nombre, apellidos, email, usuario, password_hash, fecha_nacimiento, estado, fecha_registro, rol)
                VALUES (:nombre, :apellidos, :email, :usuario, :password_hash, :fecha_nacimiento, :estado, :fecha_registro, :rol)
            """)

            # Parámetros para el INSERT
            params = {
                'nombre': nombre,
                'apellidos': apellidos,
                'email': email,
                'usuario': usuario,
                'password_hash': generate_password_hash(password),
                'fecha_nacimiento': datetime.strptime(fecha_nacimiento, '%Y-%m-%d'),
                'estado': True,
                'fecha_registro': datetime.utcnow(),
                'rol': rol
            }

            # Ejecutar la consulta
            db.session.execute(query, params)
            db.session.commit()
            flash('Registro exitoso, inicia sesión', 'success')
            return redirect(url_for('select_user'))
        except Exception as e:
            db.session.rollback()  # En caso de error, deshacer la transacción
            flash(f'Ocurrió un error al registrar el usuario: {str(e)}', 'danger')
            return redirect(url_for('register'))

    return render_template('register.html')  # Método GET: Muestra el formulario de registro

# Ruta de selección de usuario
@app.route('/select_user')
def select_user():
    # Obtener todos los usuarios registrados
    users = User.query.all()
    return render_template('select_user.html', users=users)

@app.route('/password_for_user/<usuario>', methods=['GET', 'POST'])
def password_for_user(usuario):
    user = User.query.filter_by(usuario=usuario).first()

    if not user:
        flash('Usuario no encontrado', 'danger')
        return redirect(url_for('select_user'))

    if request.method == 'POST':
        password = request.form['password']

        if user.check_password(password):
            session['user_id'] = user.id  # Guarda el ID del usuario en la sesión
            return redirect(url_for('animation'))  # Redirige a la animación
        else:
            flash('Contraseña incorrecta', 'danger')

    return render_template('password_for_user.html', usuario=usuario)

# Ruta de animación (solo si el usuario está autenticado)
@app.route('/animation')
def animation():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    return render_template('animation.html')

# Ruta de home (solo si el usuario está autenticado)
#@app.route('/home')
#def home():
#    if 'user_id' not in session:
#        return redirect(url_for('select_user'))
#    return render_template('home_directory/home.html')
@app.route('/home')
def home():
    if 'user_id' not in session:
        return redirect(url_for('select_user'))

    # Obtener el número de página desde la URL
    page = request.args.get('page', default=1, type=int)

    # Determina la plantilla a cargar
    if page == 1:
        page_name = 'home.html'  # La primera página es home.html
    else:
        page_name = f'Page{page-1}.html'  # A partir de la segunda página, usa Pagina1.html, Pagina2.html, etc.
    
    # Define el total de páginas
    total_pages = 5  # Cambia este número según la cantidad total de páginas que tengas

    return render_template(f'home_directory/{page_name}', page=page, total_pages=total_pages)

# Ruta de profile (solo si el usuario está autenticado)
@app.route('/profile')
def profile():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    # Obtener los datos del usuario autenticado
    user = User.query.get(session['user_id'])

    if not user:
        flash("Usuario no encontrado", "danger")
        return redirect(url_for('login'))

    return render_template('profile.html', user=user)

# Ruta de edit_profile (solo si el usuario está autenticado)
@app.route('/edit_profile', methods=['GET', 'POST'])
def edit_profile():
    if 'user_id' not in session:
        flash("Debes iniciar sesión para editar tu perfil.", "danger")
        return redirect(url_for('login'))

    user = User.query.get(session['user_id'])
    if not user:
        flash("Usuario no encontrado.", "danger")
        return redirect(url_for('profile'))

    if request.method == 'POST':
        new_username = request.form['usuario']
        new_nombre = request.form['nombre']
        new_apellidos = request.form['apellidos']
        new_email = request.form['email']
        current_password = request.form['current_password']
        new_password = request.form['new_password']
        confirm_password = request.form['confirm_password']

        # Verificar si la contraseña actual es correcta
        if not user.check_password(current_password):
            flash("La contraseña actual es incorrecta.", "danger")
            return redirect(url_for('edit_profile'))

        # Verificar si el nuevo usuario o email ya existen (excepto para el mismo usuario actual)
        if User.query.filter(User.usuario == new_username, User.id != user.id).first():
            flash("El nombre de usuario ya está en uso.", "danger")
            return redirect(url_for('edit_profile'))

        if User.query.filter(User.email == new_email, User.id != user.id).first():
            flash("El correo electrónico ya está registrado.", "danger")
            return redirect(url_for('edit_profile'))

        # Actualizar datos del usuario
        user.usuario = new_username
        user.nombre = new_nombre
        user.apellidos = new_apellidos
        user.email = new_email

        # Si se ingresa nueva contraseña, verificar y actualizar
        if new_password:
            if new_password != confirm_password:
                flash("Las nuevas contraseñas no coinciden.", "danger")
                return redirect(url_for('edit_profile'))
            user.password_hash = generate_password_hash(new_password)

        db.session.commit()
        flash("Perfil actualizado con éxito.", "success")
        return redirect(url_for('profile'))

    return render_template('profile_edit.html', user=user)

# Datos de ejemplo para paginar
items = [f"Elemento {i}" for i in range(1, 51)]  # Simula una lista de datos

@app.route('/page/<int:page>')
def paginated_view(page):
    per_page = 10  # Elementos por página
    total_pages = len(items) // per_page + (1 if len(items) % per_page > 0 else 0)

    if page < 1 or page > total_pages:
        flash("Página no encontrada.", "danger")
        return redirect(url_for('paginated_view', page=1))

    start = (page - 1) * per_page
    end = start + per_page
    paginated_items = items[start:end]

    return render_template('home_directory/home.html', items=paginated_items, page=page, total_pages=total_pages)

# Ruta de logout (cierra la sesión del usuario)
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('select_user'))

# Inicia la aplicación Flask
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=4308)
