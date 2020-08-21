from flask_restful import Resource
from flask import request
from Model import db, User
import random
import string

class Register(Resource):
    def get(self):
        users = User.query.all()
        user_list = []
        for i in range(0, len(users)):
            user_list.append(users[i].serialize())
        return {'status': 'success', 'data': str(user_list)}, 200

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400  

        user = User.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message': 'User with the same username already exists'}, 400   

        user = User.query.filter_by(email=json_data['email']).first()
        if user:
            return {'message': 'User with the same email address already exists'}, 400       
        
        # check if username, email exists
        # create api key

        user = User(
            #api_key = api_key,
            firstname = json_data['firstname'],
            lastname = json_data['lastname'],
            email = json_data['email'],
            password = json_data['password'],
            username = json_data['username'],
        )


        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)

        return { "status": 'success', 'data': result }, 201