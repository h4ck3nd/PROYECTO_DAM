from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1234@localhost/appusers'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'supersecreto'

db = SQLAlchemy(app)

class User(db.Model):
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

@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        user_input = request.form['username']
        password = request.form['password']
        user = User.query.filter((User.usuario == user_input) | (User.email == user_input)).first()
        
        if user and user.check_password(password):
            user.ultimo_login = datetime.utcnow()
            db.session.commit()
            session['user_id'] = user.id
            session['rol'] = user.rol
            return redirect(url_for('animation'))
        else:
            return "Usuario o contraseña incorrectos", 401  # Muestra el error en caso de que las credenciales sean incorrectas

    return render_template('index.html')  # Método GET: Muestra el formulario de inicio de sesión

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
        
        if password != confirm_password:
            flash('Las contraseñas no coinciden')
        elif User.query.filter_by(email=email).first() or User.query.filter_by(usuario=usuario).first():
            flash('El usuario o correo ya están registrados')
        else:
            new_user = User(
                nombre=nombre, apellidos=apellidos, email=email, 
                usuario=usuario, fecha_nacimiento=datetime.strptime(fecha_nacimiento, '%Y-%m-%d'), rol=rol
            )
            new_user.set_password(password)
            db.session.add(new_user)
            db.session.commit()
            flash('Registro exitoso, inicia sesión')
            return redirect(url_for('login'))  # Redirigir al login después del registro exitoso
    
    return render_template('register.html')  # Método GET: Muestra el formulario de registro

@app.route('/animation')
def animation():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    return render_template('animation.html')

@app.route('/home')
def home():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    return render_template('home.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)
