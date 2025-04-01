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
@app.route('/home')
def home():
    if 'user_id' not in session:
        return redirect(url_for('select_user'))
    return render_template('home.html')

# Ruta de logout (cierra la sesión del usuario)
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('select_user'))

# Inicia la aplicación Flask
if __name__ == '__main__':
    app.run(debug=True)
