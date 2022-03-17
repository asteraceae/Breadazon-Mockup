from datetime import datetime
from flaskDemo import db, login_manager
from flask_login import UserMixin
from functools import partial
from sqlalchemy import orm

db.Model.metadata.reflect(db.engine)

@login_manager.user_loader
def load_user(id):
    return User_t.query.get(int(id))


class User_t(db.Model, UserMixin):
    __table__ = db.Model.metadata.tables['user_t']

class Post(db.Model):
     __table_args__ = {'extend_existing': True}
     id = db.Column(db.Integer, primary_key=True)
     title = db.Column(db.String(100), nullable=False)
     date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
     content = db.Column(db.Text, nullable=False)
     user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

     def __repr__(self):
         return f"Post('{self.title}', '{self.date_posted}')"

# used for query_factory
#test...
class Employee(db.Model):
    __table__ = db.Model.metadata.tables['employee_t']
class Bakery(db.Model):
    __table__ = db.Model.metadata.tables['bakery_t']
class Orderline(db.Model):
    __table__ = db.Model.metadata.tables['orderline_t']
class Payment(db.Model):
    __table__ = db.Model.metadata.tables['payment_t']
class Product(db.Model):
    __table__ = db.Model.metadata.tables['product_t']
class Order(db.Model):
    __table__ = db.Model.metadata.tables['order_t']
