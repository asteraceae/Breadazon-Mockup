import os
import secrets
from PIL import Image
from flask import render_template, url_for, flash, redirect, request, abort
from flaskDemo import app, db, bcrypt
from flaskDemo.forms import *
from flaskDemo.models import *
from flask_login import login_user, current_user, logout_user, login_required
from datetime import datetime
import random


@app.route("/")
@app.route("/home")
def home():
    results = Product.query.join(Bakery, Product.bakery_ID == Bakery.bakery_ID).add_columns(Bakery.bakery_ID, Bakery.bakery_name, Product.product_ID, Product.product_name, Product.price, Product.image_file).all()
    return render_template('prod_home.html', outString = results)


@app.route("/home/FILTERS=<filters>")
def filter_home(filters):
    results = Bakery.query.join(Product, Product.bakery_ID == Bakery.bakery_ID).add_columns(Bakery.bakery_ID, Bakery.bakery_name, Product.product_ID, Product.product_name, Product.price, Product.image_file, Product.category).filter_by(category = filters)
    return render_template('prod_home.html', outString = results)

@app.route("/home/FILTERS=<filters>")
def filter_bake(filters):
    results = Product.query.join(Bakery, Product.bakery_ID == Bakery.bakery_ID).add_columns(Bakery.bakery_ID, Bakery.bakery_name, Product.product_ID, Product.product_name, Product.price, Product.image_file, Product.category).filter_by(bakery_name = filters)
    return render_template('prod_home.html', outString = results)



@app.route("/about")
def about():
    return render_template('about.html', title='About Breadazon')


@app.route("/register", methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('home'))
    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        accountid = generate_id("account_ID")
        userid = generate_id("userid")
        user = User_t(id = userid, login = form.login.data, account_ID = accountid, address = form.address.data, city = form.city.data, state = form.state.data, zipcode = form.zip.data, date_created = datetime.utcnow(), name = form.name.data, email = form.email.data, phone_num = form.phone.data, pass_word=hashed_password, paid = "unpaid")
        db.session.add(user)
        db.session.commit()
        flash('Your account has been created! Please pay for your Breadazon Prime subscription', 'success')
        return redirect(url_for('login'))
    return render_template('register.html', title='Register', form=form)

def generate_id(field):
    if field == "account_ID" or field == "userid":
        results = User_t.query.all()
    elif field == "order_ID":
        results = Order.query.all()
    elif field == "payment_ID":
        results = Payment.query.all()
    rand = ''.join([str(random.randint(1, 8)) for x in range (10)])
    id_list = []
    for row in results:
        if field == "account_ID":
            id_list.append(row.account_ID)
        elif field == "userid":
            id_list.append(row.id)
        elif field == "order_ID":
            id_list.append(row.order_ID)
        elif field == "payment_ID":
            id_list.append(row.payment_ID)
    if rand not in id_list:
        return rand
    else:
        generate_id(field)

@app.route("/payment", methods=['GET', 'POST'])
def payment():
    form = PaymentForm()
    if form.validate_on_submit():
        oid = generate_id("order_ID")
        order = Order(order_ID = oid, id = current_user.id, time_submitted = datetime.utcnow())
        db.session.add(order)
        db.session.commit()
        pid = generate_id("payment_ID")
        payment = Payment(payment_ID = pid, order_ID = oid, payment_type = "credit card", billing_address = form.billadd.data, billing_city = form.city.data, billing_state = form.state.data, billing_zipcode = form.zip.data, amount = 10, processing_status = "succeed")
        db.session.add(payment)
        db.session.commit()
        current_user.paid = "paid"
        db.session.commit()
        flash('Thank you for your payment.  Your Breadazon Prime account is now active.', 'success')
        return redirect(url_for('home'))
    return render_template('payment.html', title='Payment', form = form)

@app.route("/login", methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('home'))
    form = LoginForm()
    if form.validate_on_submit():
        user = User_t.query.filter_by(email=form.email.data).first()
        if user and bcrypt.check_password_hash(user.pass_word, form.password.data):
            login_user(user, remember=form.remember.data)
            next_page = request.args.get('next')
            flash('Please activate your account by purchasing for your Breadazon Prime subscription.', 'danger')
            return redirect(url_for('payment')) if user.paid == 'unpaid' else redirect(url_for('home'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
    return render_template('login.html', title='Login', form=form)


@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for('home'))


def save_picture(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(app.root_path, 'static/profile_pics', picture_fn)

    output_size = (125, 125)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)

    return picture_fn


@app.route("/account", methods=['GET', 'POST'])
@login_required
def account():
    form = UpdateAccountForm()
    if form.validate_on_submit():
        current_user.login = form.login.data
        current_user.email = form.email.data
        db.session.commit()
        flash('Your account has been updated!', 'success')
        return redirect(url_for('account'))
    elif request.method == 'GET':
        form.login.data = current_user.login
        form.email.data = current_user.email
    image_file = url_for('static', filename='profile_pics/default.jpg')
    return render_template('account.html', title='Account',
                           image_file=image_file, form=form)


@app.route("/product/<product_id>")
def product(product_id):
    product = Product.query.get_or_404(product_id)
    image_file = url_for('static', filename='breadpics/' + product.image_file)
    return render_template('prod.html', title=Product.product_name, prod = product, now=datetime.utcnow(), image_file=image_file)

@app.route("/mycart")
def cart():
    #product = Product.query.get_or_404(product_id)
    return render_template('shopping_cart.html')

@app.route("/orderhistory")
def orderhistory():
    #order = Order.query.join(Orderline, Product).add_columns(Order.order_ID, Product.product_ID).all()
    order = Product.query.join(Orderline, Order).add_columns(Order.order_ID, Orderline.order_quantity, Product.image_file, Product.product_name, Orderline.order_quantity, Order.time_submitted).filter_by(id = current_user.id)
    return render_template('orderhistory.html', order = order)

@app.route("/checkout", methods=['GET', 'POST'])
def checkout():
    form = CheckoutForm()
    if form.validate_on_submit():
        oid = generate_id("order_ID")
        if current_user.is_authenticated:
            id = current_user.id
        else:
            id = generate_id("userid")
        order = Order(order_ID = oid, id = id,  delivery_address = form.dadd.data, delivery_city = form.dcity.data, delivery_state = form.dstate.data, delivery_zipcode = form.dzip.data, time_submitted = datetime.utcnow())
        db.session.add(order)
        db.session.commit()
        pid = generate_id("payment_ID")
        payment = Payment(payment_ID = pid, order_ID = oid, payment_type = "credit card", billing_address = form.billadd.data, billing_city = form.city.data, billing_state = form.state.data, billing_zipcode = form.zip.data, amount = 10, processing_status = "succeed")
        db.session.add(payment)
        db.session.commit()
        current_user.paid = "paid"
        flash('Thank you for your payment.', 'success')
        return redirect(url_for('home'))
    return render_template('checkout.html', title='Checkout', form = form)
