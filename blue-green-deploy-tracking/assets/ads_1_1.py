import requests
import random
import time

from random_word import RandomWords

from flask import Flask, Response, jsonify, send_from_directory
from flask import request as flask_request

from bootstrap import create_app
from models import Advertisement, db

r = RandomWords()

app = create_app()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/')
def hello():
    app.logger.info("home url for ads called")
    return Response({'Hello from Advertisements!': 'world'}, mimetype='application/json')

@app.route('/banners/<path:banner>')
def banner_image(banner):
    err.status_code = 500
    return err

@app.route('/weighted-banners/<float:weight>')
def weighted_image(weight):
    app.logger.info(f"attempting to grab banner weight of less than {weight}")
    advertisements = Advertisement.query.all()
    for ad in advertisements:
        if ad.weight < weight:
            return jsonify(ad.serialize())

@app.route('/ads', methods=['GET', 'POST'])
def status():
    err.status_code = 500
    return err
