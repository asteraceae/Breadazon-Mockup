from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from flask_login import current_user
from wtforms import StringField, PasswordField, SubmitField, BooleanField, TextAreaField, IntegerField, DateField, SelectField, HiddenField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError,Regexp
from wtforms.ext.sqlalchemy.fields import QuerySelectField
from flaskDemo import db
from flaskDemo.models import *
from wtforms.fields.html5 import DateField

#ssns = Department.query.with_entities(Department.mgr_ssn).distinct()
#  or could have used ssns = db.session.query(Department.mgr_ssn).distinct()
# for that way, we would have imported db from flaskDemo, see above

'''myChoices2 = [(row[0],row[0]) for row in ssns]  # change
results=list()
for row in ssns:
    rowDict=row._asdict()
    results.append(rowDict)
myChoices = [(row['mgr_ssn'],row['mgr_ssn']) for row in results]
regex1='^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])'
regex2='|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$'
regex=regex1 + regex2'''
myChoices = []



class RegistrationForm(FlaskForm):
    login = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])

    name = StringField('Name',
                        validators=[DataRequired(), Length(min = 2, max = 30)])

    password = PasswordField('Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm Password',
                                     validators=[DataRequired(), EqualTo('password')])
    phone = StringField('Phone Number',
                        validators=[DataRequired(), Length(min = 10, max = 10)])

    address = StringField('Address Line 1 and 2',
                        validators=[DataRequired(), Length(min = 5, max = 30)])

    city = StringField('City',
                        validators=[DataRequired(), Length(min = 2, max = 20)])
    state = StringField('State (abbreviation)',
                        validators=[DataRequired(), Length(min = 2, max = 2)])
    zip = StringField('Zipcode (5 digits)',
                    validators=[DataRequired(), Length(min = 5, max = 5)])

    submit = SubmitField('Sign Up')

    def validate_username(self, username):
        user = User_t.query.filter_by(login=login.data).first()
        if user:
            raise ValidationError('That username is taken. Please choose a different one.')

    def validate_email(self, email):
        user = User_t.query.filter_by(email=email.data).first()
        if user:
            raise ValidationError('That email is taken. Please choose a different one.')


class LoginForm(FlaskForm):
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember = BooleanField('Remember Me')
    submit = SubmitField('Login')


class UpdateAccountForm(FlaskForm):
    login = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    submit = SubmitField('Update')

    def validate_login(self, login):
        if login.data != current_user.login:
            user = User_t.query.filter_by(login=login.data).first()
            if user:
                raise ValidationError('That username is taken. Please choose a different one.')

    def validate_email(self, email):
        if email.data != current_user.email:
            user = User_t.query.filter_by(email=email.data).first()
            if user:
                raise ValidationError('That email is taken. Please choose a different one.')

class PaymentForm(FlaskForm):
    ccno = StringField('Credit card number',
                        validators=[DataRequired(), Length(min = 16, max = 16)])
    cvv = PasswordField('CVV', validators=[DataRequired(), Length(min = 3, max = 3)])
    billadd = StringField('Billing Address',
                        validators=[DataRequired(), Length(min = 5, max = 40)])
    city = StringField('City',
                        validators=[DataRequired(), Length(min = 5, max = 40)])
    state = StringField('State (abbreviation)',
                        validators=[DataRequired(), Length(min = 2, max = 2)])
    zip = StringField('Zipcode (5 digits)',
                        validators=[DataRequired(), Length(min = 5, max = 5)])
    submit = SubmitField('Submit')

class CheckoutForm(FlaskForm):
    ccno = StringField('Credit card number',
                        validators=[DataRequired(), Length(min = 16, max = 16)])
    cvv = PasswordField('CVV', validators=[DataRequired(), Length(min = 3, max = 3)])
    billadd = StringField('Billing Address',
                        validators=[DataRequired(), Length(min = 5, max = 40)])
    city = StringField('City',
                        validators=[DataRequired(), Length(min = 5, max = 40)])
    state = StringField('State (abbreviation)',
                        validators=[DataRequired(), Length(min = 2, max = 2)])
    zip = StringField('Zipcode (5 digits)',
                        validators=[DataRequired(), Length(min = 5, max = 5)])
    dadd = StringField('Delivery Address',
                        validators=[DataRequired(), Length(min = 5, max = 40)])
    dcity = StringField('Delivery City',
                        validators=[DataRequired(), Length(min = 5, max = 40)])
    dstate = StringField('Delivery State (abbreviation)',
                        validators=[DataRequired(), Length(min = 2, max = 2)])
    dzip = StringField('Delivery Zipcode (5 digits)',
                        validators=[DataRequired(), Length(min = 5, max = 5)])
    submit = SubmitField('Submit')
