from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'users'
    # __table_args__ = tuple(db.UniqueConstraint('id', 'username', name='my_2uniq'))

    id = db.Column(db.Integer(), primary_key=True)
    api_key = db.Column(db.String())
    username = db.Column(db.String(), unique=True)
    firstname = db.Column(db.String())
    lastname = db.Column(db.String())
    password = db.Column(db.String())
    email = db.Column(db.String())

    def __init__(self, api_key, firstname, lastname, email, password, username):
        self.api_key = api_key
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.username = username

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'id': self.id,
            'username': self.username,
            'firstname': self.firstname,
            'lastname': self.lastname,
            'password': self.password,
            'email': self.email,
            'api_key': self.api_key
        }    

class Task(db.Model):
    __tablename__ = 'tasks'
    # __table_args__ = tuple(db.UniqueConstraint('id', 'username', name='my_2uniq'))

    id = db.Column(db.Integer(), primary_key=True)
    user_id = db.Column(db.Integer(), db.ForeignKey('users.id'))
    note = db.Column(db.String())
    completed = db.Column(db.Boolean(), default=False, nullable=False)
    repeat = db.Column(db.String())
    deadline = db.Column(db.String())
    reminder = db.Column(db.String())

    def __init__(self, user_id, note, completed, repeat, deadline, reminder):
        self.user_id = user_id
        self.note = note
        self.completed = completed
        self.repeat = repeat
        self.deadline = deadline
        self.reminder = reminder

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'user_id': self.user_id,
            'note': self.note,
            'repeat': self.repeat,
            'completed': self.completed,
            'reminder': self.reminder,
            'deadline': self.deadline,
            'id': self.id
        }            