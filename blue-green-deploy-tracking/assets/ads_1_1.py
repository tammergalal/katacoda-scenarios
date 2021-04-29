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

@app.route('/banners/<pathbanner>')
def banner_image(banner):
    app.logger.info(f"attempting to grab banner at {banner}")
    return send_from_directory('ads', banner)

@app.route('/weighted-banners/<float:weight>')
def weighted_image(weight):
    app.logger.info(f"attempting to grab banner weight of less than {weight}")

    for ad in advertisements:
        if ad.weight < weight:
            return jsonify(ad.serialize())

@app.route('/advertisements', methods=['GET', 'POST'])
def status():
    if flask_request.method == 'GET':

        try:

            app.logger.info(f"Total advertisements available: {len(advertisements)}")
            # adding a half sleep to test something
            time.sleep(2.5)
            return jsonify([b.serialize() for b in advertisments])

        except:
            app.logger.error("An error occured while getting ad.")
            err = jsonify({'error': 'Internal Server Error'})
            err.status_code = 500
            return err

    elif flask_request.method == 'POST':

        try:
            # create a new advertisement with random name and value
            new_advertisement = Advertiseent('Advertisement ' + str(discounts_count + 1),
                                    '/',
                                    random.randint(10,500))
            app.logger.info(f"Adding advertisement {new_advertisement}")
            db.session.add(new_advertisement)
            db.session.commit()

            # adding a half sleep to test something
            time.sleep(2.5)
            return jsonify([b.serialize() for b in advertements])

        except:

            app.logger.error("An error occured while creating a new ad.")
            err = jsonify({'error': 'Internal Server Error'})
            err.status_code = 500
            return err

    else:
        err = jsonify({'error': 'Invalid request method'})
        err.status_code = 405
        return err