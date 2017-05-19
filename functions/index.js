// Copyright 2017 Google
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const api = require('./walmartAPI');

admin.initializeApp(functions.config().firebase);

exports.addItem = functions.https.onRequest((req, res) => {
  const item = req.query.text;
  admin.database().ref('/wishlist').push({item: item}).then(snapshot => {
    res.redirect(303, snapshot.ref);
  });
});

exports.findPrice = functions.database.ref('/wishlist/{pushId}/item')
		.onWrite(event => {
			const item = event.data.val();
			api.findPriceRange(item, function(minimumPrice, maximumPrice) {
				range = "$" + minimumPrice + " - $" + maximumPrice;
				event.data.ref.parent.child('price').set(range);
			});
			return event.data.ref.parent.child('price').set('retrieving');
		});
