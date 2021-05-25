## Shopping Cart App

Hey everyone! This is my latest project. The app is an E-commerce app. You can preview products divided into several categories, favourite products to save them for later actions, searching through the app's products, preview featured products, and submit and track orders. The app is ready for market usage with a different database to suit clients' offered products.

It is accomplished by Flutter as the front-end of the app and Google Firebase as the back-end. In this app, I managed to implement clean architecture through three separated layers:
 
 - UI
 - Data Access
 - Core

 The design of the app is inspired from:
 https://www.behance.net/gallery/103614487/iOS-furniture-e-commerce-app-store

# UI Layer
The first layer of the project is the user interface of the applications. It includes all the screens and the widgets used in the app. It also contains any needed structures for managing the UI such as change notifiers.

The screens contained in the app are:
- Home
- Favourites
- Featured Products
- View Category
- My Cart
- My Orders
- Submit Order
- Profile
- Splash Screen
- Login
- Register
- Reset Password
- About Us
- Contact Us

# Data Access Layer
The second layer is the data access layer. Data Access Layer defines the functions for dealing with the data stored in data base. It provides a smooth way of getting and pushing data in the UI layer.

The Data Access Layer includes file for managing each collection of data stored in Firebase Firestore. These collections are:
- Users
- Cart Items
- Categories
- Orders
- Products
- Contact Us Messages

# Core Layer
The very last layer is the Core Layer. The models, classes, for objects used to facilitate data management inside and between the other two layers are stored in this layer. 

The classes included are:
- Product
- Category
- Order
- Orders
- Cart Item
- Cart
- User