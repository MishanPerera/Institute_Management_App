// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Developers> developers = [
      Developers('Ninura Jayasekara',
          'I have been Conserve The Blue Application for the past year and I am extremely satisfied with it. The customer support is excellent and the product itself is top-quality. I highly recommend it to anyone in need of a reliable and efficient solution.'),
      Developers('Insaf Nilam',
          'I was skeptical about Conserve The Blue Application  at first, but after using it for a few weeks I am pleasantly surprised. It is easy to use and customize, and it has saved me a lot of time and effort. I will definitely be using it again in the future.'),
      Developers('Mishan Kavindu',
          'Conserve The Blue Application  exceeded my expectations. Not only is it energy efficient, but it is also environmentally friendly. I feel good about using it and will be recommending it to my friends and family.'),
      Developers('Manuka Dahanayake',
          'Conserve The Blue Application  exceeded my expectations. Not only is it energy efficient, but it is also environmentally friendly. I feel good about using it and will be recommending it to my friends and family.'),
    ];

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => ZoomDrawer.of(context)!.toggle()),
          title: Text('About Us'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Name and Logo
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'DevX Institute',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 8),
                    Image.asset(
                      'assets/About.png',
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              ),

              //brief summary
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'We offer a wide range of functionalities to meet the needs of our customers.',
                    style: Theme.of(context).textTheme.bodyText2,
                  )),

              //statement and values
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mission Statement:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Our mission is to provide our customers world standard products and services at affordable prices.',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Values:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text(
                            'Our first objective is to satisfy our customers.'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text("We target incremental improvements"),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text(
                            'We prioritize being truthful and ethical in everything we do.'),
                      ),
                    ],
                  )),

              //Testimonials or reviews
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(8),
                child: Text(
                  'Developers:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: developers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              developers[index].author,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(height: 4),
                            Text(
                              developers[index].text,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //contact information
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('123 Main Street'),
                        subtitle: Text('Malabe, Sri Lanka'),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('+94 11 123 4567'),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('info@devx.com'),
                      ),
                    ],
                  )),

              //social media
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Follow Us:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Facebook'),
                        onTap: () =>
                            launchUrl(Uri.parse('https://www.facebook.com/')),
                      ),
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Twitter'),
                        onTap: () =>
                            launchUrl(Uri.parse('https://www.twitter.com/')),
                      ),
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Instagram'),
                        onTap: () =>
                            launchUrl(Uri.parse('https://www.instagram.com/')),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}

class Developers {
  final String author;
  final String text;

  Developers(this.author, this.text);
}
